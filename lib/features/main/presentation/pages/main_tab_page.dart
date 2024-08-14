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
      appBar: MainAppBar(
        title: Text(LocaleKeys.home.tr()),
        padEnd: false,
        actions: const [ThemeIconButton()],
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
