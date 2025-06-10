abstract class Failure {
  final String message;
  Failure(this.message);

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  ServerFailure([super.message = 'Server failure']);
}

class CacheFailure extends Failure {
  CacheFailure([super.message = 'Cache failure']);
}
