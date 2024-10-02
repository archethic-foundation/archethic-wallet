import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/consent_uri.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';

class ConsentWidget extends StatelessWidget {
  const ConsentWidget({
    super.key,
    required this.consentDateTime,
    required this.consentChecked,
    required this.onToggleConsent,
    this.textStyle,
  });
  final DateTime? consentDateTime;
  final bool consentChecked;
  final ValueChanged<bool?> onToggleConsent;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: consentDateTime == null
          ? aedappfm.ConsentToCheck(
              consentChecked: consentChecked,
              onToggleConsent: onToggleConsent,
              uriPrivacyPolicy: kURIPrivacyPolicy,
              uriTermsOfUse: kURITermsOfUse,
              textStyle: textStyle ?? AppTextStyles.bodyMedium(context),
            )
          : aedappfm.ConsentAlready(
              consentDateTime: consentDateTime!,
              uriPrivacyPolicy: kURIPrivacyPolicy,
              uriTermsOfUse: kURITermsOfUse,
              textStyle: textStyle ?? AppTextStyles.bodyMedium(context),
            ),
    );
  }
}
