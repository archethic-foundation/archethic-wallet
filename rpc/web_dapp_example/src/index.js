import { DefaultArchethicRPCClient, TokenTransaction } from 'archethic_wallet_rpc_client';

console.log("ContentScript executé");
const archethic = new DefaultArchethicRPCClient();
archethic.connect('localhost', 12345)
    .then(() => {
        return archethic.sendTokenTransaction(new TokenTransaction())
    }).then((_) => {
        console.log(`Token transaction sent !`)
    }).catch((error) => {
        console.log(`Send token transaction failed : ${error}`)
    })