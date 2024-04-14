chrome.runtime.onMessageExternal.addListener((message, sender, sendResponse) => {
    if (message === 'waitForExtensionPopup') {
        waitForExtensionPopup().then(() => {
            sendResponse()
        })
    }
})

async function findExtensionWindowId(): Promise<number | null> {
    const extentionTabs = await chrome.tabs.query({ url: `chrome-extension://${chrome.runtime.id}/index.html` })

    if (extentionTabs.length === 0) return null
    return extentionTabs[0].windowId
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

    chrome.windows.create({
        url: "index.html",
        width: 370,
        height: 800,
        type: "panel",
        focused: true,
    })
}

async function extensionPopupExists(): Promise<Boolean> {
    return (await findExtensionWindowId()) !== null
}

async function isExtensionPopupReady(): Promise<Boolean> {
    if (await extensionPopupExists()) {
        return await chrome.runtime.sendMessage('isExtensionPopupReady');
    }
    return false
}

async function waitForExtensionPopup() {
    return new Promise<void>(async (resolve, reject) => {
        if (await isExtensionPopupReady()) {
            resolve()
            return
        }

        const _extensionPopupReadyListener = (message: any) => {
            if (message === 'extensionPopupReady') {
                console.log('Extension popup ready')
                chrome.runtime.onMessage.removeListener(_extensionPopupReadyListener)
                resolve()
            }
        }

        chrome.runtime.onMessage.addListener(_extensionPopupReadyListener)
        openExtensionPopup()
    })
}
