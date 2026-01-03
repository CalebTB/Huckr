import 'package:equatable/equatable.dart';

/// Base class for all failures in the application
/// Used with Either<Failure, T> pattern from dartz package
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Failure from remote server (Supabase)
class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error occurred']);
}

/// Failure from local cache (Hive)
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Local storage error occurred']);
}

/// Failure due to no internet connection
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection']);
}

/// Failure due to validation errors
class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Validation error']);
}

/// Failure when resource is not found
class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Resource not found']);
}

/// Failure due to unauthorized access
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([super.message = 'Unauthorized']);
}

/// Failure during sync operations
class SyncFailure extends Failure {
  const SyncFailure([super.message = 'Sync failed']);
}
