// To parse this JSON data, do
//
//     final simplePriceHufResponse = simplePriceHufResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePriceHufResponse simplePriceHufResponseFromJson(String str) => SimplePriceHufResponse.fromJson(json.decode(str));

String simplePriceHufResponseToJson(SimplePriceHufResponse data) => json.encode(data.toJson());

class SimplePriceHufResponse {
    SimplePriceHufResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePriceHufResponse.fromJson(Map<String, dynamic> json) => SimplePriceHufResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.huf,
    });

    double huf;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        huf: json["huf"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "huf": huf,
    };
}
