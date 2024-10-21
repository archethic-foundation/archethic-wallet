import 'package:aewallet/application/api_service.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_service.g.dart';

@riverpod
AppService appService(AppServiceRef ref) {
  final apiService = ref.watch(apiServiceProvider);
  return AppService(apiService: apiService);
}
