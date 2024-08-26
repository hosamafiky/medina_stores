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
    return Scaffold(
      appBar: const MainAppBar(),
      body: const Column(
        children: [
          CategoriesHorizontalList(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final cubit = context.read<CategoryCubit>();
          await context.showSheet<Category>(child: AddCategorySheet(categoryCubit: cubit));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
