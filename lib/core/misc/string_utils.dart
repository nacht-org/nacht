extension TextTransform on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    }

    return substring(0, 1).toUpperCase() + substring(1);
  }
}

extension Plural on String {
  String pluralize({
    String suffix = 's',
    bool Function(String string)? test,
  }) {
    test = test ?? (_) => true;
    if (test(this)) {
      return this + suffix;
    }

    return this;
  }
}
