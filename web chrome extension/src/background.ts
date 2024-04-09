class AWS {
    run() {
        const portsPairs = new PortsPairsMap()
        chrome.runtime.onConnectExternal.addListener(async (webPagePort) => {
            console.log(`Webpage connected `)

            const origin = webPagePort.sender?.origin

            if (origin === undefined) {
                console.warn(`Webpage port without origin → Ignoring connection.`)
                return
            }

            const portPair = portsPairs.getPair(origin)
            portPair.webpagePort = webPagePort

            portPair.onBothEndClosed = () => {
                console.log(`Connexion released ${origin}`)
                portsPairs.release(origin)
            }

            webPagePort.onDisconnect.addListener((_) => {
                console.log(`WebPage disconnected ${origin}`)
                portPair.webpagePort = null
            })

            portPair.extensionPortResolver.onMessage = (message) => {
                console.log(`Extension response received ${message}`)
                webPagePort.postMessage(message)
            }

            webPagePort.onMessage.addListener((message) => {
                console.log(`Webpage message received : ${message} from ${origin}`)
                portPair.extensionPortResolver.waitForConnection((port) => {
                    port.postMessage(message)
                })
            })
        })

    }
}

class PortsPairsMap {
    extensionPortResolvers: Map<string, PortPair> = new Map()

    getPair(id: string): PortPair {
        const extensionPortResolver = this.extensionPortResolvers.get(id)
        if (extensionPortResolver !== undefined) return extensionPortResolver

        const newPortPair = new PortPair()

        this.extensionPortResolvers.set(id, newPortPair)
        return newPortPair
    }

    release(id: string) {
        this.extensionPortResolvers.delete(id)
    }
}


class PortPair {
    #webpagePort: chrome.runtime.Port | null = null
    #extensionPortResolver: ExtensionPortResolver

    onBothEndClosed = () => { }

    constructor() {
        this.#extensionPortResolver = new ExtensionPortResolver()
        this.#extensionPortResolver.onDisconnect = () => {
            this._dispatchStatusEvent()
        }
    }

    get extensionPortResolver(): ExtensionPortResolver {
        return this.#extensionPortResolver
    }

    get webpagePort(): chrome.runtime.Port | null {
        return this.#webpagePort
    }

    set webpagePort(port: chrome.runtime.Port | null) {
        this.#webpagePort = port;
        this._dispatchStatusEvent()
    }

    _dispatchStatusEvent() {
        if (this.#webpagePort === null && !this.#extensionPortResolver.isExtensionAlive) {
            this.onBothEndClosed();
        }
    }

}


class ExtensionPortResolver {
    #extensionPopupPort: chrome.runtime.Port | null = null
    #extensionWindow: chrome.windows.Window | null = null
    #callbacksWaitingForConnection: Array<(port: chrome.runtime.Port) => undefined> = []

    onDisconnect = () => { }
    onReady = () => { }
    onMessage = (message: any) => { }

    get isExtensionAlive() {
        return this.#extensionWindow !== null
    }

    constructor() {
        chrome.runtime.onConnect.addListener(async (port) => {
            if (this.#extensionPopupPort !== null) return;

            console.log('Extension popup connected')
            this.#extensionPopupPort = port

            this.onReady()
            for (const callback of this.#callbacksWaitingForConnection) {
                console.log('Resolving callback')
                callback(this.#extensionPopupPort)
            }
            this.#callbacksWaitingForConnection = []
            console.log('Callbacks resolving done')

            this.#extensionPopupPort.onMessage.addListener((message) => {
                this.onMessage(message)
            })
            this.#extensionPopupPort.onDisconnect.addListener(() => {
                console.log('Extension popup disconnected')
                this.#extensionPopupPort = null
                this.onDisconnect()
            })
            console.log('Extension popup ready')
        })
    }

    get port(): chrome.runtime.Port | null {
        return this.#extensionPopupPort
    }

    waitForConnection(callback: (port: chrome.runtime.Port) => undefined) {
        if (this.#extensionPopupPort !== null) {
            console.log('Extension popup ready')
            callback(this.#extensionPopupPort)
            return
        }

        this.#callbacksWaitingForConnection.push(callback)

        if (this.#extensionWindow !== null) {
            console.log('Extension popup already exists.')
            return
        }

        console.log('Opening extension popup')

        chrome.windows.create({
            url: "index.html",
            width: 370,
            height: 800,
            type: "panel",
            focused: true,
        }).then((window) => {
            this.#extensionWindow = window
        });
        chrome.windows.onRemoved.addListener((windowId) => {
            if (this.#extensionWindow?.id === windowId) {
                this.#extensionWindow = null;
            }
        })
    }
}
const aws = new AWS()
aws.run()
