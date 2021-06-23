// Package imports:
import 'package:event_taxi/event_taxi.dart';

// Project imports:
import 'package:archethic_mobile_wallet/network/model/response/address_txs_response.dart';

class HistoryHomeEvent implements Event {
  HistoryHomeEvent({this.items});

  final List<AddressTxsResponseResult>? items;
}
