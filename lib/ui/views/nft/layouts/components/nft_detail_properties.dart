/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:convert';

import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft/layouts/components/properties/nft_properties_archethic.dart';
import 'package:aewallet/ui/views/nft/layouts/components/properties/nft_properties_opensea.dart';
import 'package:aewallet/ui/views/nft/layouts/components/properties/nft_properties_unknown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_schema/json_schema.dart';

class NFTDetailProperties extends ConsumerWidget {
  const NFTDetailProperties({
    super.key,
    required this.properties,
  });

  final Map<String, dynamic> properties;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final description = properties['description'] ?? '';

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            if (description != '')
              Text(
                description,
                style: theme.textStyleSize10W400Primary,
              ),
            if (properties.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Wrap(
                  children: properties.entries.map((
                    MapEntry<String, dynamic> entry,
                  ) {
                    return entry.key != 'content' &&
                            entry.key != 'description' &&
                            entry.key != 'name' &&
                            entry.key != 'id' &&
                            entry.key != 'type_mime'
                        ? Padding(
                            padding: const EdgeInsets.all(5),
                            child: FutureBuilder(
                              future: _buildTokenProperty(
                                context,
                                ref,
                                {entry.key: entry.value},
                              ),
                              builder: (
                                BuildContext context,
                                AsyncSnapshot<Widget> snapshot,
                              ) {
                                if (snapshot.hasData) {
                                  return snapshot.data!;
                                }
                                return const SizedBox();
                              },
                            ),
                          )
                        : const SizedBox();
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<Widget> _buildTokenProperty(
    BuildContext context,
    WidgetRef ref,
    Map<String, dynamic> property,
  ) async {
    final openseaJsonC =
        await rootBundle.loadString('lib/model/json-schemas/nft/opensea.json');
    final openseaMap = json.decode(openseaJsonC);
    final openseaSchema = JsonSchema.create(openseaMap);
    final openseaValidationResult = openseaSchema.validate(property);
    if (openseaValidationResult.isValid) {
      return NFTPropertiesOpensea(
        property: property,
      );
    }

    final archethicJsonC = await rootBundle
        .loadString('lib/model/json-schemas/nft/archethic.json');
    final archethicMap = json.decode(archethicJsonC);
    final archethicSchema = JsonSchema.create(archethicMap);
    final archethicValidationResult = archethicSchema.validate(property);
    if (archethicValidationResult.isValid) {
      return NFTPropertiesArchethic(
        property: property,
      );
    }

    return NFTPropertiesUnknown(
      properties: properties,
    );
  }
}
