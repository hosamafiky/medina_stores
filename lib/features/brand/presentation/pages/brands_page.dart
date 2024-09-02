part of '../presentation_imports.dart';

class BrandsPage extends StatelessWidget {
  const BrandsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyHelper.instance.get<BrandCubit>()..getBrands(),
      child: const BrandsPageBody(),
    );
  }
}

class BrandsPageBody extends StatelessWidget {
  const BrandsPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: BlocSelector<BrandCubit, BrandState, ({UsecaseStatus status, Failure? failure, List<Brand> brands})>(
        selector: (state) => (status: state.brandsStatus, failure: state.brandsFailure, brands: state.brands),
        builder: (context, state) {
          return ListView.separated(
            padding: REdgeInsets.all(16),
            itemCount: state.brands.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final brand = state.brands[index];
              return Row(
                children: [
                  ImageWidget(
                    width: 60.r,
                    height: 60.r,
                    imageUrl: brand.media,
                    shape: BoxShape.circle,
                  ),
                  Text(brand.name),
                ],
              ).withSpacing(spacing: 12.w);
            },
          );
        },
      ),
    );
  }
}
