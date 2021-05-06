// To parse this JSON data, do
//
//     final simplePriceChfResponse = simplePriceChfResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePriceChfResponse simplePriceChfResponseFromJson(String str) => SimplePriceChfResponse.fromJson(json.decode(str));

String simplePriceChfResponseToJson(SimplePriceChfResponse data) => json.encode(data.toJson());

class SimplePriceChfResponse {
    SimplePriceChfResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePriceChfResponse.fromJson(Map<String, dynamic> json) => SimplePriceChfResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.chf,
    });

    double chf;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        chf: json["chf"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "chf": chf,
    };
}
