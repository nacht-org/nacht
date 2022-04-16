import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();
}

class CrawlerNotFound extends Failure {
  const CrawlerNotFound();

  @override
  List<Object?> get props => [];
}
