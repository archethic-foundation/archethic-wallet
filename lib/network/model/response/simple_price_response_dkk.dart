// To parse this JSON data, do
//
//     final simplePriceDkkResponse = simplePriceDkkResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePriceDkkResponse simplePriceDkkResponseFromJson(String str) => SimplePriceDkkResponse.fromJson(json.decode(str));

String simplePriceDkkResponseToJson(SimplePriceDkkResponse data) => json.encode(data.toJson());

class SimplePriceDkkResponse {
    SimplePriceDkkResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePriceDkkResponse.fromJson(Map<String, dynamic> json) => SimplePriceDkkResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.dkk,
    });

    double dkk;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        dkk: json["dkk"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "dkk": dkk,
    };
}
