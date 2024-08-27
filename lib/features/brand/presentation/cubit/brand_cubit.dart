part of '../presentation_imports.dart';

class BrandCubit extends Cubit<BrandState> {
  BrandCubit({
    required this.getBrandsUsecase,
    required this.addBrandUsecase,
  }) : super(const BrandState());

  final GetBrandsUsecase getBrandsUsecase;
  final AddBrandUsecase addBrandUsecase;

  Future<void> getBrands() async {
    emit(state.copyWith(brandsStatus: UsecaseStatus.running));
    final result = await getBrandsUsecase();
    result.fold(
      (failure) {
        emit(state.copyWith(brandsStatus: UsecaseStatus.error, brandsFailure: failure));
      },
      (brands) {
        emit(state.copyWith(brandsStatus: UsecaseStatus.completed, brands: brands.data));
      },
    );
  }

  Future<void> addBrand(AddBrandParams params) async {
    emit(state.copyWith(addBrandStatus: UsecaseStatus.running));
    final result = await addBrandUsecase(params);
    result.fold(
      (failure) {
        emit(state.copyWith(addBrandStatus: UsecaseStatus.error, addBrandFailure: failure));
      },
      (response) {
        final oldBrands = List<Brand>.from(state.brands);
        emit(state.copyWith(addBrandStatus: UsecaseStatus.completed, brands: oldBrands..insert(0, response.data!)));
      },
    );
  }
}
