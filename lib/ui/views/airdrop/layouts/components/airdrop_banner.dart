import 'package:aewallet/application/airdrop/airdrop_notifier.dart';
import 'package:aewallet/application/feature_flags.dart';
import 'package:aewallet/main.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/views/airddrop_dashboard/layouts/airdrop_dashboard_sheet.dart';
import 'package:aewallet/ui/views/airdrop/layouts/airdrop_participate_sheet.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_participants_count.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class AirdropBanner extends ConsumerWidget {
  const AirdropBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flag = ref.watch(getFeatureFlagProvider(kApplicationCode, 'airdrop'));
    final airdrop = ref.watch(airdropNotifierProvider).value;

    return flag.when(
      data: (data) {
        if (data == null || data == false) return const SizedBox.shrink();
        return airdrop == null || airdrop.isMailFilled == false
            ? _buildAirdropNew(context)
            : airdrop.personalMultiplier > 0
                ? _buildAirdropOk(context)
                : _buildAirdropCompleteParticipation(context);
      },
      error: (_, __) => const SizedBox(),
      loading: () => const SizedBox(),
    );
  }

  Widget _buildAirdropOk(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final titleTextStyle = AppTextStyles.bodyLarge(context).copyWith(
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: InkWell(
        onTap: () async {
          await context.push(AirdropDashboardSheet.routerPage);
        },
        child: _buildBannerContainer(
          context,
          height: 60,
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  localizations.airdropBannerTitle,
                  style: titleTextStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white70,
                  size: 14,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAirdropNew(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final titleTextStyle = AppTextStyles.bodyLarge(context).copyWith(
      fontWeight: FontWeight.bold,
      fontSize: 26,
    );
    final buttonTextStyle = AppTextStyles.bodyMedium(context).copyWith(
      fontWeight: FontWeight.bold,
    );

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: _buildBannerContainer(
        context,
        height: 230,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AirdropParticipantsCount(),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  localizations.airdropBannerNewTitle,
                  style: titleTextStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                  width: MediaQuery.of(context).size.width,
                ),
                InkWell(
                  onTap: () async {
                    await context.push(AirdropParticipateSheet.routerPage);
                  },
                  child: IntrinsicWidth(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      height: 35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        localizations.airdropBannerNewBtn,
                        style: buttonTextStyle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Symbols.close,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAirdropCompleteParticipation(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final titleTextStyle = AppTextStyles.bodyLarge(context).copyWith(
      fontWeight: FontWeight.bold,
      fontSize: 22,
    );
    final buttonTextStyle = AppTextStyles.bodyMedium(context).copyWith(
      fontWeight: FontWeight.bold,
    );

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: _buildBannerContainer(
        context,
        height: 230,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AirdropParticipantsCount(),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  localizations.airdropBannerCompleteParticipationTitle,
                  style: titleTextStyle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  localizations.airdropBannerCompleteParticipationDesc,
                  style: AppTextStyles.bodySmallWithOpacity(context),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                  width: MediaQuery.of(context).size.width,
                ),
                InkWell(
                  onTap: () async {
                    await context.push(AirdropDashboardSheet.routerPage);
                  },
                  child: IntrinsicWidth(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      height: 35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        localizations.airdropBannerCompleteParticipationBtn,
                        style: buttonTextStyle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Symbols.close,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerContainer(
    BuildContext context, {
    required double height,
    required Widget child,
  }) {
    return aedappfm.BlockInfo(
      borderWith: 0,
      paddingEdgeInsetsClipRRect: EdgeInsets.zero,
      paddingEdgeInsetsInfo: EdgeInsets.zero,
      height: height,
      width: MediaQuery.of(context).size.width,
      info: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    aedappfm.ArchethicThemeBase.raspberry500,
                    aedappfm.ArchethicThemeBase.raspberry500.withOpacity(0.5),
                    aedappfm.ArchethicThemeBase.blue600.withOpacity(0.5),
                  ],
                ),
              ),
            ),
          ),
          _buildBackgroundImage(),
          child,
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Positioned.fill(
      top: -60,
      left: -300,
      child: Transform.rotate(
        angle: -10 * 3.14 / 180,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Opacity(
            opacity: 0.2,
            child: Image.asset(
              'assets/themes/archethic/logo_crystal.png',
            ),
          ),
        ),
      ),
    );
  }
}
