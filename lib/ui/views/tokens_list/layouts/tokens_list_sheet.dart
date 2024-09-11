/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/views/tokens_detail/layouts/token_detail_sheet.dart';
import 'package:aewallet/ui/views/tokens_list/bloc/provider.dart';
import 'package:aewallet/ui/views/tokens_list/layouts/components/token_add_btn.dart';
import 'package:aewallet/ui/views/tokens_list/layouts/components/token_detail.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class TokensList extends ConsumerStatefulWidget {
  const TokensList({super.key});

  @override
  ConsumerState<TokensList> createState() => TokensListState();
}

class TokensListState extends ConsumerState<TokensList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  String searchCriteria = '';

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final tokens = ref
        .watch(
          TokensListFormProvider.tokens(searchCriteria: searchCriteria),
        )
        .valueOrNull;
    final localizations = AppLocalizations.of(context)!;
    final settings = ref.watch(SettingsProviders.settings);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 15,
                  ),
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      prefixIcon: Icon(
                        Symbols.search,
                        color: ArchethicTheme.text,
                        size: 18,
                        weight: IconSize.weightM,
                        opticalSize: IconSize.opticalSizeM,
                        grade: IconSize.gradeM,
                      ),
                      suffixIcon: const SizedBox(
                        width: 26,
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(90),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      hintStyle:
                          ArchethicThemeStyles.textStyleSize12W100Primary,
                      filled: true,
                      hintText: localizations.searchField,
                    ),
                    style: ArchethicThemeStyles.textStyleSize12W100Primary,
                    textAlign: TextAlign.left,
                    autocorrect: false,
                    cursorColor: ArchethicTheme.text,
                    inputFormatters: <TextInputFormatter>[
                      UpperCaseTextFormatter(),
                    ],
                    onChanged: (text) async {
                      setState(
                        () {
                          searchCriteria = text;
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            const TokenAddBtn(),
          ],
        ),
        if (tokens != null)
          Column(
            children: tokens.map((aeToken) {
              return InkWell(
                onTap: () async {
                  sl.get<HapticUtil>().feedback(
                        FeedbackType.light,
                        settings.activeVibrations,
                      );
                  await context.push(
                    TokenDetailSheet.routerPage,
                    extra: {
                      'aeToken': aeToken.toJson(),
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 13),
                  child: TokenDetail(
                    aeToken: aeToken,
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}
