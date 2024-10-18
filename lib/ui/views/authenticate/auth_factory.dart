import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/infrastructure/datasources/vault/vault.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/ui/views/authenticate/biometrics_cipher_delegate.dart';
import 'package:aewallet/ui/views/authenticate/password_cipher_delegate.dart';
import 'package:aewallet/ui/views/authenticate/pin_cipher_delegate.dart';
import 'package:aewallet/ui/views/authenticate/yubikey_otp_cipher_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

final _logger = Logger('AuthFactory');

class AuthFactory extends InheritedWidget {
  AuthFactory({
    super.key,
    required Widget child,
  }) : super(
          child: _AuthFactory(
            key: _authFactoryKey,
            child: child,
          ),
        );

  static final _authFactoryKey = GlobalKey<__AuthFactoryState>();

  static AuthFactory? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthFactory>();
  }

  static AuthFactory of(BuildContext context) {
    final result = maybeOf(context);
    assert(result != null, 'No AuthFactory found in context');
    return result!;
  }

  void init() {
    _logger.info('Init AuthFactory and Vault authent.');
    Vault.instance()
      ..cipherDelegate = vaultCipherDelegate()
      ..shouldBeLocked = shouldBeLocked;
  }

  @override
  bool updateShouldNotify(AuthFactory oldWidget) => false;

  VaultCipherDelegate vaultCipherDelegate({
    AuthMethod? authMethod,
  }) =>
      _authFactoryKey.currentState!.vaultCipherDelegate(authMethod: authMethod);

  Future<bool> shouldBeLocked() async =>
      _authFactoryKey.currentState!.shouldBeLocked();

  Future<bool> authenticate() async =>
      _authFactoryKey.currentState!.authenticate();
}

class _AuthFactory extends ConsumerStatefulWidget {
  const _AuthFactory({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __AuthFactoryState();
}

class __AuthFactoryState extends ConsumerState<_AuthFactory> {
  VaultCipherDelegate vaultCipherDelegate({
    AuthMethod? authMethod,
  }) {
    authMethod ??= AuthenticationMethod(
      ref.read(
        AuthenticationProviders.settings.select(
          (settings) => settings.authenticationMethod,
        ),
      ),
    ).method;

    switch (authMethod) {
      case AuthMethod.password:
        return PasswordCipherDelegate(context);
      case AuthMethod.yubikeyWithYubicloud:
        return YubikeyOTPCipherDelegate(context: context);
      case AuthMethod.pin:
        return PinCipherDelegate(context);
      case AuthMethod.biometrics:
        return BiometricsCipherDelegate(context: context);
    }
  }

  Future<bool> shouldBeLocked() async {
    _logger.info('Check if vault should be locked');
    final value = await ref.read(
      AuthenticationProviders.authenticationGuard.future,
    );

    final lockDate = value.lockDate;
    final authentRequired = lockDate != null;

    if (!authentRequired) {
      return false;
    }

    final durationBeforeLock = lockDate.difference(DateTime.now());
    _logger.info(
      'Duration before lock : $durationBeforeLock',
    );
    return durationBeforeLock <= Duration.zero;
  }

  Future<bool> authenticate() async {
    return ref
        .read(
          AuthenticationProviders.authenticationGuard.notifier,
        )
        .verifyUnlockAbility();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
