// To parse this JSON data, do
//
//     final simplePriceJpyResponse = simplePriceJpyResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePriceJpyResponse simplePriceJpyResponseFromJson(String str) => SimplePriceJpyResponse.fromJson(json.decode(str));

String simplePriceJpyResponseToJson(SimplePriceJpyResponse data) => json.encode(data.toJson());

class SimplePriceJpyResponse {
    SimplePriceJpyResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePriceJpyResponse.fromJson(Map<String, dynamic> json) => SimplePriceJpyResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.jpy,
    });

    double jpy;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        jpy: json["jpy"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "jpy": jpy,
    };
}
