import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/address_formatters.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/tokens_detail/layouts/components/token_detail_chart.dart';
import 'package:aewallet/ui/views/tokens_detail/layouts/components/token_detail_chart_interval.dart';
import 'package:aewallet/ui/views/tokens_detail/layouts/components/token_detail_info.dart';
import 'package:aewallet/ui/views/tokens_detail/layouts/components/token_detail_menu.dart';
import 'package:aewallet/ui/widgets/balance/balance_infos.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
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

class TokenDetailSheet extends ConsumerWidget
    implements SheetSkeletonInterface {
  const TokenDetailSheet({
    super.key,
    required this.aeToken,
    this.chartInfos,
  });

  final aedappfm.AEToken aeToken;
  final List<aedappfm.PriceHistoryValue>? chartInfos;

  static const String routerPage = '/tokenDetail';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    return const SizedBox.shrink();
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final preferences = ref.watch(SettingsProviders.settings);
    return SheetAppBar(
      title: '',
      widgetBeforeTitle: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            aeToken.symbol,
            style: ArchethicThemeStyles.textStyleSize24W700Primary,
          ),
          if (aeToken.isVerified)
            Padding(
              padding: const EdgeInsets.only(
                left: 5,
                bottom: 1,
              ),
              child: Icon(
                Symbols.verified,
                color: ArchethicTheme.activeColorSwitch,
                size: 15,
              ),
            ),
        ],
      ),
      widgetAfterTitle: aeToken.address != null && aeToken.address!.isNotEmpty
          ? InkWell(
              onTap: () {
                sl.get<HapticUtil>().feedback(
                      FeedbackType.light,
                      preferences.activeVibrations,
                    );
                Clipboard.setData(
                  ClipboardData(
                    text: aeToken.address ?? '',
                  ),
                );
                UIUtil.showSnackbar(
                  '${localizations.addressCopied}\n${aeToken.address!.toLowerCase()}',
                  context,
                  ref,
                  ArchethicTheme.text,
                  ArchethicTheme.snackBarShadow,
                  icon: Symbols.info,
                );
              },
              child: Row(
                children: [
                  Text(
                    AddressFormatters(
                      aeToken.address ?? '',
                    ).getShortString4().toLowerCase(),
                    style: ArchethicThemeStyles.textStyleSize14W600Primary,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Symbols.content_copy,
                    weight: IconSize.weightM,
                    opticalSize: IconSize.opticalSizeM,
                    grade: IconSize.gradeM,
                    size: 16,
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          context.pop();
        },
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    return Column(
      children: <Widget>[
        TokenDetailInfo(
          aeToken: aeToken,
        ),
        const SizedBox(
          height: 20,
        ),
        TokenDetailMenu(
          aeToken: aeToken,
        ),
        if (chartInfos != null && chartInfos!.isNotEmpty)
          TokenDetailChart(chartInfos: chartInfos),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 20,
        ),
        if (chartInfos != null && chartInfos!.isNotEmpty)
          TokenDetailChartInterval(chartInfos: chartInfos),
        if (chartInfos != null && chartInfos!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10),
            child: BalanceInfosKpi(
              chartInfos: chartInfos,
              aeToken: aeToken,
            ),
          ),
      ],
    );
  }
}
