import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/market_price.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/data/messenger/message.dart';
import 'package:aewallet/ui/util/amount_formatters.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/messenger/bloc/providers.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:aewallet/util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_symbols_icons/symbols.dart';

class MessengerDiscussionPage extends ConsumerWidget {
  const MessengerDiscussionPage({
    super.key,
    required this.discussionAddress,
  });

  final String discussionAddress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    final discussion =
        ref.watch(MessengerProviders.discussion(discussionAddress));
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            theme.background3Small!,
          ),
          fit: BoxFit.fitHeight,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[theme.backgroundDark!, theme.background!],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(
                Symbols.info,
                weight: IconSize.weightM,
                opticalSize: IconSize.opticalSizeM,
                grade: IconSize.gradeM,
              ),
              onPressed: () async {
                Navigator.of(context).pushNamed(
                  '/discussion_details',
                  arguments: discussionAddress,
                );
              },
            ),
          ],
          title: discussion.maybeMap(
            data: (data) {
              final displayName = ref.watch(
                MessengerProviders.discussionDisplayName(data.value),
              );

              return Text(displayName);
            },
            orElse: () => const Text('           ')
                .animate(
                  onComplete: (controller) =>
                      controller.repeat(period: 1.seconds),
                )
                .shimmer(),
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _MessagesList(
                  discussionAddress: discussionAddress,
                ),
              ),
              _MessageSendForm(
                discussionAddress: discussionAddress,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MessageSendForm extends ConsumerStatefulWidget {
  const _MessageSendForm({
    required this.discussionAddress,
  });

  final String discussionAddress;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __MessageSendFormState();
}

class __MessageSendFormState extends ConsumerState<_MessageSendForm> {
  late TextEditingController textEditingController;
  late FocusNode messageFocusNode;

  @override
  void initState() {
    super.initState();

    textEditingController = TextEditingController();
    messageFocusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      messageFocusNode.requestFocus();
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
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final isCreating = ref.watch(
      MessengerProviders.messageCreationForm(widget.discussionAddress)
          .select((value) => value.isCreating),
    );

    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 120),
                  child: _MessageTextField(
                    discussionAddress: widget.discussionAddress,
                    textEditingController: textEditingController,
                    focusNode: messageFocusNode,
                  ),
                ),
              ),
              if (isCreating)
                SizedBox(
                  width: 55,
                  height: 20,
                  child: Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: theme.text,
                      ),
                    ),
                  ),
                )
              else
                TextButton.icon(
                  onPressed: ref
                          .watch(
                            MessengerProviders.messageCreationForm(
                              widget.discussionAddress,
                            ),
                          )
                          .text
                          .isEmpty
                      ? null
                      : () async {
                          await ref
                              .read(
                                MessengerProviders.messageCreationForm(
                                  widget.discussionAddress,
                                ).notifier,
                              )
                              .createMessage();

                          textEditingController.text = ref
                              .read(
                                MessengerProviders.messageCreationForm(
                                  widget.discussionAddress,
                                ),
                              )
                              .text;
                        },
                  icon: Icon(
                    Symbols.send,
                    color: theme.text,
                    weight: IconSize.weightM,
                    opticalSize: IconSize.opticalSizeM,
                    grade: IconSize.gradeM,
                  ),
                  label: Container(),
                ),
            ],
          ),
          const SizedBox(height: 6),
          _MessageCreationFormFees(discussionAddress: widget.discussionAddress),
        ],
      ),
    );
  }
}

class _MessageTextField extends ConsumerWidget {
  const _MessageTextField({
    required this.discussionAddress,
    required this.textEditingController,
    required this.focusNode,
  });

  final TextEditingController textEditingController;
  final String discussionAddress;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return Stack(
      children: [
        TextField(
          maxLines: null,
          controller: textEditingController,
          focusNode: focusNode,
          onChanged: (value) => ref
              .read(
                MessengerProviders.messageCreationForm(
                  discussionAddress,
                ).notifier,
              )
              .setText(value),
        ),
        Positioned(
          bottom: 1,
          child: Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: theme.gradient,
            ),
          ),
        ),
      ],
    );
  }
}

class _MessageCreationFormFees extends ConsumerWidget {
  const _MessageCreationFormFees({
    required this.discussionAddress,
  });

  final String discussionAddress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final text = ref
        .watch(MessengerProviders.messageCreationForm(discussionAddress))
        .text;

    if (text.isEmpty) return const SizedBox(height: 12);

    final nativeFeeEstimation = ref
        .watch(
          MessengerProviders.messageCreationFees(
            discussionAddress,
            text,
          ),
        )
        .valueOrNull;

    if (nativeFeeEstimation == null) {
      return LoadingAnimationWidget.prograssiveDots(
        color: theme.text!,
        size: 12,
      );
    }

    final fiatFeeEstimation = ref
        .watch(
          MarketPriceProviders.convertedToSelectedCurrency(
            nativeAmount: nativeFeeEstimation,
          ),
        )
        .valueOrNull;

    if (fiatFeeEstimation == null) {
      return LoadingAnimationWidget.prograssiveDots(
        color: theme.text!,
        size: 12,
      );
    }

    final currencyName = ref
        .watch(
          SettingsProviders.settings.select((settings) => settings.currency),
        )
        .name;

    return SizedBox(
      child: Text(
        '+ ${AmountFormatters.standardSmallValue(
          nativeFeeEstimation,
          AccountBalance.cryptoCurrencyLabel,
        )} (${CurrencyUtil.formatWithNumberOfDigits(
          currencyName,
          fiatFeeEstimation,
          2,
        )})',
        style: theme.textStyleSize12W100Primary,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _MessagesList extends ConsumerStatefulWidget {
  const _MessagesList({
    required this.discussionAddress,
  });
  final String discussionAddress;

  @override
  ConsumerState<_MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends ConsumerState<_MessagesList> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final me = ref.watch(ContactProviders.getSelectedContact).valueOrNull;
    final pagingController = ref
        .watch(MessengerProviders.paginatedMessages(widget.discussionAddress));
    final localizations = AppLocalizations.of(context)!;

    if (me == null) return Container();

    return PagedListView(
      pagingController: pagingController,
      shrinkWrap: true,
      reverse: true,
      builderDelegate: PagedChildBuilderDelegate<DiscussionMessage>(
        noItemsFoundIndicatorBuilder: (context) => Text(
          localizations.discussionNoMessages,
          textAlign: TextAlign.center,
        ),
        itemBuilder: (context, message, index) {
          final isSentByMe = message.senderGenesisPublicKey == me.publicKey;

          if (isSentByMe) {
            return Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(left: 42, right: 8, bottom: 8),
                child: _MessageItem(
                  key: Key(message.address),
                  color: theme.background!,
                  message: message,
                  showSender: false,
                ),
              ),
            );
          }
          return Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 42, bottom: 8),
              child: _MessageItem(
                key: Key(message.address),
                color: theme.iconDataWidgetIconBackground!,
                message: message,
                showSender: true,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MessageItem extends ConsumerWidget {
  const _MessageItem({
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
    final theme = ref.watch(ThemeProviders.selectedTheme);

    final _contact = ref.watch(
      ContactProviders.getContactWithGenesisPublicKey(
        message.senderGenesisPublicKey,
      ),
    );

    return Card(
      shape: showSender
          ? const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            )
          : const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showSender)
              _contact.maybeWhen(
                data: (contact) {
                  return Text(
                    contact?.format ?? '',
                    style: theme.textStyleSize12W600Primary,
                  );
                },
                loading: () => const SizedBox(),
                orElse: () => const SizedBox(),
              ),
            const SizedBox(height: 3),
            SelectableText(
              message.content,
              style: theme.textStyleSize12W400Primary,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                message.date.formatLong(context),
                style: theme.textStyleSize10W100Primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
