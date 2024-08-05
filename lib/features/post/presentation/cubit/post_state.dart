part of '../presentation_imports.dart';

class PostState extends Equatable {
  const PostState({
    this.postsStatus = UsecaseStatus.idle,
    this.postsFailure,
    this.posts = const [],
    this.addPostStatus = UsecaseStatus.idle,
    this.addPostFailure,
  });

  final UsecaseStatus postsStatus;
  final Failure? postsFailure;
  final List<Post> posts;

  final UsecaseStatus addPostStatus;
  final Failure? addPostFailure;

  PostState copyWith({
    UsecaseStatus? postsStatus,
    Failure? postsFailure,
    List<Post>? posts,
    UsecaseStatus? addPostStatus,
    Failure? addPostFailure,
  }) {
    return PostState(
      postsStatus: postsStatus ?? this.postsStatus,
      postsFailure: postsFailure ?? this.postsFailure,
      posts: posts ?? this.posts,
      addPostStatus: addPostStatus ?? this.addPostStatus,
      addPostFailure: addPostFailure ?? this.addPostFailure,
    );
  }

  @override
  String toString() {
    return 'PostState(postsStatus: $postsStatus, postsFailure: $postsFailure, posts: $posts, addPostStatus: $addPostStatus, addPostFailure: $addPostFailure)';
  }

  @override
  List<Object?> get props => [
        postsStatus,
        postsFailure,
        posts,
        addPostStatus,
        addPostFailure,
      ];
}
