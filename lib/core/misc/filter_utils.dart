mixin BinaryFilter {
  /// The control bit for this filter option
  int get bit;

  /// Whether the filter is active in the provided [value]
  ///
  /// Filter is determined active if the bit is 1.
  bool isActive(int value) => value & bit == bit;

  /// Toggle the filter bit of the provided [value]
  int toggle(int value) {
    return isActive(value) ? value ^ bit : value | bit;
  }
}
