// To parse this JSON data, do
//
//     final addlistlimResponse = addlistlimResponseFromJson(jsonString);

// @dart=2.9

import 'dart:convert';

List<List<dynamic>> addlistlimResponseFromJson(String str) => List<List<dynamic>>.from(json.decode(str).map((x) => List<dynamic>.from(x.map((x) => x))));

String addlistlimResponseToJson(List<List<dynamic>> data) => json.encode(List<dynamic>.from(data.map((x) => List<dynamic>.from(x.map((x) => x)))));
