part of '../presentation_imports.dart';

class AddressState extends Equatable {
  const AddressState({
    this.selectedAddress,
    this.addressesStatus = UsecaseStatus.idle,
    this.addressesFailure,
    this.addresses = const [],
    this.addAddressStatus = UsecaseStatus.idle,
    this.addAddressFailure,
    this.addAddressResponse,
    this.updateAddressStatus = UsecaseStatus.idle,
    this.updateAddressFailure,
    this.updateAddressResponse,
  });

  final Address? selectedAddress;

  final UsecaseStatus addressesStatus;
  final Failure? addressesFailure;
  final List<Address> addresses;

  final UsecaseStatus addAddressStatus;
  final Failure? addAddressFailure;
  final ApiResponse<Address>? addAddressResponse;

  final UsecaseStatus updateAddressStatus;
  final Failure? updateAddressFailure;
  final ApiResponse<Address>? updateAddressResponse;

  AddressState copyWith({
    Address? selectedAddress,
    UsecaseStatus? addressesStatus,
    Failure? addressesFailure,
    List<Address>? addresses,
    UsecaseStatus? addAddressStatus,
    Failure? addAddressFailure,
    ApiResponse<Address>? addAddressResponse,
    UsecaseStatus? updateAddressStatus,
    Failure? updateAddressFailure,
    ApiResponse<Address>? updateAddressResponse,
  }) {
    return AddressState(
      selectedAddress: selectedAddress ?? this.selectedAddress,
      addressesStatus: addressesStatus ?? this.addressesStatus,
      addressesFailure: addressesFailure ?? this.addressesFailure,
      addresses: addresses ?? this.addresses,
      addAddressStatus: addAddressStatus ?? this.addAddressStatus,
      addAddressFailure: addAddressFailure ?? this.addAddressFailure,
      addAddressResponse: addAddressResponse ?? this.addAddressResponse,
      updateAddressStatus: updateAddressStatus ?? this.updateAddressStatus,
      updateAddressFailure: updateAddressFailure ?? this.updateAddressFailure,
      updateAddressResponse: updateAddressResponse ?? this.updateAddressResponse,
    );
  }

  @override
  String toString() {
    return 'AddressState(addressesStatus: $addressesStatus, addressesFailure: $addressesFailure, addresses: $addresses, addAddressestatus: $addAddressStatus, addAddressFailure: $addAddressFailure)';
  }

  @override
  List<Object?> get props => [
        selectedAddress,
        addressesStatus,
        addressesFailure,
        addresses,
        addAddressStatus,
        addAddressFailure,
        addAddressResponse,
        updateAddressStatus,
        updateAddressFailure,
        updateAddressResponse,
      ];
}
