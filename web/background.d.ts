declare function findExtensionWindowId(): Promise<number | null>;
declare function openExtensionPopup(): Promise<void>;
declare function extensionPopupExists(): Promise<boolean>;
declare function isExtensionPopupReady(): Promise<boolean>;
declare function waitForExtensionPopup(): Promise<void>;
