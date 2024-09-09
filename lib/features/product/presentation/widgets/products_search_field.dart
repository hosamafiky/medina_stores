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
        builder: (context, state) {
          return CompositedTransformTarget(
            link: _link,
            child: OverlayPortal(
              controller: _tooltipController,
              overlayChildBuilder: (BuildContext context) {
                return CompositedTransformFollower(
                  link: _link,
                  targetAnchor: Alignment.bottomLeft,
                  showWhenUnlinked: false,
                  offset: const Offset(0, 10),
                  child: Container(
                    width: 10,
                    constraints: const BoxConstraints(maxHeight: 300),
                    decoration: ShapeDecoration(
                      color: context.colorPalette.background,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1.5,
                          color: context.colorPalette.background,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadows: [
                        BoxShadow(
                          color: context.colorPalette.cardShadow,
                          blurRadius: 32,
                          offset: const Offset(0, 20),
                          spreadRadius: -8,
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      itemCount: state.length,
                      itemBuilder: (context, index) {
                        final item = state[index];
                        return ListTile(
                          title: Text(item.name),
                          onTap: () {
                            widget.controller!.text = item.name;
                            context.read<ProductCubit>().clearNameSuggestions();
                            context.read<ProductCubit>().search(item.name);
                          },
                        );
                      },
                    ),
                  ),
                );
              },
              child: Padding(
                padding: widget.padding,
                child: AppTextField(
                  controller: widget.controller,
                  readOnly: widget.readOnly,
                  hintText: LocaleKeys.product_search_by.tr(),
                  onChanged: (value) => context.read<ProductCubit>().getProductNameSuggestions(value!),
                  onTap: !widget.readOnly
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
                    onPressed: widget.controller == null ? null : () => context.read<ProductCubit>().search(widget.controller!.text),
                    icon: const Icon(Icons.search),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
