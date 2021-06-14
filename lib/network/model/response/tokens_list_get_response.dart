// To parse this JSON data, do
//
//     final tokensListGetResponse = tokensListGetResponseFromJson(jsonString);

// @dart=2.9

// Dart imports:
import 'dart:convert';

Map<String, List<dynamic>> tokensListGetResponseFromJson(String str) =>
    Map.from(json.decode(str)).map((k, v) => MapEntry<String, List<dynamic>>(
        k, List<dynamic>.from(v.map((x) => x))));

String tokensListGetResponseToJson(Map<String, List<dynamic>> data) =>
    json.encode(Map.from(data).map((k, v) =>
        MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))));
