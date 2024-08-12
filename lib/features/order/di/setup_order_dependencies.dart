import '../../../core/helpers/dependency_helper.dart';
import '../data/data_imports.dart';
import '../domain/domain_imports.dart';
import '../presentation/presentation_imports.dart';

void setUpOrderDependencies() async {
  // CUBIT
  DependencyHelper.instance.serviceLocator.registerFactory(
    () => OrderCubit(
      getOrdersUsecase: DependencyHelper.instance.serviceLocator(),
      addOrderUsecase: DependencyHelper.instance.serviceLocator(),
    ),
  );

  // USECASES
  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => GetOrdersUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );

  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => AddOrderUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );

  // REPOSITORIES
  DependencyHelper.instance.serviceLocator.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(remoteDataSource: DependencyHelper.instance.serviceLocator()),
  );

  // DATASOURCES
  DependencyHelper.instance.serviceLocator.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(),
  );
}