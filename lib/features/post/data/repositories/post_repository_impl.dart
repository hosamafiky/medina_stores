part of '../data_imports.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;

  const PostRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    return await remoteDataSource.getPosts.handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, Post>> addPost(AddPostParams params) async {
    return await remoteDataSource.addPost(params).handleCallbackWithFailure;
  }
}
