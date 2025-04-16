/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:ui';

import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/model/data/messenger/discussion.dart';
import 'package:aewallet/model/data/messenger/message.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/views/messenger/bloc/providers.dart';
import 'package:aewallet/util/date_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedapppfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_symbols_icons/symbols.dart';

class MessageSendForm extends ConsumerStatefulWidget {
  const MessageSendForm({
    required this.discussionAddress,
    super.key,
  });

  final String discussionAddress;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MessageSendFormState();
}

class _MessageSendFormState extends ConsumerState<MessageSendForm> {
  late TextEditingController textEditingController;
  late FocusNode messageFocusNode;

  @override
  void initState() {
    super.initState();

    textEditingController = TextEditingController();
    messageFocusNode = FocusNode();

    // Set initial text from provider if any (e.g., draft)
    final initialText = ref
        .read(
          MessengerProviders.messageCreationForm(
            ref
                .read(MessengerProviders.discussion(widget.discussionAddress))
                .value!, // Assume discussion loaded
          ),
        )
        .text;
    textEditingController.text = initialText;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // Check mount status
        messageFocusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    messageFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Read discussion here, assuming it's loaded when this form is built
    // (Based on the conditional logic in the parent widget)
    final discussion = ref
        .read(MessengerProviders.discussion(widget.discussionAddress))
        .valueOrNull;

    // Handle cases where discussion might not be loaded yet, although unlikely
    // based on parent logic. Return empty container if null.
    if (discussion == null) {
      return const SizedBox.shrink();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: ColoredBox(
        color: ArchethicTheme.background.withValues(alpha: 0.5),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).padding.bottom + 16,
              top: 8,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 120),
                        child: MessageTextField(
                          // Use the renamed public class
                          discussion: discussion,
                          textEditingController: textEditingController,
                          focusNode: messageFocusNode,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _buildSendButtonOrLoading(context, ref, discussion),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSendButtonOrLoading(
    BuildContext context,
    WidgetRef ref,
    Discussion discussionData,
  ) {
    final isCreating = ref.watch(
      MessengerProviders.messageCreationForm(discussionData)
          .select((value) => value.isCreating),
    );
    final canSend = ref
        .watch(MessengerProviders.messageCreationForm(discussionData))
        .text
        .isNotEmpty;

    if (isCreating) {
      return SizedBox(
        width: 48,
        height: 48,
        child: Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 1,
              color: ArchethicTheme.text,
            ),
          ),
        ),
      );
    } else {
      return IconButton(
        icon: Icon(
          Symbols.send,
          color: canSend ? ArchethicTheme.text : Colors.grey,
        ),
        onPressed: !canSend
            ? null
            : () async {
                await ref
                    .read(
                      MessengerProviders.messageCreationForm(
                        discussionData,
                      ).notifier,
                    )
                    .createMessage();

                if (mounted) {
                  textEditingController.clear();
                  ref
                      .read(
                        MessengerProviders.messageCreationForm(discussionData)
                            .notifier,
                      )
                      .setText('');
                }
              },
        splashRadius: 24,
      );
    }
  }
}

class MessageTextField extends ConsumerWidget {
  const MessageTextField({
    required this.discussion,
    required this.textEditingController,
    required this.focusNode,
    super.key,
  });

  final TextEditingController textEditingController;
  final Discussion discussion;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      // Removed Stack and Positioned gradient line for simplicity
      maxLines: null,
      controller: textEditingController,
      focusNode: focusNode,
      style: ArchethicThemeStyles.textStyleSize12W100Primary,
      decoration: const InputDecoration(
        hintText: 'Message...',
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 10),
        isDense: true,
      ),
      onChanged: (value) => ref
          .read(
            MessengerProviders.messageCreationForm(
              discussion,
            ).notifier,
          )
          .setText(value),
    );
  }
}

class MessagesList extends ConsumerStatefulWidget {
  const MessagesList({
    required this.discussionAddress,
    super.key,
  });
  final String discussionAddress;

  @override
  ConsumerState<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends ConsumerState<MessagesList> {
  @override
  Widget build(BuildContext context) {
    final selectedAccount = ref
        .watch(
          accountsNotifierProvider,
        )
        .valueOrNull
        ?.selectedAccount;

    final localizations = AppLocalizations.of(context)!;

    if (selectedAccount == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // Get the PagingController from the Riverpod provider
    final pagingController = ref
        .watch(MessengerProviders.paginatedMessages(widget.discussionAddress));

    return PagedListView<int, DiscussionMessage>(
      pagingController: pagingController,
      reverse: true,
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 130,
      ),
      builderDelegate: PagedChildBuilderDelegate<DiscussionMessage>(
        itemBuilder: (context, message, index) {
          final isSentByMe =
              message.senderGenesisPublicKey == selectedAccount.publicKey;

          if (isSentByMe) {
            return Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(left: 42, bottom: 8),
                child: MessageItem(
                  key: Key(message.address),
                  color: aedapppfm.ArchethicThemeBase.blue700
                      .withValues(alpha: 0.5),
                  message: message,
                  showSender: false,
                ),
              ),
            );
          } else {
            return Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(right: 42, bottom: 8),
                child: MessageItem(
                  key: Key(message.address),
                  color: ArchethicTheme.iconDataWidgetIconBackground,
                  message: message,
                  showSender: true,
                ),
              ),
            );
          }
        },
        firstPageProgressIndicatorBuilder: (_) => Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: ArchethicTheme.text,
            size: 50,
          ),
        ),
        newPageProgressIndicatorBuilder: (_) => Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: ArchethicTheme.text,
            size: 50,
          ),
        ),
        noItemsFoundIndicatorBuilder: (context) => Center(
          child: Text(
            localizations.discussionNoMessages,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class MessageItem extends ConsumerWidget {
  const MessageItem({
    required this.message,
    required this.color,
    required this.showSender,
    super.key,
  });

  final DiscussionMessage message;
  final Color color;
  final bool showSender;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contact = ref.watch(
      ContactProviders.getContactWithGenesisPublicKey(
        message.senderGenesisPublicKey,
      ),
    );

    final borderRadius = showSender
        ? const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          );

    return Card(
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      color: color,
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showSender)
              contact.maybeWhen(
                data: (contactData) {
                  // Use display name or formatted public key
                  final displayName = contactData?.format ??
                      '${message.senderGenesisPublicKey.substring(0, 8)}...${message.senderGenesisPublicKey.substring(message.senderGenesisPublicKey.length - 8)}';
                  return Text(
                    displayName,
                    style: ArchethicThemeStyles.textStyleSize12W600Primary
                        .copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
                // Show shimmer or placeholder during loading
                loading: () => Container(
                  width: 80,
                  height: 14,
                  color: Colors.grey.withValues(alpha: 0.3),
                ),
                orElse: () => const SizedBox.shrink(),
              ),
            if (showSender) const SizedBox(height: 4),
            SelectableText(
              message.content,
              style: ArchethicThemeStyles.textStyleSize12W100Primary,
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                message.date.formatLong(context),
                style: ArchethicThemeStyles.textStyleSize10W100Primary.copyWith(
                  color: ArchethicTheme.text,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
