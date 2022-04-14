import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();
}

class CrawlerFactoryNotFoundFailure extends Failure {
  const CrawlerFactoryNotFoundFailure();

  @override
  List<Object?> get props => [];
}
