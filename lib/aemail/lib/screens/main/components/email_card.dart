import 'package:aemail/models/email.dart';
import 'package:core/appstate_container.dart';
import 'package:core/ui/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../../constants.dart';
import '../../../extensions.dart';

class EmailCard extends StatelessWidget {
  const EmailCard({
    Key? key,
    this.isActive = true,
    this.email,
    this.press,
  }) : super(key: key);

  final bool? isActive;
  final Email? email;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      child: InkWell(
        onTap: press,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                color: isActive!
                    ? StateContainer.of(context).curTheme.backgroundDarkest
                    : StateContainer.of(context).curTheme.backgroundDark,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 32,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage(email!.image!),
                        ),
                      ),
                      const SizedBox(width: kDefaultPadding / 2),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: "${email!.name} \n",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: AppFontSizes.size14,
                              fontWeight: FontWeight.w700,
                              color: isActive! ? Colors.white : kTextColor,
                            ),
                            children: [
                              TextSpan(
                                text: email!.subject,
                                style: AppStyles.textStyleSize14W100Primary(
                                    context),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            email!.time!,
                            style:
                                AppStyles.textStyleSize12W100Primary(context),
                          ),
                          const SizedBox(height: 5),
                          if (email!.isAttachmentAvailable!)
                            WebsafeSvg.asset(
                              "packages/aemail/assets/Icons/Paperclip.svg",
                              color: isActive! ? Colors.white70 : kGrayColor,
                            )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  Text(
                    email!.body!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.textStyleSize10W100Primary(context),
                  )
                ],
              ),
            ).addNeumorphism(
              blurRadius: 5,
              borderRadius: 15,
              offset: const Offset(1, 1),
              topShadowColor: Colors.white60,
              bottomShadowColor: const Color(0xFF234395).withOpacity(0.15),
            ),
            if (!email!.isChecked!)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  height: 12,
                  width: 12,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: kBadgeColor,
                  ),
                ).addNeumorphism(
                  blurRadius: 4,
                  borderRadius: 8,
                  offset: const Offset(2, 2),
                ),
              ),
            if (email!.tagColor != null)
              Positioned(
                left: 8,
                top: 0,
                child: WebsafeSvg.asset(
                  "packages/aemail/assets/Icons/Markup filled.svg",
                  height: 18,
                  color: email!.tagColor,
                ),
              )
          ],
        ),
      ),
    );
  }
}
