import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medina_stores/core/helpers/dependency_helper.dart';
import 'package:medina_stores/features/home/presentation/presentation_imports.dart';

import 'core/navigation/navigator.dart';
import 'core/navigation/route_generator.dart';
import 'core/notifications/notification_helper.dart';
import 'core/observers/navigation_observer.dart';
import 'core/shared_cubits/theme/theme_cubit.dart';
import 'core/shared_widgets/state_managers/connectivity_manager.dart';
import 'core/shared_widgets/state_managers/loading_manager.dart';
import 'features/user/domain/domain_imports.dart';
import 'features/user/presentation/presentation_imports.dart';

class MedinaStoresApp extends StatefulWidget {
  const MedinaStoresApp({super.key});

  @override
  State<MedinaStoresApp> createState() => _MedinaStoresAppState();
}

class _MedinaStoresAppState extends State<MedinaStoresApp> {
  User? cachedUser;
  @override
  void initState() {
    setUpNotifications();
    super.initState();
  }

  void setUpNotifications() async {
    await NotificationHelper.instance.setupNotifications();
    cachedUser = await DependencyHelper.instance.serviceLocator<UserCubit>().checkForCachedToken();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      //TODO: Change the designSize to the size of the design
      designSize: const Size(375, 812),
      minTextAdapt: true,
      ensureScreenSize: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ThemeCubit()..checkForCachedThemeMode(),
            ),
            BlocProvider(
              create: (context) => DependencyHelper.instance.serviceLocator<UserCubit>(),
            ),
          ],
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, tState) {
              return MaterialApp(
                title: 'Medina Stores',
                debugShowCheckedModeBanner: false,
                navigatorKey: AppNavigator.navigatorKey,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                onGenerateRoute: RouterGenerator.onGenerateRoute,
                navigatorObservers: [AppNavigationObserver()],
                theme: tState.lightThemeData,
                darkTheme: tState.darkThemeData,
                themeMode: tState.themeMode,
                home: cachedUser == null ? const LoginPage() : const HomePage(),
                builder: (context, child) => ConnectivityManager(child: LoadingManager(child: child!)),
              );
            },
          ),
        );
      },
    );
  }
}
