// To parse this JSON data, do
//
//     final simplePriceAudResponse = simplePriceAudResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePriceAudResponse simplePriceAudResponseFromJson(String str) => SimplePriceAudResponse.fromJson(json.decode(str));

String simplePriceaudResponseToJson(SimplePriceAudResponse data) => json.encode(data.toJson());

class SimplePriceAudResponse {
    SimplePriceAudResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePriceAudResponse.fromJson(Map<String, dynamic> json) => SimplePriceAudResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.aud,
    });

    double aud;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        aud: json["aud"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "aud": aud,
    };
}
