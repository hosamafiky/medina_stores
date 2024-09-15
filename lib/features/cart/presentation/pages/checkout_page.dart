part of '../presentation_imports.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({
    super.key,
    required this.cartCubit,
  });

  final CartCubit cartCubit;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  void initState() {
    widget.cartCubit.getCheckoutData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.cartCubit,
      child: BlocListener<CartCubit, CartState>(
        listener: (context, state) async {
          if (state.paymentGatesStatus == UsecaseStatus.completed) {
            final gate = await context.showSheet<PaymentGate>(
              child: ChangePaymentGateSheet(
                paymentGates: state.paymentGates.data!,
              ),
            );

            if (gate != null) {
              // Change Payment Gate
            }
          }
        },
        child: BlocSelector<CartCubit, CartState, ({UsecaseStatus status, Failure? failure, ApiResponse<CheckoutData> data})>(
          selector: (state) => (
            status: state.checkoutStatus,
            failure: state.checkoutFailure,
            data: state.checkoutResponse,
          ),
          builder: (context, state) {
            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverAppBar.large(
                    title: Text(LocaleKeys.checkout.tr()),
                    titleTextStyle: context.appTextStyle.appBarTitleStyle.copyWith(fontSize: 24.sp),
                  ),
                  SliverPadding(
                    padding: REdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverMainAxisGroup(
                      slivers: [
                        SizedBox(height: 16.h).asSliver,
                        Text(
                          LocaleKeys.products.tr(),
                          style: context.appTextStyle.elevatedButtonTextStyle,
                        ).asSliver,
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final cartItem = state.data.data!.cart[index];
                              return CartItemWidget(cartItem, fromCheckout: true);
                            },
                            childCount: state.data.data!.cart.length,
                          ),
                        ),
                        SizedBox(height: 16.h).asSliver,
                        Text(
                          LocaleKeys.payment_methods.tr(),
                          style: context.appTextStyle.elevatedButtonTextStyle,
                        ).asSliver,
                        ListTile(
                          leading: const Icon(Icons.credit_card_outlined),
                          title: Text(LocaleKeys.change_payment_method.tr()),
                          trailing: TextButton.icon(
                            onPressed: () => widget.cartCubit.getPaymentGates(),
                            icon: Icon(Icons.arrow_forward_ios_outlined, size: 12.sp),
                            iconAlignment: IconAlignment.end,
                            label: Text(LocaleKeys.change.tr()),
                          ),
                        ).asSliver,
                        SizedBox(height: 16.h).asSliver,
                        const CouponCodeWidget().asSliver,
                        SizedBox(height: 16.h).asSliver,
                        Text(
                          LocaleKeys.summary.tr(),
                          style: context.appTextStyle.elevatedButtonTextStyle,
                        ).asSliver,
                        ListTile(
                          title: Text(LocaleKeys.sub_total.tr()),
                          trailing: Text('${state.data.data!.subTotal.toStringAsFixed(2)} ${LocaleKeys.shorten_currency.tr()}'),
                        ).asSliver,
                        ListTile(
                          title: Text(LocaleKeys.shipping_fees.tr()),
                          trailing: Text('${state.data.data!.shippingFees.toStringAsFixed(2)} ${LocaleKeys.shorten_currency.tr()}'),
                        ).asSliver,
                        ListTile(
                          title: Text(LocaleKeys.tax.tr()),
                          trailing: Text('${state.data.data!.tax.toStringAsFixed(2)} ${LocaleKeys.shorten_currency.tr()}'),
                        ).asSliver,
                        ListTile(
                          title: Text(LocaleKeys.discount.tr()),
                          trailing: Text(
                            '- ${state.data.data!.discount.toStringAsFixed(2)} ${LocaleKeys.shorten_currency.tr()}',
                            style: context.appTextStyle.textButtonTextStyle.copyWith(
                              color: context.colorPalette.secondary,
                              fontSize: 10.sp,
                            ),
                          ),
                        ).asSliver,
                      ],
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: Container(
                padding: REdgeInsets.symmetric(horizontal: 16).copyWith(
                  bottom: 16 + context.bottomBarHeight,
                  top: 6.h,
                ),
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
                      title: Text(LocaleKeys.total.tr()),
                      trailing: Text('${state.data.data!.total.toStringAsFixed(2)} ${LocaleKeys.shorten_currency.tr()}'),
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
              ),
            );
          },
        ),
      ),
    );
  }
}
