
// To parse this JSON data, do
//
//     final wStatusGetResponse = wStatusGetResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

WStatusGetResponse wStatusGetResponseFromJson(String str) => WStatusGetResponse.fromJson(json.decode(str));

String wStatusGetResponseToJson(WStatusGetResponse data) => json.encode(data.toJson());

class WStatusGetResponse {
    WStatusGetResponse({
        this.version,
        this.clients,
        this.maxClients,
        this.of,
        this.fd,
        this.co,
    });

    String version;
    int clients;
    int maxClients;
    int of;
    int fd;
    int co;

    factory WStatusGetResponse.fromJson(Map<String, dynamic> json) => WStatusGetResponse(
        version: json['version'],
        clients: json['clients'],
        maxClients: json['max_clients'],
        of: json['of'],
        fd: json['fd'],
        co: json['co'],
    );

    Map<String, dynamic> toJson() => {
        'version': version,
        'clients': clients,
        'max_clients': maxClients,
        'of': of,
        'fd': fd,
        'co': co,
    };
}
