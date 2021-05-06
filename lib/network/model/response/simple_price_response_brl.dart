// To parse this JSON data, do
//
//     final simplePriceBrlResponse = simplePriceBrlResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePriceBrlResponse simplePriceBrlResponseFromJson(String str) => SimplePriceBrlResponse.fromJson(json.decode(str));

String simplePriceBrlResponseToJson(SimplePriceBrlResponse data) => json.encode(data.toJson());

class SimplePriceBrlResponse {
    SimplePriceBrlResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePriceBrlResponse.fromJson(Map<String, dynamic> json) => SimplePriceBrlResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.brl,
    });

    double brl;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        brl: json["brl"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "brl": brl,
    };
}
