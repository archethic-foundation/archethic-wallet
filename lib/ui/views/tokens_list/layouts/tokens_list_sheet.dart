/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/infrastructure/datasources/preferences.hive.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/views/tokens_detail/layouts/token_detail_sheet.dart';
import 'package:aewallet/ui/views/tokens_list/bloc/provider.dart';
import 'package:aewallet/ui/views/tokens_list/layouts/components/token_add_btn.dart';
import 'package:aewallet/ui/views/tokens_list/layouts/components/token_detail.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
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
  final searchCriteriaController = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      // TODO(reddwarf03): See https://github.com/archethic-foundation/archethic-wallet/pull/988
      final ucidsTokens = ref.read(aedappfm.UcidsTokensProviders.ucidsTokens);
      if (ucidsTokens.isEmpty) {
        final preferences = await PreferencesHiveDatasource.getInstance();
        final network = preferences.getNetwork().getNetworkLabel();
        await ref
            .read(aedappfm.UcidsTokensProviders.ucidsTokens.notifier)
            .init(network);
      }
      await ref.read(aedappfm.CoinPriceProviders.coinPrice.notifier).init();

      await ref
          .read(TokensListFormProvider.tokensListForm.notifier)
          .getTokensList(
            cancelToken: UniqueKey().toString(),
          );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final asyncTokens =
        ref.watch(TokensListFormProvider.tokensListForm).tokensToDisplay;
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
                    controller: searchCriteriaController,
                    autocorrect: false,
                    cursorColor: ArchethicTheme.text,
                    inputFormatters: <TextInputFormatter>[
                      UpperCaseTextFormatter(),
                    ],
                    onChanged: (text) async {
                      await ref
                          .read(TokensListFormProvider.tokensListForm.notifier)
                          .setSearchCriteria(text.toUpperCase());
                    },
                  ),
                ),
              ),
            ),
            const TokenAddBtn(),
          ],
        ),
        asyncTokens.when(
          error: (error, stackTrace) => aedappfm.ErrorMessage(
            failure: aedappfm.Failure.fromError(error),
            failureMessage: 'Error loading',
          ),
          loading: () {
            return const Stack(
              alignment: Alignment.centerLeft,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            );
          },
          data: (tokens) {
            return Column(
              children: tokens!.map((aeToken) {
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
                        'chartInfos': null,
                      },
                    );
                  },
                  child: TokenDetail(
                    aeToken: aeToken,
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
