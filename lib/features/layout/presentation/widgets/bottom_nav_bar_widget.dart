part of '../presentation_imports.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget(this.index, {super.key});

  final int index;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: context.read<LayoutCubit>().changeIndex,
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
          label: LocaleKeys.profile.tr(context: context),
        ),
      ],
    );
  }
}
