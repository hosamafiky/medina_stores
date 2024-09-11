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
  State<ProductsSearchField> createState() => _ProductsSearchFieldState();
}

class _ProductsSearchFieldState extends State<ProductsSearchField> {
  final LayerLink _layerLink = LayerLink();
  final TextEditingController _controller = TextEditingController();
  OverlayEntry? _overlayEntry;
  bool _isOverlayVisible = false;

  OverlayEntry _createOverlayEntry(List<String> suggestions, ProductCubit productCubit) {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: 1.sw - 32.w,
        child: BlocProvider.value(
          value: productCubit,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(16.w, 0),
            targetAnchor: Alignment.bottomLeft,
            child: Material(
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  color: context.colorPalette.background,
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    BoxShadow(
                      color: context.colorPalette.cardShadow,
                      blurRadius: 8.r,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(suggestions[index]),
                      onTap: () {
                        _controller.text = suggestions[index];
                        context.read<ProductCubit>().search(suggestions[index]);
                        context.read<ProductCubit>().clearNameSuggestions();
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showOverlay(List<String> suggestions, {required ProductCubit productCubit}) {
    if (_overlayEntry == null && suggestions.isNotEmpty) {
      _overlayEntry = _createOverlayEntry(suggestions, productCubit);

      Overlay.of(context).insert(_overlayEntry!);
      _isOverlayVisible = true;
    } else if (_isOverlayVisible && suggestions.isNotEmpty) {
      _overlayEntry?.remove();
      _overlayEntry = _createOverlayEntry(suggestions, productCubit);
      Overlay.of(context).insert(_overlayEntry!);
    } else if (suggestions.isEmpty) {
      _removeOverlay();
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isOverlayVisible = false;
  }

  @override
  void dispose() {
    _controller.dispose();
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state.productNameSuggestions.data!.isNotEmpty) {
          _showOverlay(
            state.productNameSuggestions.data!,
            productCubit: context.read<ProductCubit>(),
          );
        } else {
          _removeOverlay();
        }
      },
      child: CompositedTransformTarget(
        link: _layerLink,
        child: _SearchField(
          controller: _controller,
          readOnly: widget.readOnly,
          padding: widget.padding,
        ),
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
        onChanged: context.read<ProductCubit>().getProductNameSuggestions,
        onTap: () {
          if (!readOnly) return;
          AppNavigator.to(
            const SearchResultsPage(),
            transition: TransitionType.fade,
            options: const FadeAnimationOptions(
              duration: Durations.short1,
              curve: Curves.easeInOutCubicEmphasized,
            ),
          );
        },
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
