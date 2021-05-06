// To parse this JSON data, do
//
//     final simplePriceMyrResponse = simplePriceMyrResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePriceMyrResponse simplePriceMyrResponseFromJson(String str) => SimplePriceMyrResponse.fromJson(json.decode(str));

String simplePriceMyrResponseToJson(SimplePriceMyrResponse data) => json.encode(data.toJson());

class SimplePriceMyrResponse {
    SimplePriceMyrResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePriceMyrResponse.fromJson(Map<String, dynamic> json) => SimplePriceMyrResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.myr,
    });

    double myr;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        myr: json["myr"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "myr": myr,
    };
}
