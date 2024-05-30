chrome.runtime.onMessageExternal.addListener(async (message, sender, sendResponse) => {
    if (message === 'ensureExtensionPopupOpened') {
        await ensureExtensionPopupOpened()
        sendResponse()
    }
})

async function findExtensionWindowId(): Promise<number | null> {
    const extensionTabs = await chrome.tabs.query({ url: `chrome-extension://${chrome.runtime.id}/index.html` })

    if (extensionTabs.length === 0) return null
    return extensionTabs[0].windowId
}

async function openExtensionPopup(): Promise<void> {
    const extensionWindowId = await findExtensionWindowId()
    if (extensionWindowId !== null) {
        console.log('Extension popup already exists.')
        chrome.windows.update(
            extensionWindowId!,
            { focused: true },
        )
        return
    }

    chrome.windows.getCurrent(function (currentWindow) {
        let left = Math.round((currentWindow.left ?? 200) + (currentWindow.width ?? 0) / 2);
        let top = Math.round((currentWindow.top ?? 200) + (currentWindow.height ?? 0) / 2);

        chrome.windows.create({
            url: "index.html",
            width: 370,
            height: 800,
            type: "panel",
            focused: true,
            left: left,
            top: top,
        })
    })
}

async function isExtensionPopupOpened(): Promise<boolean> {
    return (await findExtensionWindowId()) !== null
}

async function ensureExtensionPopupOpened() {
    if (await isExtensionPopupOpened()) {
        return
    }
    await openExtensionPopup()
}
