// Flutter imports:
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:websafe_svg/websafe_svg.dart';

// Project imports:
import 'package:aemail/constants.dart';
import 'side_menu_item.dart';
import 'tags.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
      color: StateContainer.of(context).curTheme.background,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            children: [
              const SizedBox(height: kDefaultPadding),
              FlatButton.icon(
                minWidth: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: kDefaultPadding,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: kBgDarkColor,
                onPressed: () {},
                icon: WebsafeSvg.asset("packages/aemail/assets/Icons/Edit.svg",
                    width: 16),
                label: const Text(
                  "New message",
                  style: TextStyle(color: kTextColor),
                ),
              ),
              const SizedBox(height: kDefaultPadding),
              FlatButton.icon(
                minWidth: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: kDefaultPadding,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: kBgDarkColor,
                onPressed: () {},
                icon: WebsafeSvg.asset(
                    "packages/aemail/assets/Icons/Download.svg",
                    width: 16),
                label: const Text(
                  "Get messages",
                  style: TextStyle(color: kTextColor),
                ),
              ),
              const SizedBox(height: kDefaultPadding * 2),
              // Menu Items
              SideMenuItem(
                press: () {},
                title: "Inbox",
                iconSrc: "packages/aemail/assets/Icons/Inbox.svg",
                isActive: true,
                itemCount: 3,
              ),
              SideMenuItem(
                press: () {},
                title: "Sent",
                iconSrc: "packages/aemail/assets/Icons/Send.svg",
                isActive: false,
              ),
              SideMenuItem(
                press: () {},
                title: "Drafts",
                iconSrc: "packages/aemail/assets/Icons/File.svg",
                isActive: false,
              ),
              SideMenuItem(
                press: () {},
                title: "Deleted",
                iconSrc: "packages/aemail/assets/Icons/Trash.svg",
                isActive: false,
                showBorder: false,
              ),

              const SizedBox(height: kDefaultPadding * 2),
              // Tags
              const Tags(),
            ],
          ),
        ),
      ),
    );
  }
}
