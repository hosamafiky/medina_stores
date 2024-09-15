part of '../presentation_imports.dart';

class CouponCodeWidget extends StatelessWidget {
  const CouponCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Coupon Code',
              style: context.appTextStyle.elevatedButtonTextStyle,
            ),
            AppTextField(
              hintText: 'Enter your coupon code',
              suffixIcon: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  textStyle: context.appTextStyle.textButtonTextStyle.copyWith(fontSize: 12.sp),
                ),
                onPressed: () {},
                child: const Text('Apply'),
              ),
            ),
          ],
        ).withSpacing(spacing: 10.h);
      },
    );
  }
}
