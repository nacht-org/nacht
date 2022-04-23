import 'package:chapturn/data/datasources/local/database.dart';
import 'package:chapturn/domain/mapper.dart';
import 'package:chapturn_sources/chapturn_sources.dart' as sources;
import 'package:drift/drift.dart';

class SourceToVolumeCompanionMapper
    implements Mapper<sources.Volume, VolumesCompanion> {
  @override
  VolumesCompanion map(sources.Volume input) {
    return VolumesCompanion(
      index: Value(input.index),
      name: Value(input.name),
    );
  }
}
