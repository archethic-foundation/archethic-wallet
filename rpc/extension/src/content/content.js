import sendTx from 'archethic_wallet_rpc_client'

let scriptElement = document.createElement('script')
scriptElement.innerText = `console.log("ContentScript executé"); window.sendTx = ${sendTx};`
document.head.appendChild(scriptElement)
