import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medina_stores/core/utils/user_utils.dart';
import 'package:medina_stores/features/theme/presentation/cubit/theme_cubit.dart';

import 'app.dart';
import 'config/resources/languages.dart';
import 'core/helpers/cache_helper.dart';
import 'core/helpers/dependency_helper.dart';
import 'core/navigation/Constants/imports_constants.dart';
import 'core/navigation/Transition/implementation/slide/Option/slide_animation_option.dart';
import 'core/navigation/page_router/Implementation/imports_page_router.dart';
import 'core/navigation/page_router/imports_page_router_builder.dart';
import 'core/observers/bloc_observer.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();

  await Future.wait([
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    EasyLocalization.ensureInitialized(),
    CacheHelper.init(),
  ]);

  DependencyHelper.instance.registerDependencies();

  final cachedUser = await UserUtils.getCachedUser();
  final cachedThemeModeString = await CacheHelper.read(CacheKeys.themeMode) as String?;
  final cachedThemeMode = cachedThemeModeString?.asThemeMode;

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  PageRouterBuilder.instance.initAppRouter(
    config: PlatformConfig(
      android: CustomPageRouterCreator(
        parentTransition: TransitionType.slide,
        parentOptions: const SlideAnimationOptions(
          direction: SlideDirection.leftToRight,
          duration: Duration(milliseconds: 300),
        ),
      ),
      ios: CustomPageRouterCreator(
        parentTransition: TransitionType.slide,
        parentOptions: const SlideAnimationOptions(
          direction: SlideDirection.leftToRight,
          duration: Duration(milliseconds: 300),
        ),
      ),
    ),
  );

  runApp(
    EasyLocalization(
      supportedLocales: Language.supportedLocales,
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      child: MedinaStoresApp(
        cachedUser: cachedUser,
        cachedThemeMode: cachedThemeMode,
      ),
    ),
  );
}
