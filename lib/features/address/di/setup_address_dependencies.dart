import '../../../core/helpers/dependency_helper.dart';
import '../data/data_imports.dart';
import '../domain/domain_imports.dart';
import '../presentation/presentation_imports.dart';

void setUpAddressDependencies() async {
  // CUBIT
  DependencyHelper.instance.serviceLocator.registerFactoryParam<AddressCubit, Address?, void>(
    (address, _) => AddressCubit(
      cachedAddress: address,
      getAddressesUsecase: DependencyHelper.instance.serviceLocator(),
      addAddressUsecase: DependencyHelper.instance.serviceLocator(),
      updateAddressUsecase: DependencyHelper.instance.serviceLocator(),
      deleteAddressUsecase: DependencyHelper.instance.serviceLocator(),
    ),
  );

  // USECASES
  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => GetAddressesUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );

  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => AddAddressUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );

  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => UpdateAddressUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );

  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => DeleteAddressUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );

  // REPOSITORIES
  DependencyHelper.instance.serviceLocator.registerLazySingleton<AddressRepository>(
    () => AddressRepositoryImpl(
      connectionChecker: DependencyHelper.instance.serviceLocator(),
      remoteDataSource: DependencyHelper.instance.serviceLocator(),
      localDataSource: DependencyHelper.instance.serviceLocator(),
    ),
  );

  // DATASOURCES
  DependencyHelper.instance.serviceLocator.registerLazySingleton<AddressRemoteDataSource>(
    () => AddressRemoteDataSourceImpl(),
  );
  DependencyHelper.instance.serviceLocator.registerLazySingleton<AddressLocalDataSource>(
    () => AddressLocalDataSourceImpl(),
  );
}
