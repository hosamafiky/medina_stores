part of '../domain_imports.dart';

abstract class StaticPageRepository {
  Future<Either<Failure, ApiResponse<String>>> getStaticPageData(String path);
}
