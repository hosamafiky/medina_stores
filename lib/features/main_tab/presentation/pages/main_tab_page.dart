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
    checkIfLocationChanged();
    if (context.isLoggedIn) context.read<CartCubit>().getCartItems();
  }

  Future<void> checkIfLocationChanged() async {
    final position = await LocationHelper.getCurrentPosition();
    if (position == null) return;
    if (!context.mounted || !mounted) return;
    final cubit = context.read<AddressCubit>();
    final selectedAddress = cubit.state.selectedAddress;
    if (selectedAddress == null) {
      final address = await context.showSheet(child: const AddAddressSheet());
      if (address != null && context.mounted && mounted && address is Address) {
        cubit.selectAddress(address);
      }
    } else {
      final distance = LocationHelper.calculateDistanceInKM(selectedAddress.latitude, selectedAddress.longitude, position.latitude, position.longitude);
      if (distance > 1) {
        final address = await context.showSheet(child: const ChooseAddressSheet());
        if (address != null && context.mounted && mounted && address is Address) {
          cubit.selectAddress(address);
        }
      }
    }
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
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('التوصيل إلى : ', style: TextStyle(fontSize: 12.sp)),
            BlocSelector<AddressCubit, AddressState, Address?>(
              selector: (state) => state.selectedAddress,
              builder: (context, state) {
                return InkWell(
                  onTap: () async {
                    final result = await context.showSheet(child: const ChooseAddressSheet());
                    if (result != null && context.mounted) {
                      context.read<AddressCubit>().selectAddress(result);
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        state?.title ?? 'غير محدد',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                );
              },
            )
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () async {
              if (context.isLoggedIn) {
                final result = await AppNavigator.to(const CartPage());
                if (result == 'browse' && context.mounted) {
                  _onRefresh(context);
                }
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
