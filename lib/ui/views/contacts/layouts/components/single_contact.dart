import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/views/contacts/layouts/components/single_contact_balance.dart';
import 'package:aewallet/ui/views/contacts/layouts/contact_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class SingleContact extends ConsumerWidget {
  const SingleContact({
    super.key,
    required this.contact,
    required this.accountBalance,
  });

  final Contact contact;
  final AsyncValue<AccountBalance> accountBalance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(),
        ),
      ),
      onPressed: () {
        context.push(
          ContactDetail.routerPage,
          extra: {'contact': contact},
        );
      },
      child: SizedBox(
        height: 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                if (contact.type == ContactType.keychainService.name)
                  Icon(
                    Symbols.account_balance_wallet,
                    color: ArchethicTheme.iconDrawer,
                    size: 25,
                    weight: IconSize.weightM,
                    opticalSize: IconSize.opticalSizeM,
                    grade: IconSize.gradeM,
                  )
                else
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Icon(
                        Symbols.person,
                        color: ArchethicTheme.iconDrawer,
                        size: 25,
                        weight: IconSize.weightM,
                        opticalSize: IconSize.opticalSizeM,
                        grade: IconSize.gradeM,
                      ),
                      if (contact.favorite == true)
                        Icon(
                          Symbols.favorite,
                          color: ArchethicTheme.favoriteIconColor,
                          size: 12,
                          weight: IconSize.weightM,
                          opticalSize: IconSize.opticalSizeM,
                          grade: IconSize.gradeM,
                          fill: 1,
                        ),
                    ],
                  ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    contact.format,
                    style: ArchethicThemeStyles.textStyleSize14W600Primary,
                  ),
                ),
                SingleContactBalance(
                  contact: contact,
                  accountBalance: accountBalance,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
