part of '../data_imports.dart';

class ProductRepositoryImpl implements ProductRepository {
  final InternetConnectionChecker connectionChecker;
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;

  const ProductRepositoryImpl({
    required this.connectionChecker,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, ApiResponse<PaginatedList<Product>>>> getSubCategoryProducts(GetCategoryProductsParams params) async {
    return await remoteDataSource.getSubCategoryProducts(params).handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<PaginatedList<Product>>>> getBrandProducts(GetBrandProductsParams params) async {
    return await remoteDataSource.getBrandProducts(params).handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<ProductDetails>>> getProductDetails(String slug) async {
    return await remoteDataSource.getProductDetails(slug).handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<List<ProductModel>>>> getRelatedProducts(String slug) async {
    return await remoteDataSource.getRelatedProducts(slug).handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<List<ProductModel>>>> getYouMayLikeProducts(String slug) async {
    return await remoteDataSource.getYouMayLikeProducts(slug).handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<bool>>> toggleFavorite(int productId) async {
    return await remoteDataSource.toggleFavorite(productId).handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<PaginatedList<ProductModel>>>> getFavoriteProducts(GetPaginatedListParams params) async {
    if (await connectionChecker.hasConnection) {
      try {
        final products = await remoteDataSource.getFavouriteProducts(params);
        final productsToCache = products.data!.list.map((product) => ProductModel.fromProduct(product)).toList();
        if (params.page == 1) await localDataSource.cacheFavouriteProducts(productsToCache);
        return Right(products);
      } on NoInternetConnectionException {
        try {
          final cachedProducts = await localDataSource.getCachedFavouriteProducts();
          return Right(ApiResponse(data: PaginatedList(list: cachedProducts)));
        } on CacheException catch (e) {
          return Left(CacheFailure(response: e.response));
        }
      } on AppException catch (e) {
        return Left(e.handleFailure);
      }
    } else {
      try {
        final cachedProducts = await localDataSource.getCachedFavouriteProducts();
        return Right(ApiResponse(data: PaginatedList(list: cachedProducts)));
      } on CacheException catch (e) {
        return Left(CacheFailure(response: e.response));
      }
    }
  }

  @override
  Future<Either<Failure, ApiResponse<List<Product>>>> getSuggestedCartProducts() async {
    return await remoteDataSource.getSuggestedCartProducts().handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<PaginatedList<Product>>>> getLatestProducts(GetPaginatedListParams params) async {
    if (await connectionChecker.hasConnection) {
      try {
        final products = await remoteDataSource.getLatestProducts(params);
        final productsToCache = products.data!.list.map((product) => ProductModel.fromProduct(product)).toList();
        await localDataSource.cacheLatestProducts(productsToCache);
        return Right(products);
      } on NoInternetConnectionException {
        try {
          final cachedProducts = await localDataSource.getCachedLatestProducts();
          return Right(ApiResponse(data: PaginatedList(list: cachedProducts)));
        } on CacheException catch (e) {
          return Left(CacheFailure(response: e.response));
        }
      } on AppException catch (e) {
        return Left(e.handleFailure);
      }
    } else {
      try {
        final cachedProducts = await localDataSource.getCachedLatestProducts();
        return Right(ApiResponse(data: PaginatedList(list: cachedProducts)));
      } on CacheException catch (e) {
        return Left(CacheFailure(response: e.response));
      }
    }
  }

  @override
  Future<Either<Failure, ApiResponse<PaginatedList<Product>>>> getSearchProducts(String query) async {
    return await remoteDataSource.getSearchProducts(query).handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<List<String>>>> getProductNameSuggestions(String query) async {
    return await remoteDataSource.getProductNameSuggestions(query).handleCallbackWithFailure;
  }
}
