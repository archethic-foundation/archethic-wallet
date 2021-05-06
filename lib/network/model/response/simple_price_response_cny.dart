// To parse this JSON data, do
//
//     final simplePriceCnyResponse = simplePriceCnyResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePriceCnyResponse simplePriceCnyResponseFromJson(String str) => SimplePriceCnyResponse.fromJson(json.decode(str));

String simplePriceCnyResponseToJson(SimplePriceCnyResponse data) => json.encode(data.toJson());

class SimplePriceCnyResponse {
    SimplePriceCnyResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePriceCnyResponse.fromJson(Map<String, dynamic> json) => SimplePriceCnyResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.cny,
    });

    double cny;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        cny: json["cny"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "cny": cny,
    };
}
