import 'dart:ui';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/tokens/tokens.dart';
import 'package:aewallet/ui/views/transfer/layouts/components/transfer_token_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransferTokensList extends ConsumerStatefulWidget {
  const TransferTokensList({
    super.key,
  });

  @override
  ConsumerState<TransferTokensList> createState() => TransferTokensListState();
}

class TransferTokensListState extends ConsumerState<TransferTokensList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final selectedAccount = ref.watch(
      AccountProviders.accounts.select(
        (accounts) => accounts.valueOrNull?.selectedAccount,
      ),
    );
    final tokensListAsync = ref.watch(
      TokensProviders.tokens(
        selectedAccount!.genesisAddress,
      ),
    );

    return tokensListAsync.when(
      data: (tokensList) {
        if (tokensList.isEmpty) {
          return const SizedBox.shrink();
        }

        tokensList.sort((a, b) {
          if (a.address == null && b.address != null) return -1;
          if (a.address != null && b.address == null) return 1;

          if (a.isVerified && !b.isVerified) return -1;
          if (!a.isVerified && b.isVerified) return 1;

          if (!a.isLpToken && b.isLpToken) return -1;
          if (a.isLpToken && !b.isLpToken) return 1;

          final symbolComparison = a.symbol.compareTo(b.symbol);
          if (symbolComparison != 0) return symbolComparison;

          return 0;
        });

        return Expanded(
          child: Stack(
            children: [
              ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                    PointerDeviceKind.trackpad,
                  },
                ),
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 20,
                    bottom: MediaQuery.of(context).padding.bottom + 70,
                  ),
                  itemCount: tokensList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TransferTokenDetail(
                      aeToken: tokensList[index],
                    );
                  },
                ),
              ),
              Positioned(
                top: -20,
                left: 0,
                right: 0,
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black,
                        Colors.black.withOpacity(0),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const SizedBox(
        height: 10,
        width: 10,
        child: CircularProgressIndicator(
          strokeWidth: 1,
        ),
      ),
      error: (error, stackTrace) => const SizedBox.shrink(),
    );
  }
}
