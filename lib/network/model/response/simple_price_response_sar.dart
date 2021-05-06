// To parse this JSON data, do
//
//     final simplePriceSarResponse = simplePriceSarResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePriceSarResponse simplePriceSarResponseFromJson(String str) => SimplePriceSarResponse.fromJson(json.decode(str));

String simplePriceSarResponseToJson(SimplePriceSarResponse data) => json.encode(data.toJson());

class SimplePriceSarResponse {
    SimplePriceSarResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePriceSarResponse.fromJson(Map<String, dynamic> json) => SimplePriceSarResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.sar,
    });

    double sar;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        sar: json["sar"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "sar": sar,
    };
}
