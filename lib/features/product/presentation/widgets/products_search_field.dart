part of '../presentation_imports.dart';

class ProductsSearchField extends StatelessWidget {
  const ProductsSearchField({
    super.key,
    this.padding = EdgeInsets.zero,
    this.readOnly = false,
    this.controller,
  });

  final TextEditingController? controller;
  final EdgeInsetsGeometry padding;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: AppTextField(
        controller: controller,
        readOnly: readOnly,
        hintText: LocaleKeys.product_search_by.tr(),
        onTap: !readOnly
            ? null
            : () => AppNavigator.to(
                  const SearchResultsPage(),
                  transition: TransitionType.fade,
                  options: const FadeAnimationOptions(
                    duration: Durations.short1,
                    curve: Curves.easeInOutCubicEmphasized,
                  ),
                ),
        suffixIcon: IconButton(
          style: ButtonStyle(
            padding: WidgetStateProperty.all(EdgeInsets.zero),
            backgroundColor: WidgetStateProperty.all(context.colorPalette.secondary),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r))),
            foregroundColor: WidgetStateProperty.all(ColorPalette.whiteColor),
          ),
          onPressed: controller == null ? null : () => context.read<ProductCubit>().search(controller!.text),
          icon: const Icon(Icons.search),
        ),
      ),
    );
  }
}
