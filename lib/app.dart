import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medina_stores/features/home/presentation/pages/home_page.dart';

import 'core/navigation/navigator.dart';
import 'core/navigation/route_generator.dart';
import 'core/observers/navigation_observer.dart';
import 'core/shared_cubits/theme/theme_cubit.dart';
import 'core/shared_widgets/state_managers/connectivity_manager.dart';
import 'core/shared_widgets/state_managers/loading_manager.dart';

class MedinaStoresApp extends StatelessWidget {
  const MedinaStoresApp({super.key});

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
          ],
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                title: 'Medina Stores',
                debugShowCheckedModeBanner: false,
                navigatorKey: AppNavigator.navigatorKey,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                onGenerateRoute: RouterGenerator.onGenerateRoute,
                navigatorObservers: [AppNavigationObserver()],
                theme: state.lightThemeData,
                darkTheme: state.darkThemeData,
                themeMode: state.themeMode,
                home: const HomePage(),
                builder: (context, child) {
                  return ConnectivityManager(child: LoadingManager(child: child!));
                },
              );
            },
          ),
        );
      },
    );
  }
}
