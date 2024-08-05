part of '../presentation_imports.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit({
    required this.getPostsUsecase,
    required this.addPostUsecase,
  }) : super(const PostState());

  final GetPostsUsecase getPostsUsecase;
  final AddPostUsecase addPostUsecase;

  Future<void> getPosts() async {
    emit(state.copyWith(postsStatus: UsecaseStatus.running));
    final result = await getPostsUsecase();
    result.fold(
      (failure) {
        emit(state.copyWith(postsStatus: UsecaseStatus.error, postsFailure: failure));
      },
      (posts) {
        emit(state.copyWith(postsStatus: UsecaseStatus.completed, posts: posts));
      },
    );
  }

  Future<void> addPost(AddPostParams params) async {
    emit(state.copyWith(addPostStatus: UsecaseStatus.running));
    final result = await addPostUsecase(params);
    result.fold(
      (failure) {
        emit(state.copyWith(addPostStatus: UsecaseStatus.error, addPostFailure: failure));
      },
      (post) {
        final oldPosts = List<Post>.from(state.posts);
        emit(state.copyWith(addPostStatus: UsecaseStatus.completed, posts: oldPosts..insert(0, post)));
      },
    );
  }
}
