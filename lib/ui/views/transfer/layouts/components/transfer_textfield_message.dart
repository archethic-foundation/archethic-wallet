/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../transfer_sheet.dart';

class TransferTextFieldMessage extends ConsumerStatefulWidget {
  const TransferTextFieldMessage({
    super.key,
  });

  @override
  ConsumerState<TransferTextFieldMessage> createState() =>
      _TransferTextFieldMessageState();
}

class _TransferTextFieldMessageState
    extends ConsumerState<TransferTextFieldMessage> {
  late TextEditingController messageController;
  late FocusNode messageFocusNode;

  @override
  void initState() {
    super.initState();
    final transfer = ref.read(TransferFormProvider.transferForm);
    messageFocusNode = FocusNode();
    messageController = TextEditingController(text: transfer.message);
  }

  @override
  void dispose() {
    messageFocusNode.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final transfer = ref.watch(TransferFormProvider.transferForm);
    final transferNotifier =
        ref.watch(TransferFormProvider.transferForm.notifier);

    return AppTextField(
      focusNode: messageFocusNode,
      controller: messageController,
      maxLines: 4,
      labelText:
          '${AppLocalization.of(context)!.sendMessageHeader} (${transfer.message.length}/200)',
      onChanged: (String text) async {
        transferNotifier.setMessage(
          context: context,
          message: text,
        );
      },
      keyboardType: TextInputType.multiline,
      textAlign: TextAlign.left,
      style: theme.textStyleSize14W600Primary,
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(200),
      ],
    );
  }
}
