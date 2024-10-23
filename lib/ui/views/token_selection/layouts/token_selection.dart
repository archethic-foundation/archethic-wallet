import 'package:aewallet/ui/views/token_selection/layouts/components/token_list.dart';
import 'package:aewallet/ui/views/token_selection/layouts/components/token_selection_common_bases.dart';
import 'package:aewallet/ui/views/token_selection/layouts/components/token_selection_search_bar.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';

class TokenSelection extends StatelessWidget {
  const TokenSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 1,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const TokenSelectionSearchBar(),
            const TokenSelectionCommonBases(),
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
            const Expanded(child: TokenList()),
          ],
        ),
      ),
    );
  }
}
