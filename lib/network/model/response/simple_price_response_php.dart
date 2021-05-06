// To parse this JSON data, do
//
//     final simplePricePhpResponse = simplePricePhpResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePricePhpResponse simplePricePhpResponseFromJson(String str) => SimplePricePhpResponse.fromJson(json.decode(str));

String simplePricePhpResponseToJson(SimplePricePhpResponse data) => json.encode(data.toJson());

class SimplePricePhpResponse {
    SimplePricePhpResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePricePhpResponse.fromJson(Map<String, dynamic> json) => SimplePricePhpResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.php,
    });

    double php;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        php: json["php"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "php": php,
    };
}
