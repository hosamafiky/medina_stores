part of '../presentation_imports.dart';

class NewTabPage extends StatelessWidget {
  const NewTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyHelper.instance.get<ProductCubit>()..getLatestProducts(),
      child: const NewTabPageBody(),
    );
  }
}

class NewTabPageBody extends StatelessWidget {
  const NewTabPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: Text(LocaleKeys.whats_new.tr()),
      ),
      body: const CustomScrollView(
        slivers: [
          LatestProductsSection(),
          // SuggestedCartProductsSection(),
        ],
      ),
    );
  }
}
