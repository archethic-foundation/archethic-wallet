chrome.runtime.onInstalled.addListener(async (details) => {
    console.debug(`Installed extension`)
    await writeWindowClosed()
})

chrome.runtime.onMessageExternal.addListener((message, sender, sendResponse) => {
    if (message === 'ensureExtensionPopupOpened') {
        ensureExtensionPopupOpened().then(() => { sendResponse() })
        return true
    }
    if (message.action === "openExtensionPopup") {
        openExtensionPopup().then(() => {
            sendResponse({ status: "Popup opened" })
        })
        return true
    }
})

chrome.tabs.onCreated.addListener(async (tab) => {
    console.debug(`Opened tab ${tab.id}`)
    await handleManuallyOpenedTab(tab)
})

chrome.tabs.onUpdated.addListener(async (tabId, changeInfo, tab) => {
    console.debug(`Updated tab ${tab.id}`)
    await handleManuallyOpenedTab(tab)
})

chrome.tabs.onRemoved.addListener(async (tabId) => {
    console.debug(`Closed tab ${tabId}`)
    const currentTabId = await openedTabId()
    if (tabId === currentTabId) {
        await writeWindowClosed()
        await updateExtensionIcon(true)
    }
})

chrome.action.onClicked.addListener(async function (_) {
    console.debug(`Clicked extension icon`)
    await openExtensionPopup()
});


async function handleManuallyOpenedTab(tab: chrome.tabs.Tab) {
    if (!tab.url?.startsWith(`chrome-extension://${chrome.runtime.id}`)) {
        return
    }

    if (await isExtensionPopupOpening()) {
        return
    }

    const openedExtensionTabId = await openedTabId()
    if (tab.id === openedExtensionTabId) {
        return
    }

    // si extension pas ouverte, on l'ouvre
    if (openedExtensionTabId === undefined) {
        await chrome.tabs.remove(tab.id!)
        await openExtensionPopup(tab.url)
        return
    }

    // si extension ouverte, on change son url
    // const extensionTab = await findExtensionTab()


    const openedExtensionTab = await chrome.tabs.get(openedExtensionTabId)
    if (openedExtensionTab.url !== tab.url) {
        await chrome.tabs.update(
            openedExtensionTabId,
            {
                active: true,
                url: tab.url,
            },
        )
    }
}

chrome.runtime.onMessage.addListener((message, sender, sendResponse) => {
    if (message === 'areMultipleExtensionPopupsOpened') {
        areMultipleExtensionPopupsOpened().then((response) => {
            sendResponse(response)
        })
        return true
    }
    if (message === 'focusExtensionPopup') {
        focusExtensionPopup().then((response) => {
            sendResponse(response)
        })
        return true
    }
    if (message.type === "updateIcon" && typeof message.isLocked === "boolean") {
        const isLocked = message.isLocked;
        updateExtensionIcon(isLocked);
        return false;
    }
})


function extensionUrl(): string {
    return `chrome-extension://${chrome.runtime.id}/index.html`
}

/**
 * @returns {boolean} true if a extension popup has been focused
 */
async function focusExtensionPopup(url?: string | undefined): Promise<boolean> {
    const extensionTab = await findExtensionTab()
    if (extensionTab !== null) {
        await chrome.windows.update(
            extensionTab.windowId,
            { focused: true },
        )
        if (extensionTab.id !== undefined) {
            await chrome.tabs.update(
                extensionTab.id,
                {
                    active: true,
                    url: url,
                },
            )
        }
        return true
    }
    return false
}

async function findExtensionTab(): Promise<chrome.tabs.Tab | null> {
    const extensionTabs = await chrome.tabs.query({ url: extensionUrl() })

    if (extensionTabs.length === 0) return null
    return extensionTabs[0]
}

async function openExtensionPopup(url?: string | undefined): Promise<void> {
    if (await focusExtensionPopup(url)) {
        return
    }

    const currentWindow = await chrome.windows.getCurrent();

    const popupWidth = 370
    const popupHeight = 800

    const left = Math.round((currentWindow.left ?? 200) + (currentWindow.width ?? 0) - popupWidth - 32);
    const top = Math.round((currentWindow.top ?? 200) + 64);

    await writeExtensinPopupOpening()
    const window = await chrome.windows.create({
        url: url ?? "index.html",
        width: popupWidth,
        height: popupHeight,
        type: "panel",
        focused: true,
        left: left,
        top: top,
    })
    const tab = window.tabs![0]
    await writeExtensionPopupOpened(tab.id!)
}

async function writeExtensinPopupOpening() {
    await chrome.storage.local.set({ extensionWindowOpening: true });
}
async function writeWindowClosed() {
    await chrome.storage.local.remove(["extensionTabId", "extensionWindowOpening"])
}
async function writeExtensionPopupOpened(tabId: number) {
    await chrome.storage.local.set({ extensionTabId: tabId, extensionWindowOpening: false, })
}
async function openedTabId(): Promise<number | undefined> {
    const values = await chrome.storage.local.get(["extensionTabId"])
    return values.extensionTabId
}
async function openedWindowId(): Promise<number | undefined> {
    const tabId = await openedTabId()
    if (tabId === undefined) return undefined
    const tab = await chrome.tabs.get(tabId)
    if (tab === undefined) return undefined

    return tab.windowId
}

async function openedWindow(): Promise<chrome.windows.Window | undefined> {
    const windowId = await openedWindowId()
    if (windowId === undefined) return undefined

    return chrome.windows.get(windowId)
}

async function isExtensionPopupOpening(): Promise<Boolean> {
    const values = await chrome.storage.local.get(["extensionWindowOpening"])
    return values.extensionWindowOpening === true
}
async function isExtensionPopupOpened(): Promise<boolean> {
    return (await findExtensionTab()) !== null
}

async function areMultipleExtensionPopupsOpened(): Promise<boolean> {
    const extensionTabs = await chrome.tabs.query({ url: extensionUrl() })
    return extensionTabs.length > 1
}

async function ensureExtensionPopupOpened() {
    if (await isExtensionPopupOpened()) {
        return
    }
    await openExtensionPopup()
}
async function updateExtensionIcon(isLocked: boolean): Promise<void> {
    const iconPath = isLocked
        ? {
            "16": "icons/icon_16_locked.png",
            "32": "icons/icon_32_locked.png",
            "48": "icons/icon_48_locked.png",
            "128": "icons/icon_128_locked.png"
        }
        : {
            "16": "icons/icon_16.png",
            "32": "icons/icon_32.png",
            "48": "icons/icon_48.png",
            "128": "icons/icon_128.png"
        };

    await chrome.action.setIcon({ path: iconPath });
}
