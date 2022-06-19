mixin BinaryFilter {
  /// The control bit for this filter option
  int get bit;

  /// Whether the filter is active in the provided [value]
  ///
  /// Filter is determined active if the bit is 1.
  bool isHidden(int value) => value & bit == bit;

  /// Whether the filter is inactive and the items are shown
  bool isShown(int value) => !isHidden(value);

  /// Toggle the filter bit of the provided [value]
  int toggle(int value) => value ^ bit;
}
