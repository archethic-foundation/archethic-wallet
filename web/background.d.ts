/// <reference types="chrome" />
declare class AWS {
    run(): void;
}
declare class PortsPairsMap {
    extensionPortResolvers: Map<string, PortPair>;
    getPair(id: string): PortPair;
    release(id: string): void;
}
declare class PortPair {
    #private;
    onBothEndClosed: () => void;
    constructor();
    get extensionPortResolver(): ExtensionPortResolver;
    get webpagePort(): chrome.runtime.Port | null;
    set webpagePort(port: chrome.runtime.Port | null);
    _dispatchStatusEvent(): void;
}
declare class ExtensionPortResolver {
    #private;
    onDisconnect: () => void;
    onReady: () => void;
    onMessage: (message: any) => void;
    get isExtensionAlive(): boolean;
    constructor();
    get port(): chrome.runtime.Port | null;
    waitForConnection(callback: (port: chrome.runtime.Port) => undefined): void;
}
declare const aws: AWS;
