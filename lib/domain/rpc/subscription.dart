import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription.freezed.dart';

@freezed
class RPCSubscription<R> with _$RPCSubscription<R> {
  const factory RPCSubscription({
    required String id,
    required Stream<R> updates,
  }) = _RPCSubscription;

  const RPCSubscription._();
}
