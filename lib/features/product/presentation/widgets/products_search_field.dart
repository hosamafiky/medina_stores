part of '../presentation_imports.dart';

class ProductsSearchField extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return BlocSelector<ProductCubit, ProductState, List<DropdownItem>>(
      selector: (state) => state.productNameSuggestions.data!,
      builder: (context, suggestions) {
        return Autocomplete<DropdownItem>(
          displayStringForOption: (option) => option.name,
          fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
            return _SearchField(
              controller: textEditingController,
              padding: padding,
              readOnly: readOnly,
              focusNode: focusNode,
            );
          },
          optionsMaxHeight: 200.h,
          optionsViewBuilder: (context, onSelected, _) {
            if (suggestions.isEmpty) return const SizedBox();
            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 200.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: suggestions
                    .map(
                      (option) => Padding(
                        padding: REdgeInsets.all(8.0),
                        child: ListTile(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                          tileColor: context.colorPalette.success,
                          title: Text(option.name),
                          onTap: () => onSelected(option),
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          },
          optionsBuilder: (_) => suggestions,
          onSelected: (value) {
            if (controller != null) controller!.text = value.name;
            context.read<ProductCubit>().clearNameSuggestions();
            context.read<ProductCubit>().search(value.name);
          },
        );
      },
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    this.controller,
    this.padding = EdgeInsets.zero,
    this.readOnly = false,
    this.focusNode,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry padding;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: AppTextField(
        controller: controller,
        readOnly: readOnly,
        focusNode: focusNode,
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
