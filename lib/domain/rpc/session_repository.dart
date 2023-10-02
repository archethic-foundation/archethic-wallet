import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

abstract class SessionRepository {
  Future<awc.ValidatedSession?> findValidatedSession(String sessionId);
  Future<awc.SessionWaitingForValidation?> findOpeningSession(String sessionId);
  Future<void> addSession(awc.Session session);
  Future<void> updateSession(awc.Session session);
  Future<void> removeSession(String sessionId);
}
