// To parse this JSON data, do
//
//     final simplePriceMxnResponse = simplePriceMxnResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

SimplePriceMxnResponse simplePriceMxnResponseFromJson(String str) => SimplePriceMxnResponse.fromJson(json.decode(str));

String simplePriceMxnResponseToJson(SimplePriceMxnResponse data) => json.encode(data.toJson());

class SimplePriceMxnResponse {
    SimplePriceMxnResponse({
        this.uniris,
    });

    Uniris uniris;

    factory SimplePriceMxnResponse.fromJson(Map<String, dynamic> json) => SimplePriceMxnResponse(
        uniris: Uniris.fromJson(json['uniris']),
    );

    Map<String, dynamic> toJson() => {
        'uniris': uniris.toJson(),
    };
}

class Uniris {
    Uniris({
        this.mxn,
    });

    double mxn;

    factory Uniris.fromJson(Map<String, dynamic> json) => Uniris(
        mxn: json["mxn"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "mxn": mxn,
    };
}
