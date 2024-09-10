part of '../presentation_imports.dart';

class BottomNavBarWidget extends StatefulWidget {
  const BottomNavBarWidget(this.index, {super.key});

  final int index;

  @override
  State<BottomNavBarWidget> createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  void changeIndex(int index) {
    if (index == 2 || index == 3) {
      if (!context.isLoggedIn) {
        context.showSheet(
          child: VisitorLoginSheet(
            onLoggedInCallback: () => context.read<LayoutCubit>().changeIndex(index),
          ),
        );
        return;
      }
    }
    context.read<LayoutCubit>().changeIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.index,
      onTap: changeIndex,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          label: LocaleKeys.home.tr(context: context),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.new_releases_outlined),
          label: LocaleKeys.whats_new.tr(context: context),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.shopping_cart_outlined),
          label: LocaleKeys.my_orders.tr(context: context),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person_outline),
          label: LocaleKeys.me.tr(context: context),
        ),
      ],
    );
  }
}
