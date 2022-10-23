/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/public_key_line.dart';
// Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetPublicKeys extends ConsumerWidget {
  const GetPublicKeys({
    super.key,
    required this.propertyName,
    required this.propertyValue,
  });

  final String propertyName;
  final String propertyValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final property = ref
        .watch(NftCreationFormProvider.nftCreationForm)
        .properties
        .where(
          (element) => element.propertyName == propertyName,
        )
        .first;

    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 10,
            right: 10,
          ),
          child: Wrap(
            // TODO(reddwarf03): create dynamic loading
            children: List.generate(
              property.publicKeys.length,
              (index) {
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: PublicKeyLine(
                    publicKey: property.publicKeys[index],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
