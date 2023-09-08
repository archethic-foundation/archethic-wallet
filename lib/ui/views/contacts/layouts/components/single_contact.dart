import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/contacts/layouts/contact_detail.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class SingleContact extends ConsumerWidget {
  const SingleContact({super.key, required this.contact});

  final Contact contact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(),
        ),
      ),
      onPressed: () {
        Sheets.showAppHeightNineSheet(
          context: context,
          ref: ref,
          widget: ContactDetail(
            contact: contact,
          ),
        );
      },
      child: Column(
        children: <Widget>[
          Divider(
            height: 2,
            color: theme.text15,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            margin: const EdgeInsetsDirectional.only(start: 10, end: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            if (contact.type ==
                                ContactType.keychainService.name)
                              Icon(
                                Symbols.account_balance_wallet,
                                color: theme.iconDrawer,
                                size: 25,
                                weight: 300,
                                opticalSize: 48,
                                grade: -25,
                              )
                            else
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Icon(
                                    Symbols.person,
                                    color: theme.iconDrawer,
                                    size: 25,
                                    weight: 300,
                                    opticalSize: 48,
                                    grade: -25,
                                  ),
                                  if (contact.favorite == true)
                                    Icon(
                                      Symbols.favorite,
                                      color: theme.favoriteIconColor,
                                      size: 12,
                                      weight: 300,
                                      opticalSize: 48,
                                      grade: -25,
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
                                style: theme.textStyleSize14W600Primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
