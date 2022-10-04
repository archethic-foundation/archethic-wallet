/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/ui/util/styles.dart';
import 'package:flutter/material.dart';

enum AddressTextType { primary60, primary }

class OneOrThreeLineAddressText extends StatelessWidget {
  const OneOrThreeLineAddressText({
    super.key,
    @required this.address,
    @required this.type,
    this.contactName,
  });

  final String? address;
  final String? contactName;
  final AddressTextType? type;

  @override
  Widget build(BuildContext context) {
    // One line for small displays
    if (MediaQuery.of(context).size.height < 667) {
      final stringPartOne = address!.substring(0, 12);
      final stringPartFive = address!.substring(36);
      switch (type!) {
        case AddressTextType.primary60:
          return Column(
            children: <Widget>[
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: '',
                  children: <InlineSpan>[
                    TextSpan(
                      text: stringPartOne,
                      style: AppStyles.textStyleSize14W100Text60(context),
                    ),
                    TextSpan(
                      text: '...',
                      style: AppStyles.textStyleSize14W100Text60(context),
                    ),
                    TextSpan(
                      text: stringPartFive,
                      style: AppStyles.textStyleSize14W100Text60(context),
                    ),
                  ],
                ),
              ),
            ],
          );
        case AddressTextType.primary:
          return Column(
            children: <Widget>[
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: '',
                  children: <InlineSpan>[
                    TextSpan(
                      text: stringPartOne,
                      style: AppStyles.textStyleSize14W100Primary(context),
                    ),
                    TextSpan(
                      text: '...',
                      style: AppStyles.textStyleSize14W100Primary(context),
                    ),
                    TextSpan(
                      text: stringPartFive,
                      style: AppStyles.textStyleSize14W100Primary(context),
                    ),
                  ],
                ),
              ),
            ],
          );
      }
    }
    // Three line
    var stringPartOne = '';
    var stringPartTwo = '';
    var stringPartThree = '';
    var stringPartFour = '';
    var stringPartFive = '';
    if (address!.length >= 12) {
      stringPartOne = address!.substring(0, 12);
    } else {
      stringPartOne = address!.substring(0, address!.length);
    }
    if (address!.length >= 22) {
      stringPartTwo = address!.substring(12, 22);
    } else {
      if (address!.length > 22) {
        stringPartTwo = address!.substring(12, address!.length);
      }
    }
    if (address!.length >= 44) {
      stringPartThree = address!.substring(22, 44);
    } else {
      if (address!.length > 22) {
        stringPartThree = address!.substring(22, address!.length);
      }
    }
    if (address!.length >= 59) {
      stringPartFour = address!.substring(44, 59);
    } else {
      if (address!.length > 44) {
        stringPartFour = address!.substring(44, address!.length);
      } else {}
    }
    if (address!.length >= 60) {
      stringPartFive = address!.substring(59);
    }
    switch (type!) {
      case AddressTextType.primary60:
        return Column(
          children: <Widget>[
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: <InlineSpan>[
                  TextSpan(
                    text: stringPartOne,
                    style: AppStyles.textStyleSize14W100Text60(context),
                  ),
                  TextSpan(
                    text: stringPartTwo,
                    style: AppStyles.textStyleSize14W100Text60(context),
                  ),
                ],
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: <InlineSpan>[
                  TextSpan(
                    text: stringPartThree,
                    style: AppStyles.textStyleSize14W100Text60(context),
                  ),
                ],
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: <InlineSpan>[
                  TextSpan(
                    text: stringPartFour,
                    style: AppStyles.textStyleSize14W100Text60(context),
                  ),
                  TextSpan(
                    text: stringPartFive,
                    style: AppStyles.textStyleSize14W100Text60(context),
                  ),
                ],
              ),
            )
          ],
        );
      case AddressTextType.primary:
        final Widget contactWidget = contactName != null
            ? RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: contactName,
                  style: AppStyles.textStyleSize14W100Primary(context),
                ),
              )
            : const SizedBox();
        return Column(
          children: <Widget>[
            contactWidget,
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: <InlineSpan>[
                  TextSpan(
                    text: stringPartOne,
                    style: AppStyles.textStyleSize14W100Primary(context),
                  ),
                  TextSpan(
                    text: stringPartTwo,
                    style: AppStyles.textStyleSize14W100Primary(context),
                  ),
                ],
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: <InlineSpan>[
                  TextSpan(
                    text: stringPartThree,
                    style: AppStyles.textStyleSize14W100Primary(context),
                  ),
                ],
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: <InlineSpan>[
                  TextSpan(
                    text: stringPartFour,
                    style: AppStyles.textStyleSize14W100Primary(context),
                  ),
                  TextSpan(
                    text: stringPartFive,
                    style: AppStyles.textStyleSize14W100Primary(context),
                  ),
                ],
              ),
            )
          ],
        );
    }
  }
}
