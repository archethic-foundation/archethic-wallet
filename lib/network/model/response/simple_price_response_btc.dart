// To parse this JSON data, do
//
//     final simplePriceBtcResponse = simplePriceBtcResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePriceBtcResponse simplePriceBtcResponseFromJson(String str) => SimplePriceBtcResponse.fromJson(json.decode(str));

String simplePriceBtcResponseToJson(SimplePriceBtcResponse data) => json.encode(data.toJson());

class SimplePriceBtcResponse {
    SimplePriceBtcResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePriceBtcResponse.fromJson(Map<String, dynamic> json) => SimplePriceBtcResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.btc,
    });

    double btc;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        btc: json["btc"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "btc": btc,
    };
}
