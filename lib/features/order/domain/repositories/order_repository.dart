part of '../domain_imports.dart';

abstract class OrderRepository {
  Future<Either<Failure, ApiResponse<List<Order>>>> getOrders();
  Future<Either<Failure, ApiResponse<Order>>> addOrder(AddOrderParams params);
}
