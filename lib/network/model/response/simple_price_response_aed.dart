// To parse this JSON data, do
//
//     final simplePriceAedResponse = simplePriceAedResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePriceAedResponse simplePriceAedResponseFromJson(String str) => SimplePriceAedResponse.fromJson(json.decode(str));

String simplePriceAedResponseToJson(SimplePriceAedResponse data) => json.encode(data.toJson());

class SimplePriceAedResponse {
    SimplePriceAedResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePriceAedResponse.fromJson(Map<String, dynamic> json) => SimplePriceAedResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.aed,
    });

    double aed;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        aed: json["aed"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "aed": aed,
    };
}
