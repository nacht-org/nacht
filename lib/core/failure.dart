import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

typedef FailureOr<T> = Either<Failure, T>;

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];

  @override
  String toString() {
    return "$runtimeType(message='$message')";
  }
}

class ExceptionFailure extends Failure {
  ExceptionFailure(this.error) : super(error.toString());

  final Object error;

  @override
  List<Object?> get props => [...super.props, error];
}

class CrawlerNotFound extends Failure {
  const CrawlerNotFound(super.message);
}
