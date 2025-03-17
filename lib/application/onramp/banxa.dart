import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'banxa.g.dart';

@riverpod
bool isBanxaWebviewSupported(Ref ref) {
  return false;
}

@riverpod
Uri banxaWebpageUri(
  Ref ref, {
  required String tokenId,
  required String chainId,
  required String depositAddress,
}) =>
    Uri.parse(
      'https://checkout.banxa.com/?coinType=$tokenId&blockchain=$chainId&orderType=buy&walletAddress=$depositAddress&backgroundColor=0d0621&primaryColor=2c1763&secondaryColor=5f33e2&textColor=000000&theme=dark&nonce=${Random().nextInt(10000)}',
    );
