part of '../presentation_imports.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyHelper.instance.get<CategoryCubit>()..getCategories(),
      child: const CategoriesPageBody(),
    );
  }
}

class CategoriesPageBody extends StatelessWidget {
  const CategoriesPageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MainAppBar(),
      body: Column(
        children: [
          // CategoriesHorizontalList(),
        ],
      ),
    );
  }
}
