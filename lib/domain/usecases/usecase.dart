import 'package:aewallet/domain/models/core/result.dart';

abstract class UseCase<Command, Value, Failure> {
  Future<Result<Value, Failure>> run(Command command);
}
