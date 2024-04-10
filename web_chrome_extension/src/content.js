const s = document.createElement('script');
s.dataset.params = JSON.stringify({ extensionId: chrome.runtime.id })
s.src = chrome.runtime.getURL('archethic.js');
s.onload = function () { this.remove(); };
// see also "Dynamic values in the injected code" section in this answer
(document.head || document.documentElement).appendChild(s);
