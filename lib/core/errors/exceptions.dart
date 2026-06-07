class ApiException implements Exception {
  final String message;
  final int statusCode;

  const ApiException({required this.message, required this.statusCode});

  @override
  String toString() {
    return 'ApiException: $message (statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApiException &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          statusCode == other.statusCode;

  @override
  int get hashCode => Object.hash(message, statusCode);
}

class CacheException implements Exception {
  final String message;

  const CacheException({required this.message});

  @override
  String toString() {
    return 'CacheException: $message';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CacheException &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}

class StorageException implements Exception {
  final String message;

  const StorageException({required this.message});

  @override
  String toString() {
    return 'StorageException: $message';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StorageException &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}

class NetworkException implements Exception {
  final String message;

  const NetworkException({required this.message});

  @override
  String toString() {
    return 'NetworkException: $message';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NetworkException &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}
