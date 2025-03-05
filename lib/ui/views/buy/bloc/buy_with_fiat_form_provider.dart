import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'buy_with_fiat_form_provider.g.dart';

typedef BuyWithFiatFormState = ({bool disclaimerAcknowledged});

extension StateTools on BuyWithFiatFormState {
  bool get canProceed => this.disclaimerAcknowledged;
}

@riverpod
class BuyWithFiatForm extends _$BuyWithFiatForm {
  @override
  BuyWithFiatFormState build() => (disclaimerAcknowledged: false);

  void acknowledgeDisclaimer(bool ack) {
    state = (disclaimerAcknowledged: ack);
  }
}
