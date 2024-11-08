import '../../../core/helpers/dependency_helper.dart';
import '../data/data_imports.dart';
import '../domain/domain_imports.dart';
import '../presentation/presentation_imports.dart';

void setUpUserDependencies() async {
  // CUBIT
  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => UserCubit(
      loginUsecase: DependencyHelper.instance.serviceLocator(),
      logoutUsecase: DependencyHelper.instance.serviceLocator(),
      registerUsecase: DependencyHelper.instance.serviceLocator(),
      sendOTPUsecase: DependencyHelper.instance.serviceLocator(),
      verifyOTPUsecase: DependencyHelper.instance.serviceLocator(),
      verifyPassOTPUsecase: DependencyHelper.instance.serviceLocator(),
      resetPasswordUsecase: DependencyHelper.instance.serviceLocator(),
      getUserDataUsecase: DependencyHelper.instance.serviceLocator(),
      updateProfileUsecase: DependencyHelper.instance.serviceLocator(),
      updatePasswordUsecase: DependencyHelper.instance.serviceLocator(),
      deleteAccountUsecase: DependencyHelper.instance.serviceLocator(),
    ),
  );

  // USECASES
  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => LoginUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );
  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => LogoutUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );
  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => RegisterUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );
  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => SendOTPUseCase(repository: DependencyHelper.instance.serviceLocator()),
  );
  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => VerifyOTPUseCase(repository: DependencyHelper.instance.serviceLocator()),
  );
  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => VerifyPassOTPUseCase(repository: DependencyHelper.instance.serviceLocator()),
  );
  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => ResetPasswordUseCase(repository: DependencyHelper.instance.serviceLocator()),
  );
  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => GetUserDataUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );
  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => UpdateProfileUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );
  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => UpdatePasswordUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );
  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => DeleteAccountUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );

  // REPOSITORIES
  DependencyHelper.instance.serviceLocator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDataSource: DependencyHelper.instance.serviceLocator()),
  );

  // DATASOURCES
  DependencyHelper.instance.serviceLocator.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(),
  );
}
