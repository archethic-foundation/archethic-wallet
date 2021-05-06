// To parse this JSON data, do
//
//     final simplePriceRubResponse = simplePriceRubResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePriceRubResponse simplePriceRubResponseFromJson(String str) => SimplePriceRubResponse.fromJson(json.decode(str));

String simplePriceRubResponseToJson(SimplePriceRubResponse data) => json.encode(data.toJson());

class SimplePriceRubResponse {
    SimplePriceRubResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePriceRubResponse.fromJson(Map<String, dynamic> json) => SimplePriceRubResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.rub,
    });

    double rub;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        rub: json["rub"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "rub": rub,
    };
}
