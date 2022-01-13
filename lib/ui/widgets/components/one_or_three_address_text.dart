// ignore_for_file: must_be_immutable

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:archethic_wallet/styles.dart';

enum AddressTextType { PRIMARY60, PRIMARY, SUCCESS }

class OneOrThreeLineAddressText extends StatelessWidget {
  OneOrThreeLineAddressText(
      {@required this.address, @required this.type, this.contactName});

  String? address;
  String? contactName;
  AddressTextType? type;

  @override
  Widget build(BuildContext context) {
    // One line for small displays
    if (MediaQuery.of(context).size.height < 667) {
      final String stringPartOne = address!.substring(0, 12);
      final String stringPartFive = address!.substring(36);
      switch (type!) {
        case AddressTextType.PRIMARY60:
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
        case AddressTextType.PRIMARY:
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
        case AddressTextType.SUCCESS:
          return Column(
            children: <Widget>[
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: '',
                  children: <InlineSpan>[
                    TextSpan(
                      text: stringPartOne,
                      style: AppStyles.textStyleSize14W100Sucess(context),
                    ),
                    TextSpan(
                      text: '...',
                      style: AppStyles.textStyleSize14W100Primary(context),
                    ),
                    TextSpan(
                      text: stringPartFive,
                      style: AppStyles.textStyleSize14W100Sucess(context),
                    ),
                  ],
                ),
              ),
            ],
          );
      }
    }
    // Three line
    String stringPartOne = '';
    String stringPartTwo = '';
    String stringPartThree = '';
    String stringPartFour = '';
    String stringPartFive = '';
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
      case AddressTextType.PRIMARY60:
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
                      style: AppStyles.textStyleSize14W100Text60(context)),
                ],
              ),
            )
          ],
        );
      case AddressTextType.PRIMARY:
        final Widget contactWidget = contactName != null
            ? RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: contactName,
                    style: AppStyles.textStyleSize14W100Primary(context)))
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
      case AddressTextType.SUCCESS:
        final Widget contactWidget = contactName != null
            ? RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: contactName,
                    style: AppStyles.textStyleSize14W100Sucess(context)))
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
                    style: AppStyles.textStyleSize14W100Sucess(context),
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
                    style: AppStyles.textStyleSize14W100Sucess(context),
                  ),
                ],
              ),
            )
          ],
        );
    }
  }
}
