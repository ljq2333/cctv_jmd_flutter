abstract class Failure {
  final String message;

  const Failure({required this.message});

  @override
  String toString() => '$runtimeType: $message';
}

class ApiFailure extends Failure {
  const ApiFailure({required super.message});

  @override
  String toString() => 'ApiFailure: $message';
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});

  @override
  String toString() => 'CacheFailure: $message';
}

class StorageFailure extends Failure {
  const StorageFailure({required super.message});

  @override
  String toString() => 'StorageFailure: $message';
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message});

  @override
  String toString() => 'NetworkFailure: $message';
}
