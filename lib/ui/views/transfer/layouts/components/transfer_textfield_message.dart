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
    final transfer = ref.watch(TransferFormProvider.transferForm);
    final transferNotifier =
        ref.watch(TransferFormProvider.transferForm.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            '${AppLocalizations.of(context)!.sendMessageHeader} (${transfer.message.runes.length}/200)',
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              width: 0.5,
                            ),
                            gradient:
                                ArchethicTheme.gradientInputFormBackground,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              maxLines: 4,
                              autocorrect: false,
                              controller: messageController,
                              onChanged: (text) {
                                transferNotifier.setMessage(
                                  context: context,
                                  message: text,
                                );
                              },
                              focusNode: messageFocusNode,
                              textInputAction: TextInputAction.newline,
                              keyboardType: TextInputType.multiline,
                              inputFormatters: <TextInputFormatter>[
                                LengthLimitingTextInputFormatter(200),
                              ],
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 10),
          child: Text(
            AppLocalizations.of(context)!.enterMessageInfo,
            style: ArchethicThemeStyles.textStyleSize10W100Primary,
          ),
        ),
      ],
    )
        .animate()
        .fade(duration: const Duration(milliseconds: 200))
        .scale(duration: const Duration(milliseconds: 200));
  }
}
