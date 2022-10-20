/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account.dart';
import 'package:aewallet/application/currency.dart';
import 'package:aewallet/application/device_abilities.dart';
import 'package:aewallet/application/primary_currency.dart';
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/address.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/transfer/bloc/model.dart';
import 'package:aewallet/ui/views/transfer/bloc/provider.dart';
import 'package:aewallet/ui/views/transfer/layouts/components/transfer_confirm_sheet.dart';
import 'package:aewallet/ui/views/transfer/layouts/components/transfer_form_sheet.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/dialogs/contacts_dialog.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/number_util.dart';
import 'package:aewallet/util/user_data_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

part 'components/transfer_textfield_address.dart';
part 'components/transfer_textfield_amount.dart';
part 'components/transfer_textfield_message.dart';

enum AddressStyle { text60, text90, primary }

class TransferSheet extends ConsumerWidget {
  const TransferSheet({
    required this.seed,
    required this.transferType,
    this.contact,
    this.address,
    this.actionButtonTitle,
    this.accountToken,
    super.key,
  });

  final Contact? contact;
  final String? address;
  final String? actionButtonTitle;
  final AccountToken? accountToken;
  final TransferType transferType;
  final String seed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // The main column that holds everything
    return ProviderScope(
      overrides: [
        TransferProvider.initialTransfer.overrideWithValue(
          TransferFormData(
            transferType: transferType,
            accountToken: accountToken,
            symbol: transferType == TransferType.uco
                ? StateContainer.of(context)
                    .curNetwork
                    .getNetworkCryptoCurrencyLabel()
                : accountToken!.tokenInformations!.symbol!,
            addressRecipient: address ?? '',
            contactRecipient: contact,
            isContactKnown: contact != null,
          ),
        ),
      ],
      child: TransferSheetBody(
        seed: seed,
        actionButtonTitle: actionButtonTitle,
      ),
    );
  }
}

class TransferSheetBody extends ConsumerWidget {
  const TransferSheetBody({
    required this.seed,
    this.actionButtonTitle,
    super.key,
  });

  final String? actionButtonTitle;
  final String seed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final transfer = ref.watch(TransferProvider.transfer);

    ref.listen<TransferFormData>(
      TransferProvider.transfer,
      (_, transfer) {
        if (transfer.isControlsOk) return;

        final errorMessages = <String>[];
        if (transfer.errorAmountText.isNotEmpty) {
          errorMessages.add(transfer.errorAmountText);
        }
        if (transfer.errorAddressText.isNotEmpty) {
          errorMessages.add(transfer.errorAddressText);
        }
        if (transfer.errorMessageText.isNotEmpty) {
          errorMessages.add(transfer.errorMessageText);
        }

        UIUtil.showSnackbar(
          errorMessages.join('\n'),
          context,
          ref,
          theme.text!,
          theme.snackBarShadow!,
          duration: const Duration(seconds: 5),
        );
      },
    );

    final title = transfer.transferType == TransferType.uco
        ? localizations.transferTokens.replaceAll(
            '%1',
            StateContainer.of(context)
                .curNetwork
                .getNetworkCryptoCurrencyLabel(),
          )
        : transfer.transferType == TransferType.token
            ? localizations.transferTokens.replaceAll(
                '%1',
                transfer.accountToken!.tokenInformations!.symbol!,
              )
            : transfer.transferType == TransferType.nft
                ? localizations.transferNFT
                : localizations.send;

    if (transfer.transferProcessStep == TransferProcessStep.form) {
      return TransferFormSheet(
        seed: seed,
        title: title,
        actionButtonTitle: actionButtonTitle,
      );
    } else {
      return TransferConfirmSheet(
        title: title,
      );
    }
  }
}
