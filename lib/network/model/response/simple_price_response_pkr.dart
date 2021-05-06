// To parse this JSON data, do
//
//     final simplePricePkrResponse = simplePricePkrResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePricePkrResponse simplePricePkrResponseFromJson(String str) => SimplePricePkrResponse.fromJson(json.decode(str));

String simplePricePkrResponseToJson(SimplePricePkrResponse data) => json.encode(data.toJson());

class SimplePricePkrResponse {
    SimplePricePkrResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePricePkrResponse.fromJson(Map<String, dynamic> json) => SimplePricePkrResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.pkr,
    });

    double pkr;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        pkr: json["pkr"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "pkr": pkr,
    };
}
