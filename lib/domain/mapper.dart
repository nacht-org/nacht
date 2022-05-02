/// Interface definiing object mapping logic
abstract class Mapper<I, O> {
  O from(I input);
}
