
part of '../presentation_imports.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({
    required this.getProductsUsecase,
    required this.addProductUsecase,
  }) : super(const ProductState());

  final GetProductsUsecase getProductsUsecase;
  final AddProductUsecase addProductUsecase;

  Future<void> getProducts() async {
    emit(state.copyWith(productsStatus: UsecaseStatus.running));
    final result = await getProductsUsecase();
    result.fold(
      (failure) {
        emit(state.copyWith(productsStatus: UsecaseStatus.error, productsFailure: failure));
      },
      (products) {
        emit(state.copyWith(productsStatus: UsecaseStatus.completed, products: products));
      },
    );
  }

  Future<void> addProduct(AddProductParams params) async {
    emit(state.copyWith(addProductStatus: UsecaseStatus.running));
    final result = await addProductUsecase(params);
    result.fold(
      (failure) {
        emit(state.copyWith(addProductStatus: UsecaseStatus.error, addProductFailure: failure));
      },
      (product) {
        final oldProducts = List<Product>.from(state.products);
        emit(state.copyWith(addProductStatus: UsecaseStatus.completed, products: oldProducts..insert(0, product)));
      },
    );
  }
}
