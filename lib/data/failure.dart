import 'package:chapturn/core/failure.dart';

class NovelNotFound extends Failure {
  const NovelNotFound();
  @override
  List<Object?> get props => [];
}

class CoverNotAvailable extends Failure {
  const CoverNotAvailable();
  @override
  List<Object?> get props => [];
}

class NetworkNotAvailable extends Failure {
  const NetworkNotAvailable();
  @override
  List<Object?> get props => [];
}
