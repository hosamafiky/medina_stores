part of '../presentation_imports.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit({
    required this.getCheckoutDataUsecase,
    required this.getPaymentGatesUsecase,
  }) : super(const CheckoutState());

  final GetCheckoutDataUsecase getCheckoutDataUsecase;
  final GetPaymentGatesUsecase getPaymentGatesUsecase;

  void getCheckoutData([bool refresh = false]) async {
    if (!refresh) emit(state.copyWith(checkoutStatus: UsecaseStatus.running));
    final result = await getCheckoutDataUsecase();
    result.fold(
      (failure) => emit(state.copyWith(
        checkoutStatus: UsecaseStatus.error,
        checkoutFailure: failure,
      )),
      (checkout) => emit(state.copyWith(
        checkoutStatus: UsecaseStatus.completed,
        checkoutResponse: checkout,
      )),
    );
  }

  void getPaymentGates() async {
    emit(state.copyWith(paymentGatesStatus: UsecaseStatus.running));
    final result = await getPaymentGatesUsecase();
    result.fold(
      (failure) => emit(state.copyWith(paymentGatesStatus: UsecaseStatus.error, paymentGatesFailure: failure)),
      (gates) => emit(state.copyWith(paymentGatesStatus: UsecaseStatus.completed, paymentGates: gates)),
    );
  }
}
