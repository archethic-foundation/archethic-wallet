part of '../authentication.dart';

abstract class AuthenticationProviders {
  static final _authenticationRepository = Provider(
    (ref) => AuthenticationRepository(),
  );

  static final preferedAuthMethod = Provider<AuthenticationMethod>(
    (ref) => ref
        .read(
          SettingsProviders.localSettingsRepository,
        )
        .getAuthMethod(),
  );

  // static Future<Duration?> getRemainingLockTime(WidgetRef ref) async {
  //   final lockUntil = ref
  //       .read(
  //         SettingsProviders.localSettingsRepository,
  //       )
  //       .getLockDate();

  //   if (lockUntil == null) {
  //     return null;
  //   }

  //   return lockUntil.difference(DateTime.now().toUtc());
  // }

  static final isLocked = Provider.autoDispose<bool>(
    (ref) {
      return ref
              .watch(SettingsProviders.localSettingsRepository)
              .getLockDate() !=
          null;
    },
  );

  static final lockCountdown = StreamProvider.autoDispose<Duration>(
    (ref) async* {
      final lockDate = ref
          .watch(
            SettingsProviders.localSettingsRepository,
          )
          .getLockDate();
      if (lockDate == null) return;

      while (true) {
        final durationToWait = lockDate.difference(DateTime.now().toUtc());
        if (durationToWait < Duration.zero) {
          return;
        }

        yield durationToWait;
        await Future.delayed(const Duration(seconds: 1));
      }
    },
  );

  // static final pinAuthenticationState = FutureProvider<PinAuthenticationState>(
  //   (ref) async {
  //     final authenticationRepository = ref.read(_authenticationRepository);

  //     return PinAuthenticationState(
  //       failedAttemptsCount:
  //           await authenticationRepository.getFailedPinAttemptsCount(),
  //       maxAttemptsCount: 5,
  //     );
  //   },
  // );

  // static final authenticateWithPin =
  //     FutureProvider.family<AuthenticationResult, PinCredentials>(
  //   (ref, pin) async {
  //     final authenticationResult = await IAuthenticateWithPin(
  //       credentials: pin,
  //       repository: ref.read(_authenticationRepository),
  //     ).run();

  //     authenticationResult.maybeMap(
  //       tooMuchAttempts: (value) {
  //         ref.invalidate(lockCountdown);
  //         ref.invalidate(isLocked);
  //       },
  //       orElse: () {},
  //     );

  //     ref.invalidate(pinAuthenticationState);
  //     return authenticationResult;
  //   },
  // );

  static final pinAuthentication =
      StateNotifierProvider<PinAuthenticationNotifier, PinAuthenticationState>(
    PinAuthenticationNotifier.new,
  );
}

class PinAuthenticationNotifier extends StateNotifier<PinAuthenticationState> {
  PinAuthenticationNotifier(this.ref)
      : super(
          const PinAuthenticationState(
            failedAttemptsCount: 0,
            maxAttemptsCount: 5,
          ),
        ) {
    _loadIntialState();
  }

  final Ref ref;

  Future<void> _loadIntialState() async {
    final authenticationRepository = ref.read(
      AuthenticationProviders._authenticationRepository,
    );
    state = state.copyWith(
      failedAttemptsCount:
          await authenticationRepository.getFailedPinAttemptsCount(),
    );
  }

  Future<AuthenticationResult> authenticateWithPin(
    PinCredentials pin,
  ) async {
    final authenticationRepository = ref.read(
      AuthenticationProviders._authenticationRepository,
    );
    final authenticationResult = await IAuthenticateWithPin(
      credentials: pin,
      repository: authenticationRepository,
    ).run();

    authenticationResult.maybeMap(
      tooMuchAttempts: (value) {
        ref.invalidate(AuthenticationProviders.lockCountdown);
        ref.invalidate(AuthenticationProviders.isLocked);
      },
      orElse: () {},
    );

    state = state.copyWith(
      failedAttemptsCount:
          await authenticationRepository.getFailedPinAttemptsCount(),
    );

    return authenticationResult;
  }
}
