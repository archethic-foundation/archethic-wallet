import 'dart:math';
import 'dart:typed_data';

import 'package:aewallet/domain/rpc/session_repository.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:uuid/uuid.dart';

class RPCSessionService {
  RPCSessionService({required this.repository});

  final SessionRepository repository;

  awc.SessionWaitingForValidation startSession() {
    final newSession = awc.SessionWaitingForValidation(
      createdAt: DateTime.now(),
      sessionId: const Uuid().v4(),
      aesKey: Uint8List.fromList(
        List<int>.generate(
          32,
          (int i) => Random.secure().nextInt(256),
        ),
      ),
    );

    repository.addSession(newSession);

    return newSession;
  }

  Future<awc.Session?> findSession(
    String sessionId,
  ) async =>
      (await repository.findOpeningSession(sessionId)) ??
      (await repository.findValidatedSession(sessionId));

  Future<awc.SessionWaitingForValidation?> findOpeningSession(
    String sessionId,
  ) =>
      repository.findOpeningSession(sessionId);

  Future<awc.ValidatedSession?> findValidatedSession(String sessionId) =>
      repository.findValidatedSession(sessionId);

  Future<awc.ValidatedSession> validateSession({
    required String sessionId,
    required awc.RPCSessionOrigin origin,
  }) async {
    final openingSession = await repository.findOpeningSession(sessionId);

    if (openingSession == null) {
      throw Exception(); // TODO(Chralu): check which exception to throw
    }

    final validatedSession = awc.ValidatedSession(
      createdAt: DateTime.now(),
      sessionId: sessionId,
      aesKey: openingSession.aesKey,
      origin: origin,
    );
    await repository.updateSession(
      validatedSession,
    );
    return validatedSession;
  }

  Future<void> invalidateSession({required String sessionId}) async {
    return repository.removeSession(sessionId);
  }
}
