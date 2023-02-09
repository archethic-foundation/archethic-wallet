import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dapp_example/aewallet_client.dart';
import 'package:flutter_dapp_example/snackbar.dart';

void main() {
  runApp(const MyApp());
}

final _aewalletClient = AEWalletRPCClient();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dapp Demo',
      home: const TransactionSendForm(),
      onGenerateRoute: (settings) {
        if (_aewalletClient.handleRoute(settings.name)) return;
        return null;
      },
    );
  }
}

class TransactionSendForm extends StatefulWidget {
  const TransactionSendForm({super.key});

  @override
  State<TransactionSendForm> createState() => _TransactionSendFormState();
}

class _TransactionSendFormState extends State<TransactionSendForm> {
  final payloadTextController = TextEditingController(text: """
 {
    "source": "Insomnia",
    "accountName": "ASF",
    "type": "token",
    "version": 1,
    "data": {
        "content": "{ \\"name\\": \\"NFT 001\\", \\"supply\\": 100000000, \\"type\\": \\"non-fungible\\", \\"symbol\\": \\"NFT1\\", \\"aeip\\": [2], \\"properties\\": {}}",
        "code": "",
        "ownerships": [],
        "ledger": {
            "uco": {
                "transfers": []
            },
            "token": {
                "transfers": []
            }
        },
        "recipients": []
    }
}
""");

  @override
  void dispose() {
    payloadTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.send),
          onPressed: () async {
            final response = await _aewalletClient.signTransaction(
              id: "transaction_sign_request_001",
              replyUrl: "flutterdappexample://dapp.example/aewallet_response",
              params: jsonDecode(payloadTextController.text),
            );

            response.map(
              failure: (failure) {
                log(
                  'Transaction failed',
                  error: failure,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  ResultSnackbar.error(failure.message ?? "An error occured"),
                );
              },
              success: (result) {
                log(
                  'Transaction succeed : ${json.encode(result)}',
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  ResultSnackbar.success(json.encode(result)),
                );
              },
            );
          },
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SmallSpace(),
                Text(
                  'Payload :',
                  style: Theme.of(context).textTheme.headlineSmall!,
                ),
                const SmallSpace(),
                Expanded(
                  child: TextFormField(
                    controller: payloadTextController,
                    minLines: null,
                    maxLines: null,
                  ),
                ),
                const SmallSpace(),
              ],
            ),
          ),
        ),
      );
}

class SmallSpace extends StatelessWidget {
  const SmallSpace({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 24);
  }
}
