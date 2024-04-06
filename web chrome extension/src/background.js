class AWS {
    #extensionPageConnectionResolver = new ExtensionPageConnectionResolver()
    run() {
        chrome.runtime.onConnectExternal.addListener(async (webPagePort) => {
            console.log('Webpage connected')
            webPagePort.onMessage.addListener((message) => {
                console.log('Message received')
                this.#extensionPageConnectionResolver.waitForConnection((isNew, extensionPagePort) => {
                    if (isNew) {
                        extensionPagePort.onMessage.addListener((message) => {
                            console.log(`Response received ${message}`)
                            webPagePort.postMessage(message)
                        })
                    }
                    extensionPagePort.postMessage(message)
                });
            })
        })
    }
}

class ExtensionPageConnectionResolver {
    #extensionPopupPort = null

    #callbacksWaitingForConnection = []

    constructor() {

        chrome.runtime.onConnect.addListener(async (port) => {
            console.log('Extension popup connected')
            this.#extensionPopupPort = port

            for (const callback of this.#callbacksWaitingForConnection) {
                console.log('Resolving callback')
                callback(true, this.#extensionPopupPort)
            }
            this.#callbacksWaitingForConnection = []
            console.log('Callbacks resolving done')

            this.#extensionPopupPort.onDisconnect.addListener(() => {
                console.log('Extension popup disconnected')
                this.#extensionPopupPort = null
            })
            console.log('Extension popup ready')
            return
        })
    }

    /**
     * 
     * @param {Function(isNew: boolean, port: Port)} callback 
     * @returns 
     */
    waitForConnection(callback) {
        if (this.#extensionPopupPort != null) {
            console.log('Extension popup ready')
            callback(false, this.#extensionPopupPort)
            return
        }
        this.#callbacksWaitingForConnection.push(callback)
        console.log('Opening extension popup')
        chrome.windows.create({ url: "index.html", width: 370, height: 800, type: "panel" });
    }
}
const aws = new AWS()
aws.run()
