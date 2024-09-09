import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:medina_stores/core/helpers/dependency_helper.dart';
import 'package:medina_stores/features/address/domain/domain_imports.dart';
import 'package:medina_stores/features/address/presentation/presentation_imports.dart';
import 'package:medina_stores/features/language/presentation/presentation_imports.dart';
import 'package:medina_stores/features/layout/presentation/presentation_imports.dart';

import 'config/resources/locale_keys.g.dart';
import 'core/helpers/dynamic_links_helper.dart';
import 'core/helpers/message_helper.dart';
import 'core/navigation/navigator.dart';
import 'core/navigation/route_generator.dart';
import 'core/notifications/notification_helper.dart';
import 'core/observers/navigation_observer.dart';
import 'core/shared_widgets/state_managers/loading_manager.dart';
import 'features/cart/presentation/presentation_imports.dart';
import 'features/theme/presentation/cubit/theme_cubit.dart';
import 'features/user/domain/domain_imports.dart';
import 'features/user/presentation/presentation_imports.dart';

class MedinaStoresApp extends StatefulWidget {
  const MedinaStoresApp({
    super.key,
    this.cachedUser,
    this.cachedThemeMode,
    this.cachedAddress,
  });

  final User? cachedUser;
  final ThemeMode? cachedThemeMode;
  final Address? cachedAddress;

  @override
  State<MedinaStoresApp> createState() => _MedinaStoresAppState();
}

class _MedinaStoresAppState extends State<MedinaStoresApp> {
  late StreamSubscription connectionStream;
  late StreamSubscription statusStream;
  final connectivity = Connectivity();
  final checker = InternetConnectionChecker();
  ValueNotifier<bool> isConnected = ValueNotifier(true);

  @override
  void initState() {
    setUpNotifications();
    checkConnectivity();
    super.initState();
  }

  void onConnectionChanged(bool isConnected) {
    this.isConnected.value = isConnected;
    if (AppNavigator.rootContext != null) {
      if (!isConnected) {
        MessageHelper.showErrorSnackBar(
          LocaleKeys.check_internet.tr(),
          duration: const Duration(days: 1),
          dismissDirection: DismissDirection.none,
        );
      } else {
        MessageHelper.clearSnackBars();
      }
    }
  }

  void checkConnectivity() async {
    final results = await connectivity.checkConnectivity();
    onConnectionChanged(await checkIfConnected(results));

    connectionStream = connectivity.onConnectivityChanged.listen((results) async {
      onConnectionChanged(await checkIfConnected(results));
    });

    statusStream = checker.onStatusChange.listen((status) {
      onConnectionChanged(status == InternetConnectionStatus.connected);
    });
  }

  Future<bool> checkIfConnected(List<ConnectivityResult> results) async {
    if (!results.contains(ConnectivityResult.none)) return await checker.hasConnection;
    return false;
  }

  void setUpNotifications() async {
    await NotificationHelper.instance.setupNotifications();
    DynamicLinksHelper.handleDynamicLinkWhenAppIsOpened();
  }

  @override
  void dispose() {
    connectionStream.cancel();
    statusStream.cancel();
    super.dispose();
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
              create: (context) => DependencyHelper.instance.serviceLocator<CartCubit>(),
            ),
            BlocProvider(
              create: (context) => LanguageCubit(savedLocale),
            ),
            BlocProvider(
              create: (context) => DependencyHelper.instance.serviceLocator<AddressCubit>(param1: widget.cachedAddress)..checkIfLocationChanged(),
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
                home: const LayoutPage(),
                builder: (context, child) => LoadingManager(child: child!),
              );
            },
          ),
        );
      },
    );
  }
}
