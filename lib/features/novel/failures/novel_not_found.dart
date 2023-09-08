import 'package:nacht/core/core.dart';

/// The novel was not found in the database
class NovelNotFound extends Failure {
  const NovelNotFound() : super("Novel not found in database");
}
