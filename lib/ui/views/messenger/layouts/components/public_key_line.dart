import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/access_recipient_formatters.dart';
import 'package:aewallet/ui/views/messenger/bloc/providers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class PublicKeyLine extends ConsumerWidget {
  const PublicKeyLine({
    super.key,
    required this.pubKey,
    required this.listAdmins,
    this.onTap,
    this.onInfoTap,
  });

  final List<String> listAdmins;
  final String pubKey;
  final VoidCallback? onTap;
  final VoidCallback? onInfoTap;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final localizations = AppLocalizations.of(context)!;
    final accessRecipient = ref.watch(
      MessengerProviders.accessRecipientWithPublicKey(
        pubKey,
      ),
    );

    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: ArchethicTheme.backgroundAccountsListCardSelected,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      color: ArchethicTheme.backgroundAccountsListCardSelected,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          color: ArchethicTheme.backgroundAccountsListCard,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AutoSizeText(
                  accessRecipient.maybeMap(
                    data: (data) => data.value.format(localizations),
                    orElse: () => '...',
                  ),
                  style: ArchethicThemeStyles.textStyleSize12W600Primary,
                ),
              ),
              _MemberRole(
                listAdmins: listAdmins,
                memberPubKey: pubKey,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: IconButton(
                  onPressed: onInfoTap ?? onTap,
                  icon: const Icon(
                    Symbols.info,
                    size: 22,
                    weight: IconSize.weightM,
                    opticalSize: IconSize.opticalSizeM,
                    grade: IconSize.gradeM,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MemberRole extends ConsumerWidget {
  const _MemberRole({
    required this.memberPubKey,
    required this.listAdmins,
  });

  final String memberPubKey;
  final List<String> listAdmins;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final isAdmin = listAdmins.any(
      (adminPubKey) => adminPubKey == memberPubKey,
    );

    if (isAdmin) {
      return Text(
        localizations.admin,
        style: ArchethicThemeStyles.textStyleSize10W600Primary,
      );
    }

    return Container();
  }
}
