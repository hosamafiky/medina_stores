import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medina_stores/core/extensions/context.dart';
import 'package:medina_stores/features/cart/presentation/presentation_imports.dart';

import '../../../config/resources/color_palettes/color_palette.dart';
import '../../navigation/navigator.dart';

class CartStateManager extends StatefulWidget {
  final Widget child;
  const CartStateManager({super.key, required this.child});

  @override
  State<CartStateManager> createState() => _CartStateManagerState();
}

class _CartStateManagerState extends State<CartStateManager> {
  bool isCurrentlyConnected = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              widget.child,
              if (state.cartItems.isNotEmpty) ...[
                Container(
                  margin: EdgeInsetsDirectional.only(
                    bottom: context.bottomBarHeight + kBottomNavigationBarHeight + 16.h,
                    start: 16.w,
                    end: 16.w,
                  ),
                  width: 1.sw,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.colorPalette.onBackground,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Total: ${state.total} SAR',
                        style: TextStyle(
                          color: ColorPalette.whiteColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        child: TextButton(
                          style: ButtonStyle(
                            foregroundColor: WidgetStateProperty.all(ColorPalette.whiteColor),
                          ),
                          onPressed: () {
                            AppNavigator.to(const CartPage());
                          },
                          child: const Text('View Cart'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
