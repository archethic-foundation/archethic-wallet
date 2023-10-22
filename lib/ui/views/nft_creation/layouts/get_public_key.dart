/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/public_key_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetPublicKeys extends ConsumerWidget {
  const GetPublicKeys({
    super.key,
    required this.propertyName,
    required this.propertyValue,
    required this.readOnly,
  });

  final String propertyName;
  final String propertyValue;
  final bool readOnly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nftCreation = ref.watch(
      NftCreationFormProvider.nftCreationForm(
        ref.read(
          NftCreationFormProvider.nftCreationFormArgs,
        ),
      ),
    );
    final property = nftCreation.properties;
    if (property.isEmpty) {
      return const SizedBox();
    }
    final propertySelected = property.firstWhere(
      (element) => element.propertyName == propertyName,
    );

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
            // TODO(Chralu): create dynamic loading (3)
            children: List.generate(
              propertySelected.publicKeys.length,
              (index) {
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: PublicKeyLine(
                    propertyName: propertyName,
                    propertyAccessRecipient: propertySelected.publicKeys[index],
                    readOnly: readOnly,
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
