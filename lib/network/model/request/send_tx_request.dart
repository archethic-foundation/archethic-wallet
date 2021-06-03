// To parse this JSON data, do
//
//     final sendTxRequest = sendTxRequestFromJson(jsonString);

// @dart=2.9

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:asn1lib/asn1lib.dart' as asn1lib;
import 'package:pointycastle/pointycastle.dart';
import 'package:pointycastle/signers/ecdsa_signer.dart';

class SendTxRequest {
  SendTxRequest({
    this.id,
    this.tx,
    this.buffer,
    this.signature,
    this.publicKey,
    this.websocketCommand,
  });

  factory SendTxRequest.fromJson(Map<String, dynamic> json) => SendTxRequest(
        id: json['id'],
        tx: Tx.fromJson(json['tx']),
        buffer: json['buffer'],
        signature: json['signature'],
        publicKey: json['public_key'],
        websocketCommand: json['websocket_command'],
      );

  int id;
  Tx tx;
  String buffer;
  String signature;
  String publicKey;
  String websocketCommand;

  Uint8List getSecureRandom(int length) {
    final Random random = Random.secure();
    final List<int> seeds = [];
    for (int i = 0; i < length; i++) {
      seeds.add(random.nextInt(255));
    }

    return Uint8List.fromList(seeds);
  }

  String signString(String privateKey, String msgToSign) {
    final ECDSASigner signer = Signer('SHA-256/ECDSA');

    final ECPrivateKey _privateKey = ECPrivateKey(
      BigInt.parse(privateKey, radix: 16),
      ECDomainParameters('secp256k1'),
    );
    final PrivateKeyParameter<PrivateKey> privParams =
        PrivateKeyParameter<PrivateKey>(_privateKey);

    final SecureRandom rnd = SecureRandom('AES/CTR/PRNG');
    final Uint8List key = getSecureRandom(16);
    final Uint8List iv = getSecureRandom(16);
    final KeyParameter keyParam = KeyParameter(Uint8List.fromList(key));

    final ParametersWithIV<KeyParameter> params =
        ParametersWithIV<KeyParameter>(keyParam, Uint8List.fromList(iv));
    rnd.seed(params);

    signer.reset();
    signer.init(true,
        ParametersWithRandom<PrivateKeyParameter<PrivateKey>>(privParams, rnd));
    ECSignature sig = signer.generateSignature(utf8.encode(msgToSign));
    sig = sig.normalize(ECDomainParameters('secp256k1'));

    final asn1lib.ASN1Sequence topLevel = asn1lib.ASN1Sequence();
    topLevel.add(asn1lib.ASN1Integer(sig.r));
    topLevel.add(asn1lib.ASN1Integer(sig.s));

    final String sig64 = base64.encode(topLevel.encodedBytes);

    //print("return sig64 : " + sig64);
    return sig64;
  }

  void buildSignature(String privateKey) {
    signature = signString(privateKey, buffer);
    //print("signature: " + signature);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'tx': tx.toJson(),
        'buffer': buffer,
        'signature': signature,
        'public_key': publicKey,
        'websocket_command': websocketCommand,
      };

  String buildCommand() {
    String command = '["' + tx.timestamp + '",';
    command += '"' + tx.address + '", ';
    command += '"' + tx.recipient + '", ';
    command += '"' + tx.amount + '", ';
    command += '"' + signature + '", ';
    command += '"' + publicKey + '", ';
    command += '"' + tx.operation + '", ';
    command += '"' + tx.openfield.replaceAll('"', '\\"') + '"]';
    //print("command : " + command);
    return command;
  }
}

class Tx {
  Tx({
    this.timestamp,
    this.address,
    this.recipient,
    this.amount,
    this.operation,
    this.openfield,
  });

  factory Tx.fromJson(Map<String, dynamic> json) => Tx(
        timestamp: json['timestamp'],
        address: json['address'],
        recipient: json['recipient'],
        amount: json['amount'],
        operation: json['operation'],
        openfield: json['openfield'],
      );

  String timestamp;
  String address;
  String recipient;
  String amount;
  String operation;
  String openfield;

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp,
        'address': address,
        'recipient': recipient,
        'amount': amount,
        'operation': operation,
        'openfield': openfield,
      };

  String buildBufferValue() {
    String _buffer = "('" +
        timestamp +
        "', '" +
        address +
        "', '" +
        recipient +
        "', '" +
        amount +
        "', '" +
        operation +
        "', '" +
        openfield +
        "')";
    //print("_buffer : " + _buffer);
    return _buffer;
  }
}
