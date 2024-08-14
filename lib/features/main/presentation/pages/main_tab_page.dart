part of '../presentation_imports.dart';

class MainTab extends StatelessWidget {
  const MainTab({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DependencyHelper.instance.get<MainCubit>(),
        ),
        BlocProvider(
          create: (context) => DependencyHelper.instance.get<SliderCubit>()..getSliders(),
        ),
      ],
      child: const MainTabPageBody(),
    );
  }
}

class MainTabPageBody extends StatelessWidget {
  const MainTabPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
        title: Text('Main Tab Page'),
        padEnd: false,
        actions: [ThemeIconButton()],
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(vertical: 16),
        child: const Column(
          children: [
            SlidersAnimatingWidget(),
          ],
        ).withSpacing(spacing: 16.h),
      ),
    );
  }
}
