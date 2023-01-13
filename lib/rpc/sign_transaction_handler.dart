part of 'server.dart';

@freezed
class SignTransactionResult with _$SignTransactionResult {
  const SignTransactionResult._();

  const factory SignTransactionResult.success({
    required int validationsCount,
  }) = _Success;

  const factory SignTransactionResult.error() = _Error;

  factory SignTransactionResult.fromJson(Map<String, dynamic> json) =>
      _$SignTransactionResultFromJson(json);
}

Future<Response> _sendTransactionHandler(Request request) async {
  log('Sign transaction command received', name: 'ArchethicRPCServer');
  TransactionDTO transaction;
  try {
    final body = await request.readAsString();
    transaction = TransactionDTO.fromJson(jsonDecode(body));
  } catch (e) {
    log('Bad request', error: e, name: 'Send transaction handler');
    return Response.badRequest();
  }

  return Response.ok(
    jsonEncode(
      const SignTransactionResult.success(validationsCount: 1).toJson(),
    ),
  );
}
