// To parse this JSON data, do
//
//     final simplePriceNokResponse = simplePriceNokResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePriceNokResponse simplePriceNokResponseFromJson(String str) => SimplePriceNokResponse.fromJson(json.decode(str));

String simplePriceNokResponseToJson(SimplePriceNokResponse data) => json.encode(data.toJson());

class SimplePriceNokResponse {
    SimplePriceNokResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePriceNokResponse.fromJson(Map<String, dynamic> json) => SimplePriceNokResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.nok,
    });

    double nok;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        nok: json["nok"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "nok": nok,
    };
}
