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
        BlocProvider(
          create: (context) => DependencyHelper.instance.get<AdCubit>()..getAds(),
        ),
      ],
      child: const MainTabPageBody(),
    );
  }
}

class MainTabPageBody extends StatefulWidget {
  const MainTabPageBody({super.key});

  @override
  State<MainTabPageBody> createState() => _MainTabPageBodyState();
}

class _MainTabPageBodyState extends State<MainTabPageBody> {
  @override
  void initState() {
    super.initState();
    if (context.isLoggedIn) context.read<CartCubit>().getCartItems();
  }

  Future<void> _onRefresh(BuildContext context) async {
    await Future.wait([
      context.read<AdCubit>().getAds(refresh: true),
      context.read<CategoryCubit>().getCategories(),
      context.read<BrandCubit>().getBrands(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: Text(LocaleKeys.home.tr()),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () async {
              if (context.isLoggedIn) {
                await AppNavigator.to(const CartPage());
              } else {
                await context.showSheet(
                  child: VisitorLoginSheet(
                    onLoggedInCallback: () async {
                      await AppNavigator.to(const CartPage());
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
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
            const CategoriesListViewWidget(),
          ],
        ),
      ),
    );
  }
}
