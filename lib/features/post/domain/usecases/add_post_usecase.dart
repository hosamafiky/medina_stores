part of '../domain_imports.dart';

class AddPostUsecase implements UseCase<Post, AddPostParams> {
  final PostRepository repository;

  const AddPostUsecase({required this.repository});

  @override
  Future<Either<Failure, Post>> call(AddPostParams params) async {
    return repository.addPost(params);
  }
}

class AddPostParams {
  final String title;
  final String body;

  const AddPostParams({
    required this.title,
    required this.body,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'userId': 1,
    };
  }
}
