// To parse this JSON data, do
//
//     final simplePriceZarResponse = simplePriceZarResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePriceZarResponse simplePriceZarResponseFromJson(String str) => SimplePriceZarResponse.fromJson(json.decode(str));

String simplePriceZarResponseToJson(SimplePriceZarResponse data) => json.encode(data.toJson());

class SimplePriceZarResponse {
    SimplePriceZarResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePriceZarResponse.fromJson(Map<String, dynamic> json) => SimplePriceZarResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.zar,
    });

    double zar;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        zar: json["zar"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "zar": zar,
    };
}
