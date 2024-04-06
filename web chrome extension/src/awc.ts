var rawParams = document.currentScript?.dataset.params
var extensionId = rawParams === undefined ? null : JSON.parse(rawParams).extensionId
var port: chrome.runtime.Port | null = null

export function connect() {
    if (port !== null) {
        console.log("[AWC] Already connected");
        return;
    }
    console.log("[AWC] Connecting");
    port = chrome.runtime.connect(extensionId)
    onConnect()
    port.onMessage.addListener(onMessage)
}

export var onConnect = () => {
    console.log(`[AWC] Connected`)
}

export var onMessage = (message: any) => {
    console.log(`[AWC] message received : ${JSON.stringify(message)}`)
}

export function postMessage(message: any) {
    port?.postMessage(message)
}