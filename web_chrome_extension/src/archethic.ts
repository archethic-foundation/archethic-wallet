import { ArchethicWalletClient, AWCStreamChannel, AWCStreamChannelState } from "@archethicjs/sdk";

var rawParams = document.currentScript?.dataset.params
var extensionId = rawParams === undefined ? null : JSON.parse(rawParams).extensionId



class AWCWebBrowserExtensionStreamChannel implements AWCStreamChannel<string> {
    private extensionId: string
    private _port: chrome.runtime.Port | null = null
    private _state: AWCStreamChannelState = AWCStreamChannelState.CLOSED

    constructor(extensionId: string | undefined) {
        if (extensionId === undefined) throw new Error('Archethic Wallet Web extension not available')
        this.extensionId = extensionId
    }

    async connect(): Promise<void> {
        if (this._port !== null) {
            console.log(`[AWC] Popup extension already running`)
            return
        }

        this._state = AWCStreamChannelState.CONNECTING

        console.log(`[AWC] Wait for popup extension ...`)
        await chrome.runtime.sendMessage(this.extensionId, 'ensureExtensionPopupOpened')
        console.log(`[AWC] ... opened`)

        console.log(`[AWC] Connecting to popup extension ...`)
        this._port = chrome.runtime.connect(this.extensionId)
        this._port.onDisconnect.addListener(() => {
            this._port = null
            this._connectionClosed()
        })
        this._port.onMessage.addListener((message: string, _) => {
            if (message === 'connected') {
                this._connectionReady()
                return

            }
            console.log(`[AWC] Received message ${message}`)
            if (this.onReceive !== null) this.onReceive(message)
        })
    }

    _connectionClosed() {
        console.log(`[AWC] Connection closed`)
        this._state = AWCStreamChannelState.CLOSED
        if (this.onClose !== null) this.onClose('')
    }

    _connectionReady() {
        console.log(`[AWC] Connection ready`)
        this._state = AWCStreamChannelState.OPEN
        if (this.onReady !== null) this.onReady()
    }

    async close(): Promise<void> {
        this._port?.disconnect()
        this._connectionClosed()
    }

    async send(data: string): Promise<void> {
        if (this._port == null) {
            throw "[AWC] Disconnected"
        }
        await this._port.postMessage(data)
    }

    public onReceive: ((data: string) => Promise<void>) | null = null

    public onReady: (() => Promise<void>) | null = null

    public onClose: ((reason: string) => Promise<void>) | null = null

    get state(): AWCStreamChannelState {
        return this._state
    }
}


/**
 * Transport (low level communication) object to communicate with Archethic Wallet browser extension
 */
export const streamChannel = extensionId ? new AWCWebBrowserExtensionStreamChannel(extensionId) : undefined;

/**
 * High level AWC to send AWC RPC to Archethic Wallet browser extension
 */
export const awc = streamChannel ? new ArchethicWalletClient(streamChannel) : undefined

