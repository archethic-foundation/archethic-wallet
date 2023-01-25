import { JSONRPCClient, JSONRPCServer, JSONRPCServerAndClient } from "json-rpc-2.0"

enum ConnectionState {
    Closed,
    Closing,
    Connecting,
    Open,
}

class InvalidStateError extends Error {

}

class TokenTransaction {

}

class TransactionSuccess {

}


class TransactionFailure {

}

abstract class ArchethicRPCClient {
    abstract connect(host: string, port: number): Promise<void>
    abstract close(): Promise<void>
    abstract get connectionState(): ConnectionState

    abstract sendTokenTransaction(transaction: TokenTransaction): Promise<TransactionSuccess>
}

class DefaultArchethicRPCClient implements ArchethicRPCClient {
    webSocket: WebSocket | undefined
    client: JSONRPCServerAndClient | undefined
    connect(host: string, port: number): Promise<void> {
        return new Promise<void>((resolve, reject) => {
            if (this.connectionState != ConnectionState.Closed) {
                return reject(new InvalidStateError("Connection already established. Cancelling new connection request"))
            }
            this.webSocket = new WebSocket(`ws://${host}:${port}`)

            this.client = new JSONRPCServerAndClient(
                new JSONRPCServer(),
                new JSONRPCClient((request) => {
                    console.log(`Client received request ${JSON.stringify(request)}`)
                    try {
                        this.webSocket?.send(JSON.stringify(request))
                        return Promise.resolve()
                    } catch (error) {
                        console.log(error)
                        return Promise.reject(error)
                    }
                })
            )

            this.webSocket.onmessage = (event) => {
                this.client?.receiveAndSend(JSON.parse(event.data.toString()))
            }



            // On close, make sure to reject all the pending requests to prevent hanging.
            this.webSocket.onclose = (event) => {
                this.client?.rejectAllPendingRequests(
                    `Connection is closed (${event.reason}).`
                )
                this.close()
            }

            this.webSocket.onopen = (event) => {
                resolve();
            }
        })
    }

    async close(): Promise<void> {
        this.webSocket?.close()
        this.client = undefined
        this.webSocket = undefined
    }

    get connectionState(): ConnectionState {
        const state = this.webSocket?.readyState
        switch (state) {
            case WebSocket.CLOSING:
                return ConnectionState.Closing
            case WebSocket.CONNECTING:
                return ConnectionState.Connecting
            case WebSocket.OPEN:
                return ConnectionState.Open
        }
        return ConnectionState.Closed
    }

    async sendTokenTransaction(transaction: TokenTransaction): Promise<TransactionSuccess> {
        if (this.client == null || this.connectionState != ConnectionState.Open) throw new TransactionFailure()

        return this.client?.request('sendTokenTransaction', transaction)
            .then(
                (_) => {
                    return new TransactionSuccess()
                },
                (_) => {
                    throw new TransactionFailure()
                }
            )
    }
}

export { ConnectionState, InvalidStateError, ArchethicRPCClient, DefaultArchethicRPCClient, TokenTransaction, TransactionSuccess, TransactionFailure }

