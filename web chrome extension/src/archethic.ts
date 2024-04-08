import { AWCWebBrowserExtensionStreamChannel, ArchethicWalletClient } from "@archethicjs/sdk";

var rawParams = document.currentScript?.dataset.params
var extensionId = rawParams === undefined ? null : JSON.parse(rawParams).extensionId


/**
 * Transport (low level communication) object to communicate with Archethic Wallet browser extension
 */
export const streamChannel = extensionId ? new AWCWebBrowserExtensionStreamChannel(extensionId) : undefined;

/**
 * High level AWC to send AWC RPC to Archethic Wallet browser extension
 */
export const awc = streamChannel ? new ArchethicWalletClient(streamChannel) : undefined

