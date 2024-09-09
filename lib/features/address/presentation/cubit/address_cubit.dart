part of '../presentation_imports.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit({
    Address? cachedAddress,
    required this.getAddressesUsecase,
    required this.addAddressUsecase,
    required this.updateAddressUsecase,
    required this.deleteAddressUsecase,
  }) : super(AddressState(selectedAddress: cachedAddress));

  final GetAddressesUsecase getAddressesUsecase;
  final AddAddressUsecase addAddressUsecase;
  final UpdateAddressUsecase updateAddressUsecase;
  final DeleteAddressUsecase deleteAddressUsecase;

  Future<void> checkIfLocationChanged() async {
    final position = await LocationHelper.getCurrentPosition();
    if (position == null) return;
    final selectedAddress = state.selectedAddress;
    if (selectedAddress == null) {
      final address = await AppNavigator.rootContext!.showSheet(
        child: const AddOrUpdateAddressSheet(),
        isDismissible: false,
        isDraggable: false,
        isScrollControlled: true,
      );
      if (address != null && address is Address) {
        selectAddress(address);
      }
    } else {
      final distance = LocationHelper.calculateDistanceInKM(selectedAddress.latitude, selectedAddress.longitude, position.latitude, position.longitude);
      if (distance > 1) {
        final address = await AppNavigator.rootContext!.showSheet(child: const ChooseAddressSheet());
        if (address != null && address is Address) {
          selectAddress(address);
        }
      }
    }
  }

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
    emit(state.copyWith(addAddressStatus: UsecaseStatus.running));
    final result = await addAddressUsecase(params);
    result.fold(
      (failure) {
        emit(state.copyWith(addAddressStatus: UsecaseStatus.error, addAddressFailure: failure));
      },
      (response) {
        final oldAddresses = List<Address>.from(state.addresses);
        emit(state.copyWith(addAddressStatus: UsecaseStatus.completed, addresses: oldAddresses..add(response.data!)));
      },
    );
  }

  Future<void> deleteAddress(int id) async {
    final oldAddresses = List<Address>.from(state.addresses);
    final addressIndex = oldAddresses.indexWhere((element) => element.id == id);
    if (addressIndex == -1) return;
    final oldAddress = oldAddresses[addressIndex];
    oldAddresses.removeAt(addressIndex);
    emit(state.copyWith(addresses: oldAddresses));

    final result = await deleteAddressUsecase(id);
    result.fold(
      (failure) {
        emit(state.copyWith(addresses: oldAddresses..insert(addressIndex, oldAddress)));
      },
      (response) {
        emit(state.copyWith(addresses: oldAddresses));
      },
    );
  }

  Future<void> updateAddress(UpdateAddressParams params) async {
    final oldAddresses = List<Address>.from(state.addresses);
    final addressIndex = oldAddresses.indexWhere((element) => element.id == params.address.id);
    if (addressIndex == -1) return;
    final oldAddress = oldAddresses[addressIndex];
    final newAddresses = oldAddresses.updateItemAtIndex(addressIndex, params.address);
    emit(state.copyWith(updateAddressStatus: UsecaseStatus.running, addresses: newAddresses));
    final result = await updateAddressUsecase(params);
    result.fold(
      (failure) {
        emit(state.copyWith(
          updateAddressStatus: UsecaseStatus.error,
          updateAddressFailure: failure,
          addresses: oldAddresses.updateItemAtIndex(addressIndex, oldAddress),
        ));
      },
      (response) {
        emit(state.copyWith(updateAddressStatus: UsecaseStatus.completed));
      },
    );
  }
}
