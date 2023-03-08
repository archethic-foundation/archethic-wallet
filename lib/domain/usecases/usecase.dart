import 'package:freezed_annotation/freezed_annotation.dart';

part 'usecase.freezed.dart';

@freezed
class UseCaseProgress with _$UseCaseProgress {
  const factory UseCaseProgress({
    required int progress,
    required int total,
  }) = _UseCaseProgress;
  const UseCaseProgress._();
}

typedef UseCaseProgressListener = void Function(UseCaseProgress progress);

abstract class UseCase<Command, Result> {
  const UseCase();
  Future<Result> run(
    Command command, {
    UseCaseProgressListener? onProgress,
  });
}
