extension ListExtension<T> on List<T> {
  void updateItem(bool Function(T) test, T newValue) {
    for (int i = 0; i < length; i++) {
      if (test(this[i])) {
        this[i] = newValue;
        return;
      }
    }
  }

  List<Model> updateProductAtIndex<Model extends Object>(int index, Model product, {bool isRemove = false}) {
    final List<Model> products = List<Model>.from(this);
    products.removeAt(index);
    if (!isRemove) products.insert(index, product);
    return List<Model>.from(products);
  }
}
