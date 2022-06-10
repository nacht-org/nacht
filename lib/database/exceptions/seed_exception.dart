/// This exception is thrown when the database seeding
/// is not as expected.
class SeedException implements Exception {
  final String? reason;
  SeedException([this.reason]);
}
