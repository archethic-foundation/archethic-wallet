declare function findExtensionWindowId(): Promise<number | null>;
declare function openExtensionPopup(): Promise<void>;
declare function extensionPopupExists(): Promise<Boolean>;
declare function isExtensionPopupReady(): Promise<Boolean>;
declare function waitForExtensionPopup(): Promise<void>;
