/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft/layouts/components/properties/nft_properties_archethic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTPropertiesOpensea extends ConsumerWidget {
  const NFTPropertiesOpensea({
    super.key,
    required this.property,
  });

  final Map<String, dynamic> property;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalizations.of(context)!;
    final propertyWidgets = <Widget>[];
    final propertyValueList = property.values.first as List<dynamic>;

    for (final Map<dynamic, dynamic> propertyValue in propertyValueList) {
      propertyWidgets.add(
        NFTPropertiesArchethic(
          property: {propertyValue['trait_type']: propertyValue['value']},
        ),
      );
    }
    return Column(
      children: [
        ...propertyWidgets,
        Text(
          localizations.nftPropertiesOpenseaStructure,
          style: theme.textStyleSize10W100Primary,
        ),
      ],
    );
  }
}
