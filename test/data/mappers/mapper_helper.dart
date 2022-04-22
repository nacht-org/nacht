import 'package:chapturn/domain/mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void mapperGroup<I, O>({
  required String name,
  required Mapper<I, O> mapper,
  required void Function(Mapper<I, O> mapper) test,
}) {
  group(name, () => test(mapper));
}

void mapperTest<I, O>(
  String fromName,
  String toName, {
  required I from,
  required O to,
  required Mapper<I, O> mapper,
}) {
  test('should map from $fromName to $toName', () async {
    expect(mapper.map(from), to);
  });
}
