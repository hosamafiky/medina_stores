extension ListExtension<T> on List<T> {
  void updateItem(bool Function(T) test, T newValue) {
    for (int i = 0; i < length; i++) {
      if (test(this[i])) {
        this[i] = newValue;
        return;
      }
    }
  }

  List<Model> updateItemAtIndex<Model extends Object>(int index, Model item, {bool isRemove = false}) {
    final List<Model> items = List<Model>.from(this);
    items.removeAt(index);
    if (!isRemove) items.insert(index, item);
    return List<Model>.from(items);
  }
}
