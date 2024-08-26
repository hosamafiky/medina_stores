part of '../presentation_imports.dart';

class SubCategoriesPage extends StatelessWidget {
  const SubCategoriesPage({super.key, required this.categoryId});

  final int categoryId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyHelper.instance.get<SubCategoryCubit>()..getSubCategories(categoryId),
      child: const SubCategoriesPageBody(),
    );
  }
}

class SubCategoriesPageBody extends StatelessWidget {
  const SubCategoriesPageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(title: Text('Sub Categories')),
      body: const Column(
        children: [
          SubCategoriesHorizontalList(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final cubit = context.read<SubCategoryCubit>();
          await context.showSheet<SubCategory>(child: AddSubCategorySheet(subCategoryCubit: cubit));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
