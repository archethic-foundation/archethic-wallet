import 'package:aewallet/domain/models/core/result.dart';

abstract class UseCase<Command, Value, Failure> {
  const UseCase();
  Future<Result<Value, Failure>> run(Command command);
}
