// To parse this JSON data, do
//
//     final simplePriceSgdResponse = simplePriceSgdResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePriceSgdResponse simplePriceSgdResponseFromJson(String str) => SimplePriceSgdResponse.fromJson(json.decode(str));

String simplePriceSgdResponseToJson(SimplePriceSgdResponse data) => json.encode(data.toJson());

class SimplePriceSgdResponse {
    SimplePriceSgdResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePriceSgdResponse.fromJson(Map<String, dynamic> json) => SimplePriceSgdResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.sgd,
    });

    double sgd;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        sgd: json["sgd"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "sgd": sgd,
    };
}
