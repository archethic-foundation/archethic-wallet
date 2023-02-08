/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:developer';

// Project imports:
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/icon_widget.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/ledger/archethic_ledger_util.dart';
// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:convert/convert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ledger_dart_lib/ledger_dart_lib.dart';

// TODO(reddwarf03): WIP, https://github.com/archethic-foundation/archethic-wallet/issues/46
class LedgerScreen extends ConsumerStatefulWidget {
  const LedgerScreen(this.ucoTransferList, {super.key});

  final List<UCOTransfer>? ucoTransferList;

  @override
  ConsumerState<LedgerScreen> createState() => _LedgerScreenState();
}

class _LedgerScreenState extends ConsumerState<LedgerScreen> {
  String response = '';
  String labelResponse = '';
  String info = '';
  String method = '';
  String originPubKey = '';

  Future<void> update() async {
    switch (method) {
      case 'getPubKey':
        final responseHex =
            hex.encode(sl.get<LedgerNanoSImpl>().response).toUpperCase();
        originPubKey = responseHex.substring(4, responseHex.length - 4);
        method = 'signTxn';
        break;
      case 'signTxn':
        log(
          hex.encode(sl.get<LedgerNanoSImpl>().response).toUpperCase(),
        );
        break;
      default:
    }

    setState(() {});
  }

  @override
  void initState() {
    method = 'getPubKey';

    super.initState();
    if (kIsWeb) {
      sl<LedgerNanoSImpl>().addListener(update);
    }
  }

  @override
  void dispose() {
    super.dispose();

    if (kIsWeb) {
      sl<LedgerNanoSImpl>().removeListener(update);
      sl.get<LedgerNanoSImpl>().disconnectLedger();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[theme.backgroundDark!, theme.background!],
              ),
            ),
          ),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) =>
                SafeArea(
              minimum: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.035,
                top: MediaQuery.of(context).size.height * 0.10,
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          const IconWidget(
                            icon: 'assets/icons/key-ring.png',
                            width: 90,
                            height: 90,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            child: AutoSizeText(
                              'Ledger',
                              style: theme.textStyleSize16W400Primary,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              stepGranularity: 0.1,
                            ),
                          ),
                          if (kIsWeb)
                            method == 'getPubKey'
                                ? const _GetPublicKeyButton()
                                : method == 'signTxn'
                                    ? _SignTransactionButton(
                                        ucoTransferList: widget.ucoTransferList,
                                        ref: ref,
                                        originPubKey: originPubKey,
                                      )
                                    : const SizedBox()
                          else
                            const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SignTransactionButton extends StatelessWidget {
  const _SignTransactionButton({
    required this.ucoTransferList,
    required this.ref,
    required this.originPubKey,
  });

  final List<UCOTransfer>? ucoTransferList;

  final WidgetRef ref;
  final String originPubKey;

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final selectedAccount =
        ref.watch(AccountProviders.selectedAccount).valueOrNull;
    if (selectedAccount == null) return const SizedBox();

    return ElevatedButton(
      child: Text(
        'Ledger - Verify transaction',
        style: theme.textStyleSize16W200Primary,
      ),
      onPressed: () async {
        const addressIndex = '';

        /*String addressIndex =
                StateContainer.of(context)
                    .selectedAccount
                    .index!
                    .toRadixString(16)
                    .padLeft(8, '0');*/
        final transaction = Transaction(
          type: 'transfer',
          data: Transaction.initData(),
        );
        for (final transfer in ucoTransferList!) {
          transaction.addUCOTransfer(
            transfer.to!,
            transfer.amount!,
          );
        }
        final lastTransactionMap =
            await sl.get<ApiService>().getLastTransaction(
          [selectedAccount.lastAddress!],
          request: 'chainLength',
        );
        final transactionChainSeed =
            ref.read(SessionProviders.session).loggedIn?.wallet.seed;
        final originPrivateKey = sl.get<ApiService>().getOriginKey();
        transaction
            .build(
              transactionChainSeed!,
              lastTransactionMap[selectedAccount.lastAddress!]!.chainLength!,
            )
            .originSign(originPrivateKey);
        final onChainWalletData = walletEncoder(originPubKey);

        const hashType = 0;
        final signTxn = getSignTxnAPDU(
          onChainWalletData,
          transaction,
          hashType,
          int.tryParse(addressIndex)!,
        );
        log('signTxn:${uint8ListToHex(signTxn)}');
        await sl.get<LedgerNanoSImpl>().connectLedger(signTxn);
      },
    );
  }
}

class _GetPublicKeyButton extends ConsumerWidget {
  const _GetPublicKeyButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return ElevatedButton(
      child: Text(
        'Ledger - Get Public Key',
        style: theme.textStyleSize16W200Primary,
      ),
      onPressed: () async {
        await sl.get<LedgerNanoSImpl>().connectLedger(getPubKeyAPDU());
      },
    );
  }
}
