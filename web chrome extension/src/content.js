
// (async () => {
//     console.log("[AWC] Init webmessage");
//     const port = chrome.runtime.connect()

//     document.addEventListener('awc.postMessage', async function (e) {
//         await port.postMessage(e)
//         console.log(`[CS EventListener] message sent : ${JSON.stringify(e)}`)
//     })

//     port.onMessage.addListener((message) => {
//         console.log(`[CS EventListener] message received : ${JSON.stringify(message)}`)
//         document.dispatchEvent(new CustomEvent('awc.onMessage', message))
//     })


// })()

var s = document.createElement('script');
s.dataset.params = JSON.stringify({ extensionId: chrome.runtime.id })
s.src = chrome.runtime.getURL('archethic.js');
s.onload = function () { this.remove(); };
// see also "Dynamic values in the injected code" section in this answer
(document.head || document.documentElement).appendChild(s);
