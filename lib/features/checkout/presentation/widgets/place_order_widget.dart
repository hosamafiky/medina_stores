part of '../presentation_imports.dart';

class PlaceOrderWidget extends StatelessWidget {
  const PlaceOrderWidget({super.key, this.total = 0.0});

  final num total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 16).copyWith(bottom: (16 + context.bottomBarHeight).h, top: 6.h),
      decoration: BoxDecoration(
        color: context.colorPalette.background,
        boxShadow: [
          BoxShadow(
            color: context.colorPalette.cardShadow,
            blurRadius: 16.sp,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              LocaleKeys.total.tr(),
              style: context.appTextStyle.elevatedButtonTextStyle,
            ),
            trailing: Text('${total.toStringAsFixed(2)} ${LocaleKeys.shorten_currency.tr()}'),
          ),
          ElevatedButton(
            onPressed: () {
              // Place Order
              AppNavigator.pop('placed-order');
            },
            child: Text(LocaleKeys.place_order.tr()),
          ),
        ],
      ).withSpacing(spacing: 8.h),
    );
  }
}
