// To parse this JSON data, do
//
//     final simplePriceThbResponse = simplePriceThbResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePriceThbResponse simplePriceThbResponseFromJson(String str) => SimplePriceThbResponse.fromJson(json.decode(str));

String simplePriceThbResponseToJson(SimplePriceThbResponse data) => json.encode(data.toJson());

class SimplePriceThbResponse {
    SimplePriceThbResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePriceThbResponse.fromJson(Map<String, dynamic> json) => SimplePriceThbResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.thb,
    });

    double thb;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        thb: json["thb"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "thb": thb,
    };
}
