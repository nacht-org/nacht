import 'package:nacht/data/data.dart';
import 'package:nacht/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tModel = Volume(
    id: 3,
    volumeIndex: 3,
    name: 'Volume 3',
  );

  final tData = VolumeData(
    id: 3,
    index: 3,
    name: 'Volume 3',
  );

  test('should create VolumeData from Volume', () {
    final result = VolumeData.fromModel(tModel);
    expect(result, tData);
  });
}
