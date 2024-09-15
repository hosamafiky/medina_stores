import '../../../core/helpers/dependency_helper.dart';
import '../data/data_imports.dart';
import '../domain/domain_imports.dart';
import '../presentation/presentation_imports.dart';

void setUpCheckoutDependencies() async {
  // CUBIT
  DependencyHelper.instance.serviceLocator.registerFactory(
    () => CheckoutCubit(
      getCheckoutDataUsecase: DependencyHelper.instance.serviceLocator(),
      getPaymentGatesUsecase: DependencyHelper.instance.serviceLocator(),
    ),
  );

  // USECASES
  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => GetCheckoutDataUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );

  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => GetPaymentGatesUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );

  // REPOSITORIES
  DependencyHelper.instance.serviceLocator.registerLazySingleton<CheckoutRepository>(
    () => CheckoutRepositoryImpl(
      remoteDataSource: DependencyHelper.instance.serviceLocator(),
      connectionChecker: DependencyHelper.instance.serviceLocator(),
    ),
  );

  // DATASOURCES
  DependencyHelper.instance.serviceLocator.registerLazySingleton<CheckoutRemoteDataSource>(
    () => CheckoutRemoteDataSourceImpl(),
  );
}
