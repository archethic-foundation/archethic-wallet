// To parse this JSON data, do
//
//     final simplePriceIlsResponse = simplePriceIlsResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePriceIlsResponse simplePriceIlsResponseFromJson(String str) => SimplePriceIlsResponse.fromJson(json.decode(str));

String simplePriceIlsResponseToJson(SimplePriceIlsResponse data) => json.encode(data.toJson());

class SimplePriceIlsResponse {
    SimplePriceIlsResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePriceIlsResponse.fromJson(Map<String, dynamic> json) => SimplePriceIlsResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.ils,
    });

    double ils;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        ils: json["ils"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "ils": ils,
    };
}
