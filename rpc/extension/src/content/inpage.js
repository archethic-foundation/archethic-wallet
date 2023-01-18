import { DefaultArchethicRPCClient } from 'archethic_wallet_rpc_client';

function init() {
    console.log("InpageScript start");
    window.archethic = new DefaultArchethicRPCClient();
    console.log("InpageScript done");
}