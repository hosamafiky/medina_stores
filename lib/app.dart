import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medina_stores/core/shared_widgets/state_managers/connectivity_manager.dart';
import 'package:medina_stores/core/shared_widgets/state_managers/loading_manager.dart';

import 'config/themes/app_themes.dart';
import 'core/navigation/navigator.dart';
import 'core/navigation/route_generator.dart';
import 'core/observers/navigation_observer.dart';

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
        return MaterialApp(
          title: 'Medina Stores',
          debugShowCheckedModeBanner: false,
          navigatorKey: AppNavigator.navigatorKey,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          onGenerateRoute: RouterGenerator.onGenerateRoute,
          navigatorObservers: [AppNavigationObserver()],
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          home: const MyHomePage(),
          builder: (context, child) {
            return ConnectivityManager(child: LoadingManager(child: child!));
          },
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Medina Stores"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
