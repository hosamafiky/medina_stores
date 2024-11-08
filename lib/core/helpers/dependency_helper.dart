import 'package:get_it/get_it.dart';
import '../../features/checkout/di/setup_checkout_dependencies.dart';
import '../../features/static_page/di/setup_static_page_dependencies.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../features/ad/di/setup_ad_dependencies.dart';
import '../../features/address/di/setup_address_dependencies.dart';
import '../../features/brand/di/setup_brand_dependencies.dart';
import '../../features/cart/di/setup_cart_dependencies.dart';
import '../../features/category/di/setup_category_dependencies.dart';
import '../../features/layout/di/setup_layout_dependencies.dart';
import '../../features/main_tab/di/setup_main_dependencies.dart';
import '../../features/product/di/setup_product_dependencies.dart';
import '../../features/sub_category/di/setup_sub_category_dependencies.dart';
import '../../features/user/di/setup_user_dependencies.dart';
import '../networking/api_service.dart';
import '../networking/dio_service.dart';

class DependencyHelper {
  DependencyHelper._();
  static final DependencyHelper instance = DependencyHelper._();
  factory DependencyHelper() => instance;

  final GetIt serviceLocator = GetIt.instance;

  void registerDependencies() {
    setUpGeneralDependencies();
    setUpCheckoutDependencies();
    setUpStaticPageDependencies();
    setUpAddressDependencies();
    setUpCartDependencies();
    setUpProductDependencies();
    setUpBrandDependencies();
    setUpSubCategoryDependencies();
    setUpCategoryDependencies();
    setUpAdDependencies();
    setUpMainDependencies();
    setUpLayoutDependencies();
    setUpUserDependencies();
  }

  void setUpGeneralDependencies() {
    serviceLocator.registerLazySingleton<ApiService>(() => DioService());
    serviceLocator.registerLazySingleton(() => InternetConnectionChecker());
  }
}

extension DependencyHelperExt on DependencyHelper {
  T get<T extends Object>() => serviceLocator<T>();
}
