import 'package:equatable/equatable.dart';

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

class CrawlerNotFound extends Failure {
  const CrawlerNotFound(super.message);
}
