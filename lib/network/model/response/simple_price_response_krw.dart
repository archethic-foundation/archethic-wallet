// To parse this JSON data, do
//
//     final simplePriceKrwResponse = simplePriceKrwResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePriceKrwResponse simplePriceKrwResponseFromJson(String str) => SimplePriceKrwResponse.fromJson(json.decode(str));

String simplePriceKrwResponseToJson(SimplePriceKrwResponse data) => json.encode(data.toJson());

class SimplePriceKrwResponse {
    SimplePriceKrwResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePriceKrwResponse.fromJson(Map<String, dynamic> json) => SimplePriceKrwResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.krw,
    });

    double krw;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        krw: json["krw"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "krw": krw,
    };
}
