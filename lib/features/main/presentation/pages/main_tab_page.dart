part of '../presentation_imports.dart';

class MainTab extends StatelessWidget {
  const MainTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyHelper.instance.get<MainCubit>(),
      child: const MainTabPageBody(),
    );
  }
}

class MainTabPageBody extends StatelessWidget {
  const MainTabPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MainAppBar(
        title: Text('Main Tab Page'),
        padEnd: false,
        actions: [ThemeIconButton()],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Main Tab Page'),
          ],
        ),
      ),
    );
  }
}
