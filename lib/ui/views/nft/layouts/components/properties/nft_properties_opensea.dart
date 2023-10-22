import 'package:aewallet/ui/themes/styles.dart';
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
          style: ArchethicThemeStyles.textStyleSize10W100Primary,
        ),
      ],
    );
  }
}
