// To parse this JSON data, do
//
//     final simplePriceNzdResponse = simplePriceNzdResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePriceNzdResponse simplePriceNzdResponseFromJson(String str) => SimplePriceNzdResponse.fromJson(json.decode(str));

String simplePriceNzdResponseToJson(SimplePriceNzdResponse data) => json.encode(data.toJson());

class SimplePriceNzdResponse {
    SimplePriceNzdResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePriceNzdResponse.fromJson(Map<String, dynamic> json) => SimplePriceNzdResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.nzd,
    });

    double nzd;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        nzd: json["nzd"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "nzd": nzd,
    };
}
