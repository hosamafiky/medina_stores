part of '../presentation_imports.dart';

class BrandState extends Equatable {
  const BrandState({
    this.brandsStatus = UsecaseStatus.idle,
    this.brandsFailure,
    this.brands = const [],
    this.addBrandStatus = UsecaseStatus.idle,
    this.addBrandFailure,
  });

  final UsecaseStatus brandsStatus;
  final Failure? brandsFailure;
  final List<Brand> brands;

  final UsecaseStatus addBrandStatus;
  final Failure? addBrandFailure;

  BrandState copyWith({
    UsecaseStatus? brandsStatus,
    Failure? brandsFailure,
    List<Brand>? brands,
    UsecaseStatus? addBrandStatus,
    Failure? addBrandFailure,
  }) {
    return BrandState(
      brandsStatus: brandsStatus ?? this.brandsStatus,
      brandsFailure: brandsFailure ?? this.brandsFailure,
      brands: brands ?? this.brands,
      addBrandStatus: addBrandStatus ?? this.addBrandStatus,
      addBrandFailure: addBrandFailure ?? this.addBrandFailure,
    );
  }

  @override
  String toString() {
    return 'BrandState(brandsStatus: $brandsStatus, brandsFailure: $brandsFailure, brands: $brands, addBrandStatus: $addBrandStatus, addBrandFailure: $addBrandFailure)';
  }

  @override
  List<Object?> get props => [
        brandsStatus,
        brandsFailure,
        brands,
        addBrandStatus,
        addBrandFailure,
      ];
}
