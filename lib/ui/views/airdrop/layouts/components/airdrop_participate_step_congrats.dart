import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_lp_current_value.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_step_tab.dart';
import 'package:aewallet/ui/views/main/bloc/providers.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AirdropParticipateStepCongratsSheet extends ConsumerStatefulWidget {
  const AirdropParticipateStepCongratsSheet({
    super.key,
  });

  @override
  ConsumerState<AirdropParticipateStepCongratsSheet> createState() =>
      _AirdropParticipateStepCongratsSheetState();
}

class _AirdropParticipateStepCongratsSheetState
    extends ConsumerState<AirdropParticipateStepCongratsSheet>
    implements SheetSkeletonInterface {
  @override
  Widget build(
    BuildContext context,
  ) {
    final accountSelected = ref.watch(
      accountsNotifierProvider.select(
        (accounts) => accounts.valueOrNull?.selectedAccount,
      ),
    );

    if (accountSelected == null) return const SizedBox();

    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return Row(
      children: <Widget>[
        AppButtonTinyConnectivity(
          localizations.airdropParticipateStepCongratsBtn,
          Dimens.buttonBottomDimens,
          onPressed: () async {
            await ref
                .read(SettingsProviders.settings.notifier)
                .setMainScreenCurrentPage(3);
            ref.read(mainTabControllerProvider)!.animateTo(
                  3,
                  duration: Duration.zero,
                );
            context.pop();
          },
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return SheetAppBar(
      title: localizations.airdropParticipateTitle,
      widgetLeft: CloseButton(
        key: const Key('close'),
        color: ArchethicTheme.text,
        onPressed: () {
          context.pop();
        },
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.airdropParticipateStepCongratsTitle,
            style: AppTextStyles.bodyLarge(context)
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const AirdropLPCurrentValue(),
          const SizedBox(height: 10),
          const AirdropStepTab(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
