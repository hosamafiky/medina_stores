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
              LocaleKeys.coupon_code.tr(),
              style: context.appTextStyle.elevatedButtonTextStyle,
            ),
            AppTextField(
              hintText: LocaleKeys.coupon_code_hint.tr(),
              suffixIcon: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  textStyle: context.appTextStyle.textButtonTextStyle.copyWith(fontSize: 12.sp),
                ),
                onPressed: () {},
                child: Text(LocaleKeys.apply.tr()),
              ),
            ),
          ],
        ).withSpacing(spacing: 10.h);
      },
    );
  }
}
