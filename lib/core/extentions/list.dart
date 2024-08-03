extension ListExtension<T> on List<T> {
  void updateItem(bool Function(T) test, T newValue) {
    for (int i = 0; i < length; i++) {
      if (test(this[i])) {
        this[i] = newValue;
        return;
      }
    }
  }
}
