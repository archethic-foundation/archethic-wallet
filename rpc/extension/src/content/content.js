// import { ArchethicRPCClient, ConnectionState, DefaultArchethicRPCClient, InvalidStateError } from 'archethic_wallet_rpc_client';

// let scriptElement = document.createElement('script')

// scriptElement.innerHTML = `console.log("ContentScript executé"); ConnectionState = ${JSON.stringify(ConnectionState)}; ${InvalidStateError}; ${ArchethicRPCClient}; ${DefaultArchethicRPCClient}; window.archethic = new DefaultArchethicRPCClient();`
// document.head.appendChild(scriptElement)

console.log("ContentScript start");


/**
 * Injects a script tag into the current document
 *
 * @param {string} content - Code to be executed in the current document
 */
function injectScript(content) {
    try {
        const container = document.head || document.documentElement;
        const scriptTag = document.createElement('script');
        scriptTag.setAttribute('async', 'false');
        scriptTag.textContent = content;
        container.insertBefore(scriptTag, container.children[0]);
        container.removeChild(scriptTag);
    } catch (error) {
        console.error('MetaMask: Provider injection failed.', error);
    }
}
console.log("ContentScript start 0");

// const fs = require('fs');
// const path = require('path');

// console.log("ContentScript start 1");
// const inpageContent = fs.readFileSync(
//     path.join(__dirname, 'inpage.js'),
//     'utf8',
// );
// console.log("ContentScript start 2");
// const inpageSuffix = `//# sourceURL=${browser.runtime.getURL('inpage.js')}\n`;
// const inpageBundle = inpageContent + inpageSuffix;

// console.log("ContentScript start 3");
// injectScript(inpageBundle)
console.log("ContentScript done");