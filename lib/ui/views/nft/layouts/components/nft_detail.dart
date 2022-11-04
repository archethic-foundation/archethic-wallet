/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account.dart';
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/address.dart';
import 'package:aewallet/model/data/token_informations.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_preview.dart';
import 'package:aewallet/ui/views/transfer/bloc/state.dart';
import 'package:aewallet/ui/views/transfer/layouts/transfer_sheet.dart';
import 'package:aewallet/ui/widgets/components/app_button.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class NFTDetail extends ConsumerWidget {
  const NFTDetail({
    super.key,
    required this.tokenInformations,
    required this.index,
  });

  final TokenInformations tokenInformations;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalization.of(context)!;
    final preferences = ref.watch(SettingsProviders.settings);
    final accountSelected =
        ref.read(AccountProviders.getSelectedAccount(context: context));

    return SafeArea(
      minimum:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
      child: Column(
        children: <Widget>[
          SheetHeader(title: tokenInformations.name!),
          Expanded(
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.8,
                child: SafeArea(
                  minimum: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.035,
                    top: 50,
                  ),
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          NFTPreviewWidget(
                            tokenInformations: tokenInformations,
                            nftPropertiesDeleteAction: false,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              AppButton(
                AppButtonType.primary,
                localizations.send,
                Dimens.buttonTopDimens,
                key: const Key('sendNFT'),
                onPressed: () async {
                  sl.get<HapticUtil>().feedback(
                        FeedbackType.light,
                        preferences.activeVibrations,
                      );
                  Sheets.showAppHeightNineSheet(
                    context: context,
                    ref: ref,
                    widget: TransferSheet(
                      transferType: TransferType.nft,
                      seed: (await StateContainer.of(
                        context,
                      ).getSeed())!,
                      accountToken: accountSelected!.accountNFT![index],
                      recipient: const TransferRecipient.address(
                        address: Address(''),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          Row(
            children: <Widget>[
              AppButton(
                AppButtonType.primary,
                localizations.viewExplorer,
                Dimens.buttonBottomDimens,
                icon: Icon(
                  Icons.more_horiz,
                  color: theme.text,
                ),
                key: const Key('viewExplorer'),
                onPressed: () async {
                  UIUtil.showWebview(
                    context,
                    '${StateContainer.of(context).curNetwork.getLink()}/explorer/transaction/${tokenInformations.address}',
                    '',
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}