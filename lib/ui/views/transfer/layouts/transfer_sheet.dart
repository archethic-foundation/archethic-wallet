import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/device_abilities.dart';
import 'package:aewallet/application/market_price.dart';
import 'package:aewallet/application/settings/primary_currency.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/util/amount_formatters.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/transfer/bloc/provider.dart';
import 'package:aewallet/ui/views/transfer/bloc/state.dart';
import 'package:aewallet/ui/views/transfer/layouts/components/transfer_confirm_sheet.dart';
import 'package:aewallet/ui/views/transfer/layouts/components/transfer_form_sheet.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/icons.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/ui/widgets/dialogs/contacts_dialog.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/number_util.dart';
import 'package:aewallet/util/user_data_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

part 'components/transfer_textfield_address.dart';
part 'components/transfer_textfield_amount.dart';
part 'components/transfer_textfield_message.dart';

class TransferSheet extends ConsumerWidget {
  const TransferSheet({
    required this.transferType,
    required this.recipient,
    this.actionButtonTitle,
    this.accountToken,
    super.key,
  });

  final TransferRecipient recipient;
  final String? actionButtonTitle;
  final AccountToken? accountToken;
  final TransferType transferType;

  Future<void> show({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    ref.invalidate(MarketPriceProviders.currencyMarketPrice);
    return Sheets.showAppHeightNineSheet(
      context: context,
      ref: ref,
      widget: this,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAccount = ref
        .watch(
          AccountProviders.selectedAccount,
        )
        .valueOrNull;

    if (selectedAccount == null) return const SizedBox();

    return ProviderScope(
      overrides: [
        TransferFormProvider.initialTransferForm.overrideWithValue(
          TransferFormState(
            feeEstimation: const AsyncValue.data(0),
            transferType: transferType,
            accountToken: accountToken,
            recipient: recipient,
            accountBalance: selectedAccount.balance!,
            amount: transferType == TransferType.nft ? 1 : 0,
          ),
        ),
      ],
      child: TransferSheetBody(
        actionButtonTitle: actionButtonTitle,
      ),
    );
  }
}

class TransferSheetBody extends ConsumerWidget {
  const TransferSheetBody({
    this.actionButtonTitle,
    super.key,
  });

  final String? actionButtonTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final transfer = ref.watch(TransferFormProvider.transferForm);

    ref.listen<TransferFormState>(
      TransferFormProvider.transferForm,
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

        ref.read(TransferFormProvider.transferForm.notifier).setErrors(
              errorAddressText: '',
              errorAmountText: '',
              errorMessageText: '',
            );
      },
    );

    String title() {
      switch (transfer.transferType) {
        case TransferType.uco:
          return localizations.transferTokens.replaceAll(
            '%1',
            AccountBalance.cryptoCurrencyLabel,
          );
        case TransferType.token:
          return localizations.transferTokens.replaceAll(
            '%1',
            transfer.accountToken!.tokenInformations!.symbol!,
          );
        case TransferType.nft:
          return localizations.transferNFT;
      }
    }

    if (transfer.transferProcessStep == TransferProcessStep.form) {
      return TransferFormSheet(
        title: title(),
        actionButtonTitle: actionButtonTitle,
      );
    } else {
      return TransferConfirmSheet(
        title: title(),
      );
    }
  }
}
