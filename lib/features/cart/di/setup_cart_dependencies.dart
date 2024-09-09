import '../../../core/helpers/dependency_helper.dart';
import '../data/data_imports.dart';
import '../domain/domain_imports.dart';
import '../presentation/presentation_imports.dart';

void setUpCartDependencies() async {
  // CUBIT
  DependencyHelper.instance.serviceLocator.registerFactory(
    () => CartCubit(
      getCartItemsUsecase: DependencyHelper.instance.serviceLocator(),
      addToCartUsecase: DependencyHelper.instance.serviceLocator(),
      removeFromCartUsecase: DependencyHelper.instance.serviceLocator(),
      updateCartQuantityUsecase: DependencyHelper.instance.serviceLocator(),
    ),
  );

  // USECASES
  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => GetCartItemsUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );

  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => AddToCartUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );

  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => RemoveFromCartUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );

  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => UpdateCartQuantityUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );

  // REPOSITORIES
  DependencyHelper.instance.serviceLocator.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(
      remoteDataSource: DependencyHelper.instance.serviceLocator(),
      connectionChecker: DependencyHelper.instance.serviceLocator(),
    ),
  );

  // DATASOURCES
  DependencyHelper.instance.serviceLocator.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceImpl(),
  );
}
