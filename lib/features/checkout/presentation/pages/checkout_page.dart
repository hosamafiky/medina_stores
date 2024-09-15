part of '../presentation_imports.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({
    super.key,
    required this.cartCubit,
  });

  final CartCubit cartCubit;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: cartCubit),
        BlocProvider(
          create: (context) => DependencyHelper.instance.serviceLocator<CheckoutCubit>()..getCheckoutData(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CheckoutCubit, CheckoutState>(
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
          ),
          BlocListener<CartCubit, CartState>(
            listener: (context, state) async {
              if (state.updateCartQuantityStatus == UsecaseStatus.completed) {
                context.read<CheckoutCubit>().getCheckoutData(true);
              }
            },
          ),
        ],
        child: BlocSelector<CheckoutCubit, CheckoutState,
            ({UsecaseStatus status, UsecaseStatus paymentGatesStatus, Failure? failure, ApiResponse<Checkout> data})>(
          selector: (state) => (
            status: state.checkoutStatus,
            paymentGatesStatus: state.paymentGatesStatus,
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
                    padding: REdgeInsets.symmetric(horizontal: 16).copyWith(
                      bottom: 16.h,
                    ),
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
                              if (state.status == UsecaseStatus.running) return CartItemWidget.skeleton();
                              final cartItem = state.data.data!.cart[index];
                              return CartItemWidget(cartItem, fromCheckout: true);
                            },
                            childCount: state.status == UsecaseStatus.running ? 2 : state.data.data!.cart.length,
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
                          trailing: state.paymentGatesStatus == UsecaseStatus.running
                              ? const CircularProgressIndicator.adaptive()
                              : TextButton.icon(
                                  onPressed: () => context.read<CheckoutCubit>().getPaymentGates(),
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
              bottomNavigationBar: PlaceOrderWidget(total: state.data.data!.total),
            );
          },
        ),
      ),
    );
  }
}
