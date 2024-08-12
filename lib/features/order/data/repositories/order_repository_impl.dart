part of '../data_imports.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  const OrderRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ApiResponse<List<Order>>>> getOrders() async {
    return await remoteDataSource.getOrders.handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<Order>>> addOrder(AddOrderParams params) async {
    return await remoteDataSource.addOrder(params).handleCallbackWithFailure;
  }
}
