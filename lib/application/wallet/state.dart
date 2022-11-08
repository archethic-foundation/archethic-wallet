part of 'wallet.dart';

@immutable
abstract class Session {
  const factory Session.loggedIn({
    required AppWallet wallet,
  }) = LoggedInSession;

  const factory Session.loggedOut() = LoggedOutSession;

  bool get isLoggedIn;
  LoggedInSession? get loggedIn;
  bool get isLoggedOut;
  LoggedOutSession? get loggedOut;
}

class LoggedInSession implements Session {
  const LoggedInSession({
    required this.wallet,
  });

  final AppWallet wallet;

  @override
  LoggedInSession? get loggedIn => this;

  @override
  LoggedOutSession? get loggedOut => null;

  @override
  bool get isLoggedIn => true;

  @override
  bool get isLoggedOut => false;
}

class LoggedOutSession implements Session {
  const LoggedOutSession();

  @override
  LoggedInSession? get loggedIn => null;

  @override
  LoggedOutSession? get loggedOut => this;

  @override
  bool get isLoggedIn => false;

  @override
  bool get isLoggedOut => true;
}
