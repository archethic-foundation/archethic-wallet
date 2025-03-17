import 'dart:convert';
import 'dart:typed_data';

import 'package:aewallet/application/aeswap/dex_token.dart';
import 'package:aewallet/application/airdrop/airdrop.dart';
import 'package:aewallet/application/session/session.dart';
import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/model/airdrop.dart';
import 'package:aewallet/modules/aeswap/application/session/provider.dart';
import 'package:aewallet/modules/aeswap/application/session/state.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/provider.dart';
import 'package:aewallet/ui/views/airdrop/bloc/airdrop_banner_status.dart';
import 'package:aewallet/ui/views/airdrop/bloc/state.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_banner.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:decimal/decimal.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
Future<AirdropBannerStatus> airdropBannerStatus(
  Ref ref,
) async {
  print('#### debut status');
  final userInfo = await ref.watch(airdropUserInfoProvider.future);
  print('#### 1');
  final personalLP = await ref.watch(airdropPersonalLPProvider.future);
  print('#### 2');
  if (userInfo.email == null) {
    print('#### 3');
    return const AirdropBannerStatus(state: AirdropState.newParticipation);
  }
  print('#### 4');
  if (userInfo.isMailConfirmed == null) {
    print('#### 5');
    if (personalLP.personalLP < 1) {
      print('#### 6');
      return AirdropBannerStatus(
        state: AirdropState.newParticipation,
        email: userInfo.email,
      );
    }
    print('#### 7');
    return AirdropBannerStatus(
      state: AirdropState.shouldAddMail,
      email: userInfo.email,
    );
  }
  print('#### 8');
  if (userInfo.isMailConfirmed == false) {
    print('#### 9');
    if (personalLP.personalLP >= 1) {
      print('#### 10');
      return AirdropBannerStatus(
        state: AirdropState.shouldConfirmMail,
        email: userInfo.email,
      );
    }
    print('#### 11');
    return AirdropBannerStatus(
      state: AirdropState.shouldConfirmMailAndFarm,
      email: userInfo.email,
    );
  }
  print('#### 12');
  if (personalLP.personalLP >= 1) {
    print('#### 13');
    return AirdropBannerStatus(state: AirdropState.ok, email: userInfo.email);
  }
  print('#### 14');
  return AirdropBannerStatus(
    state: AirdropState.shouldFarm,
    email: userInfo.email,
  );
}

@riverpod
Future<double> airdropUCOPerParticipantFiatValue(
  Ref ref,
) async {
  var ucoPerParticipant = 0.0;
  final airdropCount = await ref.watch(airdropCountProvider.future);
  if (airdropCount.participantCount != null &&
      airdropCount.participantCount! > 0) {
    ucoPerParticipant = (Decimal.parse('100000000') /
            Decimal.fromInt(
              airdropCount.participantCount!,
            ))
        .toDecimal(scaleOnInfinitePrecision: 8)
        .toDouble();
  }

  return ucoPerParticipant;
}

@riverpod
class AirdropFormNotifier extends _$AirdropFormNotifier {
  AirdropFormNotifier();

  @override
  AirdropFormState build() {
    ref.onDispose(_dispose);

    return const AirdropFormState();
  }

  void _dispose() {
    ref
      ..invalidate(airdropUserInfoProvider)
      ..invalidate(airdropPersonalLPProvider);
  }

  void setLoading(bool loading) {
    state = state.copyWith(
      loading: loading,
    );
  }

  void setReferralCodeProvided(String referralCodeProvided) {
    state = state.copyWith(
      referralCodeProvided: referralCodeProvided,
      failure: null,
    );
  }

  void setConfirmOnlyOneAirdrop(bool confirmOnlyOneAirdrop) {
    state = state.copyWith(
      confirmOnlyOneAirdrop: confirmOnlyOneAirdrop,
      failure: null,
    );
  }

  void setConfirmNotMultipleRegistrations(
    bool confirmNotMultipleRegistrations,
  ) {
    state = state.copyWith(
      confirmNotMultipleRegistrations: confirmNotMultipleRegistrations,
      failure: null,
    );
  }

  void setConfirmPrivacyPolicy(bool confirmPrivacyPolicy) {
    state = state.copyWith(
      confirmPrivacyPolicy: confirmPrivacyPolicy,
      failure: null,
    );
  }

  void setAirdropProcessStep(AirdropProcessStep airdropProcessStep) {
    state =
        state.copyWith(airdropProcessStep: airdropProcessStep, failure: null);
  }

  void setFailure(Failure? failure) {
    state = state.copyWith(failure: failure);
  }

  void setMailAddress(String mailAddress) {
    state =
        state.copyWith(mailAddress: mailAddress.toLowerCase(), failure: null);
  }

  void setPersonalLP(double personalLP) {
    state = state.copyWith(
      personalLP: personalLP,
      personalMultiplier: Airdrop.airdropPersonalMultiplier(personalLP) ?? 0,
    );
  }

  void setReferralCode(String referralCode) {
    state = state.copyWith(referralCode: referralCode);
  }

  void setReferralsRegistered(int referralsRegistered) {
    state = state.copyWith(referralsRegistered: referralsRegistered);
  }

  void setReferralsParticipant(int referralsParticipant) {
    state = state.copyWith(referralsParticipant: referralsParticipant);
  }

  void setReferralMultiplier(int referralMultiplier) {
    state = state.copyWith(referralMultiplier: referralMultiplier);
  }

  void setPersonalLPFlexible(double personalLPFlexible) {
    state = state.copyWith(personalLPFlexible: personalLPFlexible);
  }

  void setActualLPFiatValue(double actualLPFiatValue) {
    state = state.copyWith(actualLPFiatValue: actualLPFiatValue);
  }

  Future<bool> controlReferralCodeProvided(
    AppLocalizations localizations,
  ) async {
    state = state.copyWith(failure: null);

    final response = await ref.read(
      checkReferralCodeProvidedProvider(state.referralCodeProvided!).future,
    );
    if (response == false) {
      state = state.copyWith(
        failure: Failure.other(
          message: localizations.airdropWrongReferralCodeProvided,
        ),
      );
      return false;
    }

    return true;
  }

  Future<void> resendConfirmationMail(AppLocalizations localizations) async {
    state = state.copyWith(resendConfirmationEmailInfo: null, failure: null);

    final response = await ref
        .read(resendConfirmationMailProvider(state.mailAddress!).future);
    if (response == null) {
      state = state.copyWith(
        failure: const Failure.network(
          message: 'Network error',
        ),
        resendConfirmationEmailInfo: 'Network error',
      );
      return;
    }

    //
    if (response.statusCode == 200) {
      state = state.copyWith(
        resendConfirmationEmailInfo: localizations.airdropBackendEmailSent,
      );
    } else if (response.statusCode == 400) {
      final responseBody = jsonDecode(response.body);
      var errorMessage = responseBody['error'] ?? 'Unknown error';
      switch (errorMessage) {
        case 'Email parameter is missing':
          errorMessage = localizations.airdropBackendMissingParameters;
          break;
        case 'Email not found':
          errorMessage = localizations.airdropBackendEmailNotFound;
          break;
        case 'Email already confirmed':
          errorMessage = localizations.airdropBackendEmailAlreadyConfirmed;
          break;
        default:
          errorMessage = localizations.airdropBackendUnknownError;
      }

      state = state.copyWith(
        failure: Failure.other(
          message: errorMessage,
        ),
        resendConfirmationEmailInfo: errorMessage,
      );
    } else {
      if (response.statusCode == 500) {
        final responseBody = jsonDecode(response.body);
        final errorMessage =
            '${responseBody['error'] ?? ''} - ${responseBody['details'] ?? 'Unknown error'}';
        state = state.copyWith(
          failure: Failure.other(
            message: 'Error 500 - $errorMessage',
          ),
          resendConfirmationEmailInfo: errorMessage,
        );
      }
    }
  }

  Future<({bool mailConfirmed, bool havePersonalLP})>
      checkConfirmation() async {
    state = state.copyWith(checkConfirmInProgress: true, failure: null);
    final airdropUserInfo = await ref.refresh(airdropUserInfoProvider.future);
    if (airdropUserInfo.email != null) {
      final airdropPersonalLP =
          await ref.refresh(airdropPersonalLPProvider.future);
      setPersonalLP(airdropPersonalLP.personalLP);
      setPersonalLPFlexible(airdropPersonalLP.personalLPFlexible);
    }

    var actualLPFiatValue = 0.0;
    final environment = ref.read(environmentProvider);
    final farmLock = ref.read(farmLockFormFarmLockProvider).value;
    if (farmLock != null && farmLock.lpTokenPair != null) {
      actualLPFiatValue = await ref.read(
        DexTokensProviders.estimateLPTokenInFiat(
          farmLock.lpTokenPair!.token1.address,
          farmLock.lpTokenPair!.token2.address,
          1,
          environment.aeETHUCOPoolAddress,
        ).future,
      );
    }
    setActualLPFiatValue(actualLPFiatValue);
    state = state.copyWith(checkConfirmInProgress: false, failure: null);

    return (
      mailConfirmed: airdropUserInfo.isMailConfirmed ?? false,
      havePersonalLP: state.personalLP > 0
    );
  }

  Future<void> joinWaitlist(AppLocalizations localizations) async {
    Failure? failure;
    try {
      state = state.copyWith(joinWaitlistInProgress: true, failure: null);
      if (!state.isItemsConfirmed) {
        state = state.copyWith(
          failure: const Failure.other(
            message: 'Invalid Forms',
          ),
          joinWaitlistInProgress: false,
        );
        return;
      }
      final session = ref.read(sessionNotifierProvider).loggedIn;
      final keychainKeypair = archethic.deriveKeyPair(
        archethic.uint8ListToHex(
          Uint8List.fromList(session!.wallet.keychainSecuredInfos.seed),
        ),
        0,
      );
      final signedPayload = archethic.sign(
        Airdrop.messageToSign,
        keychainKeypair.privateKey,
        isDataHexa: false,
      );

      final payload = {
        'email': state.mailAddress,
        'pubkey': archethic.uint8ListToHex(keychainKeypair.publicKey!),
        'signedPayload': base64Url.encode(signedPayload),
        'usedReferralCode': state.referralCodeProvided,
      };

      const airdropAPISecret = String.fromEnvironment('AIRDROP_API_SECRET');
      final timestamp =
          (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
      final publicKey = archethic.uint8ListToHex(keychainKeypair.publicKey!);
      final signedPayloadHeader = archethic.sign(
        '$publicKey$timestamp',
        keychainKeypair.privateKey,
        isDataHexa: false,
      );

      final airdropBackendUrl = ref.read(airdropBackendUrlProvider);
      final response = await http.post(
        Uri.parse('$airdropBackendUrl/airdrop-subscription'),
        headers: {
          'Authorization': 'Bearer $airdropAPISecret',
          'Content-Type': 'application/json',
          'x-public-key': base64Encode(utf8.encode(publicKey)),
          'x-timestamp': timestamp,
          'x-signature': base64Url.encode(signedPayloadHeader),
        },
        body: jsonEncode(payload),
      );

      //

      if (response.statusCode == 201) {
        setAirdropProcessStep(AirdropProcessStep.confirmEmail);
      } else if (response.statusCode == 400) {
        final responseBody = jsonDecode(response.body);
        var errorMessage = responseBody['error'] ?? 'Unknown error';
        switch (errorMessage) {
          case 'Missing parameters':
          case 'Missing required headers':
          case 'Invalid timestamp':
            errorMessage = localizations.airdropBackendMissingParameters;
            break;
          case 'Invalid email':
            errorMessage = localizations.airdropBackendInvalidEmail;
            break;
          case 'Invalid public key':
            errorMessage = localizations.airdropBackendInvalidPubKey;
            break;
          case 'Invalid signature':
          case 'Malformed signature':
            errorMessage = localizations.airdropBackendInvalidSignature;
            break;
          case 'Email or public key already exists':
            errorMessage = localizations.airdropBackendAlreadySubscribe;
            break;
          default:
            errorMessage = localizations.airdropBackendUnknownError;
        }

        failure = Failure.other(
          message: errorMessage,
        );
      } else {
        if (response.statusCode == 401) {
          failure = const Failure.other(
            message: 'Error 401 - Unauthorized access',
          );
        } else if (response.statusCode == 500) {
          final responseBody = jsonDecode(response.body);
          final errorMessage =
              '${responseBody['error'] ?? ''} - ${responseBody['details'] ?? 'Unknown error'}';
          failure = Failure.other(
            message: 'Error 500 - $errorMessage',
          );
        } else {
          failure = Failure.other(
            message: 'Server error: ${response.statusCode}',
          );
        }
      }
    } catch (e) {
      failure = Failure.network(
        message: 'Network error: $e',
      );
    }
    state = state.copyWith(
      joinWaitlistInProgress: false,
      failure: failure,
    );
  }
}
