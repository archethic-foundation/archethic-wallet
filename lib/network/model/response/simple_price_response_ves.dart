// To parse this JSON data, do
//
//     final simplePriceVesResponse = simplePriceVesResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePriceVesResponse simplePriceVesResponseFromJson(String str) => SimplePriceVesResponse.fromJson(json.decode(str));

String simplePriceVesResponseToJson(SimplePriceVesResponse data) => json.encode(data.toJson());

class SimplePriceVesResponse {
    SimplePriceVesResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePriceVesResponse.fromJson(Map<String, dynamic> json) => SimplePriceVesResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.ves,
    });

    double ves;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        ves: json["ves"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "ves": ves,
    };
}
