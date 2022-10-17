/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../transfer_sheet.dart';

class TransferTextFieldMessage extends ConsumerStatefulWidget {
  const TransferTextFieldMessage({
    super.key,
    required this.accountSelected,
  });

  final Account accountSelected;

  @override
  ConsumerState<TransferTextFieldMessage> createState() =>
      _TransferTextFieldMessageState();
}

class _TransferTextFieldMessageState
    extends ConsumerState<TransferTextFieldMessage> {
  TextEditingController? messageController;
  FocusNode? messageFocusNode;

  @override
  void initState() {
    super.initState();

    messageFocusNode = FocusNode();
    messageController = TextEditingController();
  }

  @override
  void dispose() {
    messageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final transfer = ref.watch(TransferProvider.transfer);
    final transferNotifier = ref.watch(TransferProvider.transfer.notifier);

    return AppTextField(
      focusNode: messageFocusNode,
      controller: messageController,
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
