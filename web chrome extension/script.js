class AWC {
    static #extensionId = JSON.parse(document.currentScript.dataset.params).extensionId
    #port = null

    connect() {
        console.log("[AWC] Connecting");
        this.#port = chrome.runtime.connect(AWC.#extensionId)
        this.onConnect()
        this.#port.onMessage.addListener(this.onMessage)
    }

    onConnect = () => {
        console.log(`[AWC] Connected`)
    }

    onMessage = (message) => {
        console.log(`[AWC] message received : ${JSON.stringify(message)}`)
    }

    postMessage(message) {
        this.#port.postMessage(message)
    }
}

const awc = new AWC()