import 'package:drift/drift.dart';
import 'package:nacht/database/database.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;

VolumesCompanion sourceVolumeIntoCompanion(sources.Volume volume) {
  return VolumesCompanion(
    volumeIndex: Value(volume.index),
    name: Value(volume.name),
  );
}
