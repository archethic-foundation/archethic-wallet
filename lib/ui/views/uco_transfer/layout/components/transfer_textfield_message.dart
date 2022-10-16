/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../transfer_sheet.dart';

class TransferTextFieldMessage extends ConsumerWidget {
  const TransferTextFieldMessage({
    super.key,
    required this.accountSelected,
  });

  final Account accountSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final transfer = ref.watch(TransferProvider.transfer);
    final transferNotifier = ref.watch(TransferProvider.transfer.notifier);

    final _messageFocusNode = FocusNode();
    final _messageController = TextEditingController();

    return AppTextField(
      focusNode: _messageFocusNode,
      controller: _messageController,
      maxLines: 4,
      labelText:
          '${AppLocalization.of(context)!.sendMessageHeader} (${transfer.message.length}/200)',
      onChanged: (String text) {
        transferNotifier.setMessage(text);
      },
      keyboardType: TextInputType.text,
      textAlign: TextAlign.left,
      style: theme.textStyleSize16W600Primary,
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(200),
      ],
    );
  }
}
