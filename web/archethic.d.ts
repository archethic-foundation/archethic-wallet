import { ArchethicWalletClient, AWCStreamChannel, AWCStreamChannelState } from "@archethicjs/sdk";
declare class AWCWebBrowserExtensionStreamChannel implements AWCStreamChannel<string> {
    private extensionId;
    private _port;
    private _state;
    constructor(extensionId: string | undefined);
    connect(): Promise<void>;
    _connectionClosed(): void;
    _connectionReady(): void;
    close(): Promise<void>;
    send(data: string): Promise<void>;
    onReceive: ((data: string) => Promise<void>) | null;
    onReady: (() => Promise<void>) | null;
    onClose: ((reason: string) => Promise<void>) | null;
    get state(): AWCStreamChannelState;
}
export declare const streamChannel: AWCWebBrowserExtensionStreamChannel | undefined;
export declare const awc: ArchethicWalletClient | undefined;
export {};
