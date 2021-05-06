// To parse this JSON data, do
//
//     final serverWalletLegacyResponse = serverWalletLegacyResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

List<ServerWalletLegacyResponse> serverWalletLegacyResponseFromJson(String str) => List<ServerWalletLegacyResponse>.from(json.decode(str).map((x) => ServerWalletLegacyResponse.fromJson(x)));

String serverWalletLegacyResponseToJson(List<ServerWalletLegacyResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServerWalletLegacyResponse {
    ServerWalletLegacyResponse({
        this.label,
        this.ip,
        this.port,
        this.country,
        this.height,
        this.version,
        this.active,
        this.clients,
        this.totalSlots,
        this.lastActive,
    });

    String label;
    String ip;
    int port;
    String country;
    int height;
    String version;
    bool active;
    int clients;
    int totalSlots;
    int lastActive;

    factory ServerWalletLegacyResponse.fromJson(Map<String, dynamic> json) => ServerWalletLegacyResponse(
        label: json['label'],
        ip: json['ip'],
        port: json['port'],
        country: json['country'],
        height: json['height'],
        version: json['version'],
        active: json['active'],
        clients: json['clients'],
        totalSlots: json['total_slots'],
        lastActive: json['last_active'],
    );

    Map<String, dynamic> toJson() => {
        'label': label,
        'ip': ip,
        'port': port,
        'country': country,
        'height': height,
        'version': version,
        'active': active,
        'clients': clients,
        'total_slots': totalSlots,
        'last_active': lastActive,
    };
}
