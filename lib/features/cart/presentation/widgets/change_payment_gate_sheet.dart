part of '../presentation_imports.dart';

class ChangePaymentGateSheet extends StatefulWidget {
  final List<PaymentGate> paymentGates;

  const ChangePaymentGateSheet({
    super.key,
    required this.paymentGates,
  });

  @override
  ChangePaymentGateSheetState createState() => ChangePaymentGateSheetState();
}

class ChangePaymentGateSheetState extends State<ChangePaymentGateSheet> {
  late PaymentGate _selectedPaymentGate;

  @override
  void initState() {
    super.initState();
    _selectedPaymentGate = widget.paymentGates.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16).copyWith(
        bottom: 16 + context.bottomBarHeight,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.select_payment_method.tr(),
            style: context.appTextStyle.elevatedButtonTextStyle,
          ),
          SizedBox(height: 16.h),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.paymentGates.length,
            itemBuilder: (context, index) {
              final paymentGate = widget.paymentGates[index];
              return ListTile(
                contentPadding: REdgeInsets.symmetric(horizontal: 12, vertical: 8),
                title: Text(paymentGate.name),
                selected: _selectedPaymentGate == paymentGate,
                selectedTileColor: context.colorPalette.primary.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                leading: ImageWidget(
                  imageUrl: paymentGate.image,
                  borderRadius: BorderRadius.circular(8.r),
                  width: 40.w,
                  height: 40.w,
                ),
                onTap: () => setState(() => _selectedPaymentGate = paymentGate),
              );
            },
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () => AppNavigator.pop(_selectedPaymentGate),
            child: Text(LocaleKeys.change_payment_method.tr()),
          ),
        ],
      ),
    );
  }
}
