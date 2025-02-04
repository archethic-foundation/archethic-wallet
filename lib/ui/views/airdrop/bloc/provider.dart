import 'dart:convert';
import 'dart:typed_data';

import 'package:aewallet/application/airdrop/airdrop_notifier.dart';
import 'package:aewallet/application/session/session.dart';
import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/model/airdrop.dart';
import 'package:aewallet/ui/views/airdrop/bloc/state.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
class AirdropFormNotifier extends _$AirdropFormNotifier {
  AirdropFormNotifier();

  @override
  AirdropFormState build() {
    return const AirdropFormState();
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

  Future<void> joinWaitlist(AppLocalizations localizations) async {
    try {
      state = state.copyWith(joinWaitlistInProgress: true);
      if (!state.isItemsConfirmed) {
        state = state.copyWith(
          failure: const Failure.other(
            message: 'Invalid Forms',
          ),
          joinWaitlistInProgress: false,
        );
        return;
      }
      final session = ref.watch(sessionNotifierProvider).loggedIn;
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
      };

      final airdropAPISecret = dotenv.env['AIRDROP_API_SECRET'];

      final response = await http.post(
        Uri.parse('https://airdrop-backend.archethic.net/airdrop-subscription'),
        headers: {
          'Authorization': 'Bearer $airdropAPISecret',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );

      //
      if (response.statusCode == 201) {
        const airdrop = Airdrop(
          isMailFilled: true,
        );

        await ref.read(airdropNotifierProvider.notifier).setAirdrop(airdrop);

        state = state.copyWith(
          airdropProcessStep: AirdropProcessStep.supportEcosystem,
          failure: null,
        );
      } else if (response.statusCode == 400) {
        final responseBody = jsonDecode(response.body);
        var errorMessage = responseBody['error'] ?? 'Unknown error';
        switch (errorMessage) {
          case 'Missing parameters':
            errorMessage = localizations.airdropBackendMissingParameters;
            break;
          case 'Invalid email':
            errorMessage = localizations.airdropBackendInvalidEmail;
            break;
          case 'Invalid public key':
            errorMessage = localizations.airdropBackendInvalidPubKey;
            break;
          case 'Invalid signature':
            errorMessage = localizations.airdropBackendInvalidSignature;
            break;
          case 'Email or public key already exists':
            errorMessage = localizations.airdropBackendAlreadySubscribe;
            break;
          default:
            errorMessage = localizations.airdropBackendUnknownError;
        }

        state = state.copyWith(
          failure: Failure.other(
            message: errorMessage,
          ),
        );
      } else {
        if (response.statusCode == 401) {
          state = state.copyWith(
            failure: const Failure.other(
              message: 'Error 401 - Unauthorized access',
            ),
          );
        } else if (response.statusCode == 500) {
          final responseBody = jsonDecode(response.body);
          final errorMessage =
              (responseBody['error'] ?? '') + ' - ' + responseBody['details'] ??
                  'Unknown error';
          state = state.copyWith(
            failure: Failure.other(
              message: 'Error 500 - $errorMessage',
            ),
          );
        } else {
          state = state.copyWith(
            failure: Failure.other(
              message: 'Server error: ${response.statusCode}',
            ),
          );
        }
      }
    } catch (e) {
      state = state.copyWith(
        failure: Failure.network(
          message: 'Network error: $e',
        ),
      );
    }

    state = state.copyWith(joinWaitlistInProgress: false);
  }
}
