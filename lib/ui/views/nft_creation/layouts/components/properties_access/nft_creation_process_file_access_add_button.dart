/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/add_address.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:material_symbols_icons/symbols.dart';

class NFTCreationProcessFileAccessAddButton extends ConsumerWidget {
  const NFTCreationProcessFileAccessAddButton({
    required this.propertyName,
    required this.propertyValue,
    this.readOnly = false,
    super.key,
  });

  final String propertyName;
  final String propertyValue;
  final bool readOnly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(SettingsProviders.settings);
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: ArchethicTheme.backgroundDark.withOpacity(0.3),
          border: Border.all(
            color: ArchethicTheme.backgroundDarkest.withOpacity(0.2),
            width: 2,
          ),
        ),
        child: IconButton(
          icon: Icon(
            Symbols.key,
            color: ArchethicTheme.backgroundDarkest,
            size: 21,
          ),
          onPressed: () {
            sl.get<HapticUtil>().feedback(
                  FeedbackType.light,
                  preferences.activeVibrations,
                );
            Sheets.showAppHeightNineSheet(
              context: context,
              ref: ref,
              overrides: [
                NftCreationFormProvider.nftCreationFormArgs.overrideWithValue(
                  ref.read(
                    NftCreationFormProvider.nftCreationFormArgs,
                  ),
                ),
              ],
              widget: AddAddress(
                propertyName: propertyName,
                propertyValue: propertyValue,
                readOnly: readOnly,
              ),
            );
          },
        ),
      ),
    );
  }
}
