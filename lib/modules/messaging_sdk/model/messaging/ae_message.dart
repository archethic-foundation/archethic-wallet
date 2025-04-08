import 'package:freezed_annotation/freezed_annotation.dart';

part 'ae_message.freezed.dart';
part 'ae_message.g.dart';

@freezed
class AEMessage with _$AEMessage {
  const factory AEMessage({
    @Default('') final String address,
    @Default('') final String senderGenesisPublicKey,
    @Default('') final String content,
    @Default(0) final int timestampCreation,
    @Default('') final String sender,
  }) = _AEMessage;
  const AEMessage._();

  factory AEMessage.fromJson(Map<String, dynamic> json) =>
      _$AEMessageFromJson(json);
}
