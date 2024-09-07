part of '../presentation_imports.dart';

class BrandCubit extends Cubit<BrandState> {
  BrandCubit({
    required this.getBrandsUsecase,
  }) : super(const BrandState());

  final GetBrandsUsecase getBrandsUsecase;

  Future<void> getBrands() async {
    emit(state.copyWith(brandsStatus: UsecaseStatus.running));
    final result = await getBrandsUsecase();
    if (isClosed) return;
    result.fold(
      (failure) {
        emit(state.copyWith(brandsStatus: UsecaseStatus.error, brandsFailure: failure));
      },
      (brands) {
        emit(state.copyWith(brandsStatus: UsecaseStatus.completed, brands: brands.data));
      },
    );
  }
}
