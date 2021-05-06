// To parse this JSON data, do
//
//     final simplePriceKwdResponse = simplePriceKwdResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePriceKwdResponse simplePriceKwdResponseFromJson(String str) => SimplePriceKwdResponse.fromJson(json.decode(str));

String simplePriceKwdResponseToJson(SimplePriceKwdResponse data) => json.encode(data.toJson());

class SimplePriceKwdResponse {
    SimplePriceKwdResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePriceKwdResponse.fromJson(Map<String, dynamic> json) => SimplePriceKwdResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.kwd,
    });

    double kwd;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        kwd: json["kwd"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "kwd": kwd,
    };
}
