abstract class UseCase<Command, Result> {
  const UseCase();
  Future<Result> run(Command command);
}
