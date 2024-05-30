
(async function popupSingletonGuard() {
    document.addEventListener('DOMContentLoaded', async function () {
        await chrome.runtime.sendMessage(
            'areMultipleExtensionPopupsOpened',
            (areMultipleExtensionPopupsOpened) => {
                if (areMultipleExtensionPopupsOpened) {
                    chrome.runtime.sendMessage('focusExtensionPopup')
                    window.close()
                }
            }
        )
    })
})()