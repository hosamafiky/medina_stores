part of '../data_imports.dart';

class NewTabRepositoryImpl implements NewTabRepository {
  final NewTabRemoteDataSource remoteDataSource;

  const NewTabRepositoryImpl({required this.remoteDataSource});
}
