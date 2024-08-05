part of '../domain_imports.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getPosts();
  Future<Either<Failure, Post>> addPost(AddPostParams params);
}
