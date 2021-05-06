// To parse this JSON data, do
//
//     final simplePricePlnResponse = simplePricePlnResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePricePlnResponse simplePricePlnResponseFromJson(String str) => SimplePricePlnResponse.fromJson(json.decode(str));

String simplePricePlnResponseToJson(SimplePricePlnResponse data) => json.encode(data.toJson());

class SimplePricePlnResponse {
    SimplePricePlnResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePricePlnResponse.fromJson(Map<String, dynamic> json) => SimplePricePlnResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.pln,
    });

    double pln;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        pln: json["pln"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "pln": pln,
    };
}
