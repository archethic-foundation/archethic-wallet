import 'package:aewallet/domain/rpc/session_service.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
RPCSessionService _sessionService(Ref ref) => sl.get<RPCSessionService>();

abstract class RPCSessionProviders {
  static final sessionsService = _sessionServiceProvider;
}
