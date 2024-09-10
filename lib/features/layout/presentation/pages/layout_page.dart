part of '../presentation_imports.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyHelper.instance.get<LayoutCubit>(),
      child: const LayoutPageBody(),
    );
  }
}

class LayoutPageBody extends StatefulWidget {
  const LayoutPageBody({super.key});

  @override
  State<LayoutPageBody> createState() => _LayoutPageBodyState();
}

class _LayoutPageBodyState extends State<LayoutPageBody> {
  final List<Widget> views = const [MainTab(), NewTabPage(), MainTab(), MeTab()];

  @override
  void initState() {
    DynamicLinksHelper.handleDynamicLinkWhenAppTerminated();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, int>(
      builder: (context, index) {
        return Scaffold(
          body: views[index],
          bottomNavigationBar: BottomNavBarWidget(index),
        );
      },
    );
  }
}
