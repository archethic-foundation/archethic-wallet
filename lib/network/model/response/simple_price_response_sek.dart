// To parse this JSON data, do
//
//     final simplePriceSekResponse = simplePriceSekResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePriceSekResponse simplePriceSekResponseFromJson(String str) => SimplePriceSekResponse.fromJson(json.decode(str));

String simplePriceSekResponseToJson(SimplePriceSekResponse data) => json.encode(data.toJson());

class SimplePriceSekResponse {
    SimplePriceSekResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePriceSekResponse.fromJson(Map<String, dynamic> json) => SimplePriceSekResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.sek,
    });

    double sek;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        sek: json["sek"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "sek": sek,
    };
}
