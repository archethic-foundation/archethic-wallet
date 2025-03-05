import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'moonpay.g.dart';

@riverpod
({String apiKey}) moonpaySettings(Ref ref) =>
    (apiKey: const String.fromEnvironment('MOONPAY_API_KEY'));
