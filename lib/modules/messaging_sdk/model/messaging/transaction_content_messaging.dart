import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_content_messaging.freezed.dart';
part 'transaction_content_messaging.g.dart';

@freezed
abstract class TransactionContentMessaging with _$TransactionContentMessaging {
  const factory TransactionContentMessaging({
    required String compressionAlgo,
    required String message,
  }) = _TransactionContentMessaging;

  factory TransactionContentMessaging.fromJson(Map<String, dynamic> json) =>
      _$TransactionContentMessagingFromJson(json);
}
