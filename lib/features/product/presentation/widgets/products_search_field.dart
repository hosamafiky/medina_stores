part of '../presentation_imports.dart';

class ProductsSearchField extends StatefulWidget {
  const ProductsSearchField({
    super.key,
    this.controller,
    this.padding = EdgeInsets.zero,
    this.readOnly = false,
  });

  final TextEditingController? controller;
  final EdgeInsetsGeometry padding;
  final bool readOnly;

  @override
  State<StatefulWidget> createState() => ProductsSearchFieldState();
}

class ProductsSearchFieldState extends State<ProductsSearchField> {
  final OverlayPortalController _tooltipController = OverlayPortalController();
  final _link = LayerLink();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state.productNameSuggestions.data!.isNotEmpty) {
          _tooltipController.show();
        }
        if (state.productNameSuggestions.data!.isEmpty) {
          _tooltipController.hide();
        }
      },
      child: BlocSelector<ProductCubit, ProductState, List<DropdownItem>>(
        selector: (state) => state.productNameSuggestions.data!,
        builder: (context, suggestions) {
          return CompositedTransformTarget(
            link: _link,
            child: OverlayPortal(
              controller: _tooltipController,
              overlayChildBuilder: (_) {
                return Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      width: 0.75.sw,
                      height: 200.h,
                      child: CompositedTransformFollower(
                        link: _link,
                        targetAnchor: Alignment.bottomLeft,
                        showWhenUnlinked: false,
                        offset: const Offset(0, 10),
                        child: AutoCompleteMenuWidget(
                          suggestions: suggestions,
                          onItemClicked: (item) {
                            widget.controller!.text = item.name;
                            context.read<ProductCubit>().clearNameSuggestions();
                            context.read<ProductCubit>().search(item.name);
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
              child: _SearchField(
                controller: widget.controller,
                padding: widget.padding,
                readOnly: widget.readOnly,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    this.controller,
    this.padding = EdgeInsets.zero,
    this.readOnly = false,
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
        onChanged: (value) => context.read<ProductCubit>().getProductNameSuggestions(value!),
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
