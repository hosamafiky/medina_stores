part of '../presentation_imports.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyHelper.instance.get<PostCubit>()..getPosts(),
      child: const PostsPageBody(),
    );
  }
}

class PostsPageBody extends StatelessWidget {
  const PostsPageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: MainAppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<PostCubit>().getPosts();
            },
          ),
          IconButton(
            onPressed: () {
              if (isDarkMode) {
                context.read<ThemeCubit>().setLightTheme();
              } else {
                context.read<ThemeCubit>().setDarkTheme();
              }
            },
            icon: Icon(isDarkMode ? Icons.brightness_7 : Icons.brightness_4),
          ),
        ],
      ),
      body: BlocSelector<PostCubit, PostState, ({UsecaseStatus status, Failure? failure, List<Post> posts})>(
        selector: (state) => (status: state.postsStatus, failure: state.postsFailure, posts: state.posts),
        builder: (context, state) {
          return ListView.separated(
            itemCount: state.posts.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final post = state.posts[index];
              return ListTile(
                leading: Text(post.id.toString()),
                title: Text(post.title),
                subtitle: Text(
                  post.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final cubit = context.read<PostCubit>();
          await context.showSheet<Post>(child: AddPostSheet(postCubit: cubit));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
