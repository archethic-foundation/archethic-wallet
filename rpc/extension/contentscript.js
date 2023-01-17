// console.log("ContentScript executé")

// const injectionScript = `
// console.log("Injection executée")
// window.monObjet = 'Objet injecté'
// `
// chrome.tabs.executeScript({
//     code: injectionScript
// });

// browser.runtime.onInstalled.addListener(function () {
//     browser.tabs.executeScript({
//         code: injectionScript
//     });
// });

// monObjet = 'Objet injecté'

let scriptElement = document.createElement('script')
scriptElement.innerText = 'console.log("ContentScript executé"); window.monObjet = "Objet injecté";'
document.head.appendChild(scriptElement)

// window.eval('console.log("ContentScript executé"); window.monObjet = "Objet injecté";')