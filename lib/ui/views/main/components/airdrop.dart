/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AirDrop extends ConsumerWidget {
  const AirDrop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountSelected = ref
        .watch(
          AccountProviders.selectedAccount,
        )
        .valueOrNull;

    if (accountSelected == null) return const SizedBox();

    return Container(
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width,
      child: Image.asset(
        'assets/images/airdrop.png',
        fit: BoxFit.fill,
      ),
    );
  }
}
