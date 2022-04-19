import 'package:chapturn_sources/chapturn_sources.dart';

import 'mapper.dart';
import '../datasources/local/database.dart' as db;

class NovelDatabaseMapper extends Mapper<Novel, db.Novel> {
  @override
  Novel mapFrom(db.Novel model) {
    // TODO: Implement mapFrom
    throw UnimplementedError();
  }

  @override
  db.Novel mapTo(Novel entity) {
    // TODO: Implement mapTo
    throw UnimplementedError();
  }
}
