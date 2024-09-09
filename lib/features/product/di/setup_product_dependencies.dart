import 'package:medina_stores/features/sub_category/domain/domain_imports.dart';

import '../../../core/helpers/dependency_helper.dart';
import '../../brand/domain/domain_imports.dart';
import '../data/data_imports.dart';
import '../domain/domain_imports.dart';
import '../presentation/presentation_imports.dart';

void setUpProductDependencies() async {
  // CUBIT
  DependencyHelper.instance.serviceLocator.registerFactoryParam<ProductCubit, SubCategory?, Brand?>(
    (subCategory, brand) => ProductCubit(
      getProductsUsecase: DependencyHelper.instance.serviceLocator(),
      getBrandProductsUsecase: DependencyHelper.instance.serviceLocator(),
      getProductDetailsUsecase: DependencyHelper.instance.serviceLocator(),
      getRelatedProductsUsecase: DependencyHelper.instance.serviceLocator(),
      getYouMayLikeProductsUsecase: DependencyHelper.instance.serviceLocator(),
      getFavouriteProductsUsecase: DependencyHelper.instance.serviceLocator(),
      getSuggestedCartProductsUsecase: DependencyHelper.instance.serviceLocator(),
      getLatestProductsUsecase: DependencyHelper.instance.serviceLocator(),
      getProductNameSuggestionsUsecase: DependencyHelper.instance.serviceLocator(),
      getSearchProductsUsecase: DependencyHelper.instance.serviceLocator(),
      toggleFavoriteUsecase: DependencyHelper.instance.serviceLocator(),
      subCategory: subCategory,
      brand: brand,
    ),
  );

  // USECASES
  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => GetCategoryProductsUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );

  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => GetBrandProductsUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );

  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => GetProductDetailsUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );

  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => GetRelatedProductsUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );

  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => GetYouMayLikeProductsUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );

  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => ToggleFavoriteUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );

  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => GetFavouriteProductsUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );

  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => GetSuggestedCartProductsUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );

  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => GetLatestProductsUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );

  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => GetSearchProductsUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );

  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => GetProductNameSuggestionsUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );

  // REPOSITORIES
  DependencyHelper.instance.serviceLocator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: DependencyHelper.instance.serviceLocator()),
  );

  // DATASOURCES
  DependencyHelper.instance.serviceLocator.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(),
  );
}
