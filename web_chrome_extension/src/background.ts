chrome.runtime.onMessageExternal.addListener((message, sender, sendResponse) => {
    if (message === 'ensureExtensionPopupOpened') {
        ensureExtensionPopupOpened().then(() => { sendResponse() })
        return true
    }
})

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
})

chrome.action.onClicked.addListener(async function (_) {
    await openExtensionPopup()
});


function extensionUrl(): string {
    return `chrome-extension://${chrome.runtime.id}/index.html`
}

/**
 * @returns {boolean} true if a extension popup has been focused
 */
async function focusExtensionPopup(): Promise<boolean> {
    const extensionTab = await findExtensionTab()
    if (extensionTab !== null) {
        await chrome.windows.update(
            extensionTab.windowId,
            { focused: true },
        )
        if (extensionTab.id !== undefined) {
            await chrome.tabs.update(
                extensionTab.id,
                { active: true },
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

async function openExtensionPopup(): Promise<void> {
    if (await focusExtensionPopup()) {
        return
    }

    const currentWindow = await chrome.windows.getCurrent();

    const popupWidth = 370
    const popupHeight = 800

    const left = Math.round((currentWindow.left ?? 200) + (currentWindow.width ?? 0) - popupWidth - 32);
    const top = Math.round((currentWindow.top ?? 200) + 64);

    await chrome.windows.create({
        url: "index.html",
        width: popupWidth,
        height: popupHeight,
        type: "panel",
        focused: true,
        left: left,
        top: top,
    })
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
