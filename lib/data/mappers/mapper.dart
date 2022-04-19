/// Interface definiing object mapping logic
abstract class Mapper<E, M> implements MapFrom<E, M>, MapTo<E, M> {}

/// Map [Model] into [Entity]
abstract class MapFrom<Entity, Model> {
  Entity mapFrom(Model model);
}

/// Map [Entity] into [Model]
abstract class MapTo<Entity, Model> {
  Model mapTo(Entity entity);
}
