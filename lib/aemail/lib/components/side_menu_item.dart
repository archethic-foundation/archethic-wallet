// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:core/appstate_container.dart';
import 'package:websafe_svg/websafe_svg.dart';

// Project imports:
import '../constants.dart';
import 'counter_badge.dart';

class SideMenuItem extends StatelessWidget {
  const SideMenuItem({
    Key? key,
    this.isActive,
    this.isHover = false,
    this.itemCount,
    this.showBorder = true,
    @required this.iconSrc,
    @required this.title,
    @required this.press,
  }) : super(key: key);

  final bool? isActive, isHover, showBorder;
  final int? itemCount;
  final String? iconSrc, title;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: InkWell(
        onTap: press,
        child: Row(
          children: [
            (isActive! || isHover!)
                ? WebsafeSvg.asset(
                    "packages/aemail/assets/Icons/Angle right.svg",
                    width: 15,
                  )
                : const SizedBox(width: 15),
            const SizedBox(width: kDefaultPadding / 4),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(bottom: 15, right: 5),
                decoration: showBorder!
                    ? const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Color(0xFFDFE2EF)),
                        ),
                      )
                    : null,
                child: Row(
                  children: [
                    WebsafeSvg.asset(
                      iconSrc!,
                      height: 20,
                      color: (isActive! || isHover!)
                          ? StateContainer.of(context).curTheme.iconDrawerColor!
                          : StateContainer.of(context)
                              .curTheme
                              .iconDrawerColor!,
                    ),
                    const SizedBox(width: kDefaultPadding * 0.75),
                    Text(
                      title!,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color:
                            (isActive! || isHover!) ? kTextColor : kGrayColor,
                      ),
                    ),
                    const Spacer(),
                    if (itemCount != null) CounterBadge(count: itemCount)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
