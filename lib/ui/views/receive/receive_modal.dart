import 'dart:ui';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/receive/layouts/components/explorer_button.dart';
import 'package:aewallet/ui/views/receive/layouts/components/share_button.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReceiveModal extends ConsumerWidget {
  const ReceiveModal({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAccount = ref.watch(
      AccountProviders.accounts.select(
        (accounts) => accounts.valueOrNull?.selectedAccount,
      ),
    );
    final localizations = AppLocalizations.of(context)!;
    final preferences = ref.watch(SettingsProviders.settings);
    final infoQRCode = selectedAccount?.genesisAddress.toUpperCase() ?? '';
    return Stack(
      children: [
        ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.trackpad,
                },
              ),
              child: GestureDetector(
                onTap: () {
                  sl.get<HapticUtil>().feedback(
                        FeedbackType.light,
                        preferences.activeVibrations,
                      );
                  Clipboard.setData(
                    ClipboardData(text: infoQRCode),
                  );
                  UIUtil.showSnackbar(
                    localizations.addressCopied,
                    context,
                    ref,
                    ArchethicTheme.text,
                    ArchethicTheme.snackBarShadow,
                    icon: Symbols.info,
                  );
                },
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      localizations.receiveHeader,
                      style: ArchethicThemeStyles.textStyleSize14W600Primary,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      width: 200,
                      height: 200,
                      child: QrImageView(
                        size: 200,
                        eyeStyle: const QrEyeStyle(color: Colors.black),
                        dataModuleStyle:
                            const QrDataModuleStyle(color: Colors.black),
                        data: infoQRCode,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: SelectableText(
                        infoQRCode,
                        style: ArchethicThemeStyles.textStyleSize12W100Primary
                            .copyWith(letterSpacing: 2),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      localizations.receiveCopy,
                      style: ArchethicThemeStyles.textStyleSize12W100Primary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom + 10,
            ),
            child: Row(
              children: [
                ExplorerButton(
                  address: infoQRCode,
                ),
                ShareButton(payload: infoQRCode),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
