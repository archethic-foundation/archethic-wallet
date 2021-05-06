// To parse this JSON data, do
//
//     final simplePriceClpResponse = simplePriceClpResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePriceClpResponse simplePriceClpResponseFromJson(String str) => SimplePriceClpResponse.fromJson(json.decode(str));

String simplePriceClpResponseToJson(SimplePriceClpResponse data) => json.encode(data.toJson());

class SimplePriceClpResponse {
    SimplePriceClpResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePriceClpResponse.fromJson(Map<String, dynamic> json) => SimplePriceClpResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.clp,
    });

    double clp;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        clp: json["clp"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "clp": clp,
    };
}
