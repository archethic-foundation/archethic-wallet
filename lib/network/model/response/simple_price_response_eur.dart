// To parse this JSON data, do
//
//     final simplePriceEurResponse = simplePriceEurResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePriceEurResponse simplePriceEurResponseFromJson(String str) => SimplePriceEurResponse.fromJson(json.decode(str));

String simplePriceEurResponseToJson(SimplePriceEurResponse data) => json.encode(data.toJson());

class SimplePriceEurResponse {
    SimplePriceEurResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePriceEurResponse.fromJson(Map<String, dynamic> json) => SimplePriceEurResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.eur,
    });

    double eur;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        eur: json["eur"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "eur": eur,
    };
}
