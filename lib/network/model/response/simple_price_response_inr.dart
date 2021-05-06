// To parse this JSON data, do
//
//     final simplePriceInrResponse = simplePriceInrResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePriceInrResponse simplePriceInrResponseFromJson(String str) => SimplePriceInrResponse.fromJson(json.decode(str));

String simplePriceInrResponseToJson(SimplePriceInrResponse data) => json.encode(data.toJson());

class SimplePriceInrResponse {
    SimplePriceInrResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePriceInrResponse.fromJson(Map<String, dynamic> json) => SimplePriceInrResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.inr,
    });

    double inr;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        inr: json["inr"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "inr": inr,
    };
}
