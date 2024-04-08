class AWS {
    run() {
        const extensionPortMap = new ExtensionPortsMap()
        chrome.runtime.onConnectExternal.addListener(async (webPagePort) => {
            console.log(`Webpage connected `)

            const transmitFromExtensionToWebPage = (message) => {
                console.log(`Extension response received ${message}`)
                webPagePort.postMessage(message)
                console.log(`Extension response transmitted`)
            }

            webPagePort.onMessage.addListener((message) => {
                console.log(`Webpage message received : ${message}`)
                extensionPortMap.getPort(
                    webPagePort.sender.origin,
                    (extensionPagePort) => {
                        extensionPagePort.onMessage.addListener(transmitFromExtensionToWebPage)
                        webPagePort.onDisconnect.addListener((_, __) => {
                            console.log(`Webpage disconnected`)
                            extensionPagePort.onMessage.removeListener(transmitFromExtensionToWebPage);
                        })
                        extensionPagePort.postMessage(message)
                    });
            })

        })
    }
}

class ExtensionPortsMap {
    extensionPortResolvers = {}

    getPort(id, callback) {
        this.#getExtensionPortResolver(id).waitForConnection((port) => {
            callback(port);
        })
    }

    #releaseExtensionPortResolver(id) {
        this.extensionPortResolvers[id] = undefined
    }

    #getExtensionPortResolver(id) {
        const extensionPortResolver = this.extensionPortResolvers[id]
        if (extensionPortResolver !== undefined) return extensionPortResolver

        const newExtensionPortResolver = new ExtensionPortResolver()
        newExtensionPortResolver.onDisconnect = () => {
            console.log(`Extension port released for ${id}`)
            this.#releaseExtensionPortResolver(id)
        }
        console.log(`Extension port created for ${id}`)
        this.extensionPortResolvers[id] = newExtensionPortResolver
        return newExtensionPortResolver
    }
}

class ExtensionPortResolver {
    #extensionPopupPort = null

    #callbacksWaitingForConnection = []

    constructor() {

        chrome.runtime.onConnect.addListener(async (port) => {
            console.log('Extension popup connected')
            this.#extensionPopupPort = port

            for (const callback of this.#callbacksWaitingForConnection) {
                console.log('Resolving callback')
                callback(this.#extensionPopupPort)
            }
            this.#callbacksWaitingForConnection = []
            console.log('Callbacks resolving done')

            this.#extensionPopupPort.onDisconnect.addListener(() => {
                console.log('Extension popup disconnected')
                this.#extensionPopupPort = null
                this.onDisconnect()
            })
            console.log('Extension popup ready')
            return
        })
    }

    onDisconnect = () => { }

    /**
     * 
     * @param {Function(port: Port)} callback 
     * @returns 
     */
    waitForConnection(callback) {
        if (this.#extensionPopupPort != null) {
            console.log('Extension popup ready')
            callback(this.#extensionPopupPort)
            return
        }
        this.#callbacksWaitingForConnection.push(callback)
        console.log('Opening extension popup')
        chrome.windows.create({ url: "index.html", width: 370, height: 800, type: "panel" });
    }
}
const aws = new AWS()
aws.run()
