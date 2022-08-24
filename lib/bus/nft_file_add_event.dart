/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:event_taxi/event_taxi.dart';

class NftFileAddEvent implements Event {
  NftFileAddEvent({this.tokenProperties});

  final List<TokenProperty>? tokenProperties;
}
