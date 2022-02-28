// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:core/ui/widgets/components/icon_widget.dart';
import 'package:websafe_svg/websafe_svg.dart';

// Project imports:
import '../../../constants.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Row(
        children: [
          IconButton(
            icon: buildIconWidgetWidget(
                context,
                WebsafeSvg.asset(
                  "packages/aemail/assets/Icons/Trash.svg",
                  height: 30,
                  color: kGrayColor,
                ),
                30,
                30),
            onPressed: () {},
          ),
          IconButton(
            icon: buildIconWidgetWidget(
                context,
                WebsafeSvg.asset(
                  "packages/aemail/assets/Icons/Reply.svg",
                  height: 30,
                  color: kGrayColor,
                ),
                30,
                30),
            onPressed: () {},
          ),
          IconButton(
            icon: buildIconWidgetWidget(
                context,
                WebsafeSvg.asset(
                  "packages/aemail/assets/Icons/Reply all.svg",
                  height: 30,
                  color: kGrayColor,
                ),
                30,
                30),
            onPressed: () {},
          ),
          IconButton(
            icon: buildIconWidgetWidget(
                context,
                WebsafeSvg.asset(
                  "packages/aemail/assets/Icons/Transfer.svg",
                  height: 30,
                  color: kGrayColor,
                ),
                30,
                30),
            onPressed: () {},
          ),
          const Spacer(),
          IconButton(
            icon: buildIconWidgetWidget(
                context,
                WebsafeSvg.asset(
                  "packages/aemail/assets/Icons/Markup.svg",
                  height: 30,
                  color: kGrayColor,
                ),
                30,
                30),
            onPressed: () {},
          ),
          IconButton(
            icon: buildIconWidgetWidget(
                context,
                WebsafeSvg.asset(
                  "packages/aemail/assets/Icons/More vertical.svg",
                  height: 30,
                  color: kGrayColor,
                ),
                30,
                30),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
