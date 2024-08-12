part of '../presentation_imports.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit({
    required this.getOrdersUsecase,
    required this.addOrderUsecase,
  }) : super(const OrderState());

  final GetOrdersUsecase getOrdersUsecase;
  final AddOrderUsecase addOrderUsecase;

  Future<void> getOrders() async {
    emit(state.copyWith(ordersStatus: UsecaseStatus.running));
    final result = await getOrdersUsecase();
    result.fold(
      (failure) {
        emit(state.copyWith(ordersStatus: UsecaseStatus.error, ordersFailure: failure));
      },
      (orders) {
        emit(state.copyWith(ordersStatus: UsecaseStatus.completed, orders: orders.data));
      },
    );
  }

  Future<void> addOrder(AddOrderParams params) async {
    emit(state.copyWith(addOrderStatus: UsecaseStatus.running));
    final result = await addOrderUsecase(params);
    result.fold(
      (failure) {
        emit(state.copyWith(addOrderStatus: UsecaseStatus.error, addOrderFailure: failure));
      },
      (response) {
        final oldOrders = List<Order>.from(state.orders);
        emit(state.copyWith(addOrderStatus: UsecaseStatus.completed, orders: oldOrders..insert(0, response.data!)));
      },
    );
  }
}
