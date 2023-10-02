import 'package:aewallet/domain/rpc/session_repository.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:collection/collection.dart';

class SessionRepositoryImpl implements SessionRepository {
  final List<awc.SessionWaitingForValidation> openingSessions = [];
  final List<awc.ValidatedSession> sessions = [];

  @override
  Future<void> addSession(awc.Session session) async {
    session.map(
      waitingForValidation: (waitingForValidation) {
        openingSessions.add(waitingForValidation);
      },
      validated: (validated) {
        sessions.add(validated);
      },
    );
  }

  @override
  Future<awc.SessionWaitingForValidation?> findOpeningSession(
    String sessionId,
  ) async =>
      openingSessions.firstWhereOrNull(
        (element) => element.sessionId == sessionId,
      );

  @override
  Future<awc.ValidatedSession?> findValidatedSession(String sessionId) async =>
      sessions.firstWhereOrNull(
        (element) => element.sessionId == sessionId,
      );

  @override
  Future<void> removeSession(String sessionId) async {
    sessions.removeWhere((element) => element.sessionId == sessionId);
    openingSessions.removeWhere((element) => element.sessionId == sessionId);
  }

  @override
  Future<void> updateSession(awc.Session session) async {
    await removeSession(session.sessionId);
    await addSession(session);
  }
}
