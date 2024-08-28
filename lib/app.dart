import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medina_stores/core/helpers/dependency_helper.dart';
import 'package:medina_stores/features/chat/presentation/presentation_imports.dart';
import 'package:medina_stores/features/language/presentation/presentation_imports.dart';

import 'core/navigation/navigator.dart';
import 'core/navigation/route_generator.dart';
import 'core/notifications/notification_helper.dart';
import 'core/observers/navigation_observer.dart';
import 'core/shared_widgets/state_managers/connectivity_manager.dart';
import 'core/shared_widgets/state_managers/loading_manager.dart';
import 'features/theme/presentation/cubit/theme_cubit.dart';
import 'features/user/domain/domain_imports.dart';
import 'features/user/presentation/presentation_imports.dart';

class MedinaStoresApp extends StatefulWidget {
  const MedinaStoresApp({
    super.key,
    this.cachedUser,
    this.cachedThemeMode,
  });

  final User? cachedUser;
  final ThemeMode? cachedThemeMode;

  @override
  State<MedinaStoresApp> createState() => _MedinaStoresAppState();
}

class _MedinaStoresAppState extends State<MedinaStoresApp> {
  @override
  void initState() {
    setUpNotifications();
    super.initState();
  }

  void setUpNotifications() async {
    await NotificationHelper.instance.setupNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      //TODO: Change the designSize to the size of the design
      designSize: const Size(375, 812),
      minTextAdapt: true,
      ensureScreenSize: true,
      builder: (context, child) {
        final savedLocale = context.savedLocale ?? context.deviceLocale;
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ThemeCubit(widget.cachedThemeMode),
            ),
            BlocProvider(
              create: (context) => DependencyHelper.instance.serviceLocator<UserCubit>()..initWithCachedUser(widget.cachedUser),
            ),
            BlocProvider(
              create: (context) => LanguageCubit(savedLocale),
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
                home: const ChatsPage(), // widget.cachedUser == null ? const LoginPage() : const ChatsPage(),
                builder: (context, child) => ConnectivityManager(child: LoadingManager(child: child!)),
              );
            },
          ),
        );
      },
    );
  }
}
