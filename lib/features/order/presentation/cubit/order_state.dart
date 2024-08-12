part of '../presentation_imports.dart';

class OrderState extends Equatable {
  const OrderState({
    this.ordersStatus = UsecaseStatus.idle,
    this.ordersFailure,
    this.orders = const [],
    this.addOrderStatus = UsecaseStatus.idle,
    this.addOrderFailure,
  });

  final UsecaseStatus ordersStatus;
  final Failure? ordersFailure;
  final List<Order> orders;

  final UsecaseStatus addOrderStatus;
  final Failure? addOrderFailure;

  OrderState copyWith({
    UsecaseStatus? ordersStatus,
    Failure? ordersFailure,
    List<Order>? orders,
    UsecaseStatus? addOrderStatus,
    Failure? addOrderFailure,
  }) {
    return OrderState(
      ordersStatus: ordersStatus ?? this.ordersStatus,
      ordersFailure: ordersFailure ?? this.ordersFailure,
      orders: orders ?? this.orders,
      addOrderStatus: addOrderStatus ?? this.addOrderStatus,
      addOrderFailure: addOrderFailure ?? this.addOrderFailure,
    );
  }

  @override
  String toString() {
    return 'OrderState(ordersStatus: $ordersStatus, ordersFailure: $ordersFailure, orders: $orders, addOrderStatus: $addOrderStatus, addOrderFailure: $addOrderFailure)';
  }

  @override
  List<Object?> get props => [
        ordersStatus,
        ordersFailure,
        orders,
        addOrderStatus,
        addOrderFailure,
      ];
}
