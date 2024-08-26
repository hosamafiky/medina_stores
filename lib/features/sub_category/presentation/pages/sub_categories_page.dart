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
      appBar: MainAppBar(title: Text(LocaleKeys.sub_categories.tr())),
      body: const Column(
        children: [
          // SubCategoriesHorizontalList(),
        ],
      ),
    );
  }
}
