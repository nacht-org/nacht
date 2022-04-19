import 'package:chapturn/data/mappers/mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void mapperGroup<Entity, Model>({
  required String name,
  required Mapper<Entity, Model> mapper,
  required void Function(Mapper<Entity, Model> mapper) test,
}) {
  group(name, () => test(mapper));
}

void mapperTest<Entity, Model>({
  required String name,
  required Entity entity,
  required Model model,
  required Mapper<Entity, Model> mapper,
}) {
  group(name, () {
    test('should map from entity to model', () async {
      expect(mapper.mapTo(entity), model);
    });

    mapFromTest(entity: entity, model: model, mapper: mapper);
  });
}

void mapFromTest<Entity, Model>({
  required Entity entity,
  required Model model,
  required MapFrom<Entity, Model> mapper,
}) {
  test('should map to entity from model', () async {
    expect(mapper.mapFrom(model), entity);
  });
}
