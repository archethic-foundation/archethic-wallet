import 'dart:convert';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:aewallet/ui/views/token_selection/layouts/components/token_list.dart';
import 'package:aewallet/ui/views/token_selection/layouts/components/token_selection_common_bases.dart';
import 'package:aewallet/ui/views/token_selection/layouts/components/token_selection_search_bar.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TokenSelectionPopup {
  static Future<DexToken?> getDialog(
    BuildContext context,
  ) async {
    final jsonContent = await rootBundle
        .loadString('lib/modules/aeswap/domain/repositories/common_bases.json');

    final jsonData = jsonDecode(jsonContent);

    final currentEnvironment = aedappfm.EndpointUtil.getEnvironnement();
    final tokens = jsonData['tokens'][currentEnvironment] as List<dynamic>;
    if (!context.mounted) return null;
    return showDialog<DexToken>(
      context: context,
      builder: (context) {
        return aedappfm.PopupTemplate(
          popupContent: LayoutBuilder(
            builder: (context, constraint) {
              return aedappfm.ArchethicScrollbar(
                child: Container(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const TokenSelectionSearchBar(),
                        TokenSelectionCommonBases(tokens: tokens),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: SizedBox(
                            width: 600,
                            height: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: aedappfm.AppThemeBase.gradient,
                              ),
                            ),
                          ),
                        ),
                        const TokenList(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          popupTitle: '',
          popupHeight: 500,
        );
      },
    );
  }
}
