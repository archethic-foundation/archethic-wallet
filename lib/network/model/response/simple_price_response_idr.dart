// To parse this JSON data, do
//
//     final simplePriceIdrResponse = simplePriceIdrResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePriceIdrResponse simplePriceIdrResponseFromJson(String str) => SimplePriceIdrResponse.fromJson(json.decode(str));

String simplePriceIdrResponseToJson(SimplePriceIdrResponse data) => json.encode(data.toJson());

class SimplePriceIdrResponse {
    SimplePriceIdrResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePriceIdrResponse.fromJson(Map<String, dynamic> json) => SimplePriceIdrResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.idr,
    });

    double idr;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        idr: json["idr"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "idr": idr,
    };
}
