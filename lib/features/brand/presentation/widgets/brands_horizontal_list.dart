part of '../presentation_imports.dart';

class BrandsHorizontalList extends StatelessWidget {
  const BrandsHorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocSelector<BrandCubit, BrandState, ({UsecaseStatus status, Failure? failure, List<Brand> brands})>(
          selector: (state) => (status: state.brandsStatus, failure: state.brandsFailure, brands: state.brands),
          builder: (context, state) {
            final isLoading = state.status == UsecaseStatus.running;
            final isFailed = state.status == UsecaseStatus.error;

            if (isLoading) return const _BrandsList.skeleton();
            if (isFailed) {
              return ErrorViewWidget(
                state.failure!,
                onRetry: () => context.read<BrandCubit>().getBrands(),
              );
            }

            if (state.brands.isEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(LocaleKeys.empty_brands.tr()),
              );
            }

            return _BrandsList(state.brands);
          },
        ),
      ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerWidget.fromChild(
          isLoading: _isSkeleton,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              LocaleKeys.brands.tr(),
              style: context.appTextStyle.elevatedButtonTextStyle,
            ),
          ),
        ),
        SizedBox(
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
        ),
      ],
    );
  }
}
