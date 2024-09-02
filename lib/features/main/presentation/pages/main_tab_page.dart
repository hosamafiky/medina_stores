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
          lazy: false,
          create: (context) => DependencyHelper.instance.get<CategoryCubit>()..getCategories(),
        ),
        BlocProvider(
          create: (context) => DependencyHelper.instance.get<BrandCubit>()..getBrands(),
        ),
      ],
      child: const MainTabPageBody(),
    );
  }
}

class MainTabPageBody extends StatelessWidget {
  const MainTabPageBody({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    await Future.wait([
      context.read<AdCubit>().getAds(),
      context.read<CategoryCubit>().getCategories(),
      context.read<BrandCubit>().getBrands(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: Text(LocaleKeys.home.tr())),
      body: RefreshIndicator.adaptive(
        onRefresh: () => _onRefresh(context),
        child: CustomScrollView(
          slivers: [
            SliverList.list(
              children: [
                SizedBox(height: 16.h),
                const AdsScrollingWidget(),
                const BrandsHorizontalList(),
              ].withSpacing(spacing: 16.h),
            ),
            const CategoriesLisViewWidget(),
          ],
        ),
      ),
    );
  }
}
