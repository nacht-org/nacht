import 'package:nacht/shared/shared.dart';
import 'package:nacht/database/database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tModel = Volume(
    id: 3,
    volumeIndex: 3,
    name: 'Volume 3',
    novelId: 1,
  );

  final tData = VolumeData(
    id: 3,
    index: 3,
    name: 'Volume 3',
    novelId: 1,
  );

  test('should create VolumeData from Volume', () {
    final result = VolumeData.fromModel(tModel);
    expect(result, tData);
  });
}
