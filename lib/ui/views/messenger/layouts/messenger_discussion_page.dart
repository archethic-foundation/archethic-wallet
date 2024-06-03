import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/market_price.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/data/messenger/discussion.dart';
import 'package:aewallet/model/data/messenger/message.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/amount_formatters.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/messenger/bloc/providers.dart';
import 'package:aewallet/ui/views/messenger/layouts/discussion_details_page.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:aewallet/util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_symbols_icons/symbols.dart';

class MessengerDiscussionPage extends ConsumerWidget
    implements SheetSkeletonInterface {
  const MessengerDiscussionPage({
    super.key,
    required this.discussionAddress,
  });

  static const routerPage = '/messenger_discussion';

  final String discussionAddress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
      thumbVisibility: false,
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    final selectedContact =
        ref.watch(ContactProviders.getSelectedContact).valueOrNull;
    final discussion =
        ref.watch(MessengerProviders.discussion(discussionAddress));
    if (discussion.value != null &&
        discussion.value!.membersPubKeys.any(
          (element) => element == selectedContact?.publicKey,
        )) {
      // User can only send a message when he is still in the discussion
      return _MessageSendForm(
        discussionAddress: discussionAddress,
      );
    }

    return const SizedBox.shrink();
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final discussion =
        ref.watch(MessengerProviders.discussion(discussionAddress));
    return SheetAppBar(
      title: discussion.maybeMap(
        data: (data) {
          final displayName = ref.watch(
            MessengerProviders.discussionDisplayName(data.value),
          );

          return displayName;
        },
        orElse: () => '           ',
      ),
      widgetLeft: IconButton(
        icon: const Icon(
          Symbols.info,
          weight: IconSize.weightM,
          opticalSize: IconSize.opticalSizeM,
          grade: IconSize.gradeM,
        ),
        onPressed: () {
          context.push(
            DiscussionDetailsPage.routerPage,
            extra: discussionAddress,
          );
        },
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 150,
      child: _MessagesList(
        discussionAddress: discussionAddress,
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
    final discussion =
        ref.watch(MessengerProviders.discussion(widget.discussionAddress));

    return discussion.maybeMap(
      data: (data) {
        final isCreating = ref.watch(
          MessengerProviders.messageCreationForm(data.value)
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
                        discussion: data.value,
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
                            color: ArchethicTheme.text,
                          ),
                        ),
                      ),
                    )
                  else
                    TextButton.icon(
                      onPressed: ref
                              .watch(
                                MessengerProviders.messageCreationForm(
                                  data.value,
                                ),
                              )
                              .text
                              .isEmpty
                          ? null
                          : () async {
                              await ref
                                  .read(
                                    MessengerProviders.messageCreationForm(
                                      data.value,
                                    ).notifier,
                                  )
                                  .createMessage();

                              textEditingController.text = ref
                                  .read(
                                    MessengerProviders.messageCreationForm(
                                      data.value,
                                    ),
                                  )
                                  .text;
                            },
                      icon: Icon(
                        Symbols.send,
                        color: ArchethicTheme.text,
                        weight: IconSize.weightM,
                        opticalSize: IconSize.opticalSizeM,
                        grade: IconSize.gradeM,
                      ),
                      label: Container(),
                    ),
                ],
              ),
              const SizedBox(height: 6),
              _MessageCreationFormFees(
                discussion: data.value,
              ),
            ],
          ),
        );
      },
      orElse: Container.new,
    );
  }
}

class _MessageTextField extends ConsumerWidget {
  const _MessageTextField({
    required this.discussion,
    required this.textEditingController,
    required this.focusNode,
  });

  final TextEditingController textEditingController;
  final Discussion discussion;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        TextField(
          maxLines: null,
          controller: textEditingController,
          focusNode: focusNode,
          onChanged: (value) => ref
              .read(
                MessengerProviders.messageCreationForm(
                  discussion,
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
              gradient: ArchethicTheme.gradient,
            ),
          ),
        ),
      ],
    );
  }
}

class _MessageCreationFormFees extends ConsumerWidget {
  const _MessageCreationFormFees({
    required this.discussion,
  });

  final Discussion discussion;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text =
        ref.watch(MessengerProviders.messageCreationForm(discussion)).text;

    if (text.isEmpty) return const SizedBox(height: 12);

    final nativeFeeEstimation = ref
        .watch(
          MessengerProviders.messageCreationFees(
            discussion.address,
            text,
          ),
        )
        .valueOrNull;

    if (nativeFeeEstimation == null) {
      return LoadingAnimationWidget.prograssiveDots(
        color: ArchethicTheme.text,
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
        color: ArchethicTheme.text,
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
        style: ArchethicThemeStyles.textStyleSize12W100Primary,
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
    final me = ref.watch(ContactProviders.getSelectedContact).valueOrNull;
    final pagingController = ref
        .watch(MessengerProviders.paginatedMessages(widget.discussionAddress));
    final localizations = AppLocalizations.of(context)!;

    if (me == null) return Container();

    return PagedListView(
      pagingController: pagingController,
      shrinkWrap: pagingController.itemList?.isNotEmpty ?? false,
      reverse: true,
      builderDelegate: PagedChildBuilderDelegate<DiscussionMessage>(
        noItemsFoundIndicatorBuilder: (context) => Center(
          child: Text(
            localizations.discussionNoMessages,
            textAlign: TextAlign.center,
          ),
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
                  color: ArchethicTheme.background,
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
                color: ArchethicTheme.iconDataWidgetIconBackground,
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
                    style: ArchethicThemeStyles.textStyleSize12W600Primary,
                  );
                },
                loading: () => const SizedBox(),
                orElse: () => const SizedBox(),
              ),
            const SizedBox(height: 3),
            SelectableText(
              message.content,
              style: ArchethicThemeStyles.textStyleSize12W100Primary,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                message.date.formatLong(context),
                style: ArchethicThemeStyles.textStyleSize10W100Primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
