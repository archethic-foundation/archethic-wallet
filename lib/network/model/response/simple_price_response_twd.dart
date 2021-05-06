// To parse this JSON data, do
//
//     final simplePriceTwdResponse = simplePriceTwdResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePriceTwdResponse simplePriceTwdResponseFromJson(String str) => SimplePriceTwdResponse.fromJson(json.decode(str));

String simplePriceTwdResponseToJson(SimplePriceTwdResponse data) => json.encode(data.toJson());

class SimplePriceTwdResponse {
    SimplePriceTwdResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePriceTwdResponse.fromJson(Map<String, dynamic> json) => SimplePriceTwdResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.twd,
    });

    double twd;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        twd: json["twd"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "twd": twd,
    };
}
