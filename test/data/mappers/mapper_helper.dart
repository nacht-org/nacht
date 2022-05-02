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
  String? suffix,
  required I from,
  required O to,
  required Mapper<I, O> mapper,
  Function()? stub,
}) {
  final _suffix = suffix == null ? '' : ' $suffix';
  test('should map from $fromName to $toName$_suffix', () async {
    if (stub != null) stub();
    expect(mapper.from(from), to);
  });
}
