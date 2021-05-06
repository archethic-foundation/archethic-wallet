// To parse this JSON data, do
//
//     final simplePriceTryResponse = simplePriceTryResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePriceTryResponse simplePriceTryResponseFromJson(String str) => SimplePriceTryResponse.fromJson(json.decode(str));

String simplePriceTryResponseToJson(SimplePriceTryResponse data) => json.encode(data.toJson());

class SimplePriceTryResponse {
    SimplePriceTryResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePriceTryResponse.fromJson(Map<String, dynamic> json) => SimplePriceTryResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.tryl,
    });

    double tryl;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        tryl: json["try"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "try": tryl,
    };
}
