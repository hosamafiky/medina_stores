part of '../presentation_imports.dart';

class BrandsHorizontalList extends StatelessWidget {
  const BrandsHorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<BrandCubit, BrandState>(
      listener: (context, state) {
        if (state.brandsStatus == UsecaseStatus.error) {
          MessageHelper.showErrorSnackBar("Failed to load brands ${state.brandsFailure!.response.message}");
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              LocaleKeys.brands.tr(),
              style: context.appTextStyle.elevatedButtonTextStyle,
            ),
          ),
          BlocSelector<BrandCubit, BrandState, ({UsecaseStatus status, Failure? failure, List<Brand> brands})>(
            selector: (state) => (status: state.brandsStatus, failure: state.brandsFailure, brands: state.brands),
            builder: (context, state) {
              final isLoading = state.status == UsecaseStatus.running;
              if (isLoading) return const _BrandsList.skeleton();
              if (state.failure != null) return Center(child: Text("Failed to load brands ${state.failure!.response.message}"));
              if (state.brands.isEmpty) return Center(child: Text(LocaleKeys.empty_brands.tr()));

              return _BrandsList(state.brands);
            },
          ),
        ],
      ),
    );
  }
}

class _BrandsList extends StatelessWidget {
  const _BrandsList(this.brands) : _isSkeleton = false;

  const _BrandsList.skeleton()
      : _isSkeleton = true,
        brands = const [];

  final List<Brand> brands;
  final bool _isSkeleton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _isSkeleton ? 135.h : 130.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        scrollDirection: Axis.horizontal,
        itemCount: _isSkeleton ? 5 : brands.length,
        separatorBuilder: (context, index) => SizedBox(width: 16.w),
        itemBuilder: (context, index) {
          if (_isSkeleton) return BrandCard.skeleton();
          final category = brands[index];
          return BrandCard(category);
        },
      ),
    );
  }
}
