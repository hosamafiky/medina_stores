part of '../presentation_imports.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit({
    Address? cachedAddress,
    required this.getAddressesUsecase,
    required this.addAddressUsecase,
  }) : super(AddressState(selectedAddress: cachedAddress));

  final GetAddressesUsecase getAddressesUsecase;
  final AddAddressUsecase addAddressUsecase;

  Future<void> getAddresses() async {
    emit(state.copyWith(addressesStatus: UsecaseStatus.running));
    final result = await getAddressesUsecase();
    result.fold(
      (failure) {
        emit(state.copyWith(addressesStatus: UsecaseStatus.error, addressesFailure: failure));
      },
      (addresses) {
        emit(state.copyWith(addressesStatus: UsecaseStatus.completed, addresses: addresses.data));
      },
    );
  }

  Future<void> selectAddress(Address address) async {
    await CacheHelper.delete(CacheKeys.selectedAddress);
    await CacheHelper.write(CacheKeys.selectedAddress, AddressModel.fromAddress(address).toJson());
    emit(state.copyWith(selectedAddress: address));
  }

  Future<void> addAddress(AddAddressParams params) async {
    emit(state.copyWith(addAddressestatus: UsecaseStatus.running));
    final result = await addAddressUsecase(params);
    result.fold(
      (failure) {
        emit(state.copyWith(addAddressestatus: UsecaseStatus.error, addAddressFailure: failure));
      },
      (response) {
        final oldAddresses = List<Address>.from(state.addresses);
        emit(state.copyWith(addAddressestatus: UsecaseStatus.completed, addresses: oldAddresses..add(response.data!)));
      },
    );
  }
}
