part of '../domain_imports.dart';

class GetPostsUsecase implements UseCaseWithoutParam<List<Post>> {
  final PostRepository repository;

  const GetPostsUsecase({required this.repository});

  @override
  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getPosts();
  }
}
