// To parse this JSON data, do
//
//     final simplePriceGbpResponse = simplePriceGbpResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePriceGbpResponse simplePriceGbpResponseFromJson(String str) => SimplePriceGbpResponse.fromJson(json.decode(str));

String simplePriceGbpResponseToJson(SimplePriceGbpResponse data) => json.encode(data.toJson());

class SimplePriceGbpResponse {
    SimplePriceGbpResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePriceGbpResponse.fromJson(Map<String, dynamic> json) => SimplePriceGbpResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.gbp,
    });

    double gbp;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        gbp: json["gbp"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "gbp": gbp,
    };
}
