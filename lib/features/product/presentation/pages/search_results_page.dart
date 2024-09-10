part of '../presentation_imports.dart';

class SearchResultsPage extends StatefulWidget {
  const SearchResultsPage({super.key});

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyHelper.instance.serviceLocator<ProductCubit>(),
      child: Scaffold(
        appBar: const MainAppBar(
          title: Text('Search Results'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            ProductsSearchField(
              controller: searchController,
              padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            Expanded(
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state.searchStatus == UsecaseStatus.error) {
                    return ErrorViewWidget(
                      state.searchFailure!,
                      onRetry: () => context.read<ProductCubit>().search(searchController.text),
                    );
                  }

                  if (state.searchResults.data!.list.isEmpty && state.searchStatus == UsecaseStatus.completed) {
                    return const Center(child: Text('No results found'));
                  }

                  return CustomScrollView(
                    slivers: [
                      SliverDynamicHeightGridView(
                        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        builder: (context, index) {
                          if (state.searchStatus == UsecaseStatus.running) return ProductWidget.skeleton();
                          final product = state.searchResults.data!.list[index];
                          return ProductWidget(product);
                        },
                        itemCount: state.searchStatus == UsecaseStatus.running ? 6 : state.searchResults.data!.list.length,
                        crossAxisCount: 3,
                        mainAxisSpacing: 12.h,
                        crossAxisSpacing: 12.w,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
