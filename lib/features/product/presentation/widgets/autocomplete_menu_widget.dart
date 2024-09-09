part of '../presentation_imports.dart';

class AutoCompleteMenuWidget extends StatefulWidget {
  const AutoCompleteMenuWidget({
    super.key,
    required this.suggestions,
    required this.onItemClicked,
  });

  final List<DropdownItem> suggestions;
  final Function(DropdownItem) onItemClicked;

  @override
  State<AutoCompleteMenuWidget> createState() => _AutoCompleteMenuWidgetState();
}

class _AutoCompleteMenuWidgetState extends State<AutoCompleteMenuWidget> {
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Scrollbar(
        controller: scrollController,
        child: ListView.builder(
          controller: scrollController,
          itemCount: widget.suggestions.length,
          itemBuilder: (context, index) {
            final item = widget.suggestions[index];
            return ListTile(
              title: Text(item.name),
              onTap: () => widget.onItemClicked(item),
            );
          },
        ),
      ),
    );
  }
}
