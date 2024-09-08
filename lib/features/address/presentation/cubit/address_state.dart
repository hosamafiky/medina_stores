part of '../presentation_imports.dart';

class AddressState extends Equatable {
  const AddressState({
    this.selectedAddress,
    this.addressesStatus = UsecaseStatus.idle,
    this.addressesFailure,
    this.addresses = const [],
    this.addAddressestatus = UsecaseStatus.idle,
    this.addAddressFailure,
  });

  final Address? selectedAddress;

  final UsecaseStatus addressesStatus;
  final Failure? addressesFailure;
  final List<Address> addresses;

  final UsecaseStatus addAddressestatus;
  final Failure? addAddressFailure;

  AddressState copyWith({
    Address? selectedAddress,
    UsecaseStatus? addressesStatus,
    Failure? addressesFailure,
    List<Address>? addresses,
    UsecaseStatus? addAddressestatus,
    Failure? addAddressFailure,
  }) {
    return AddressState(
      selectedAddress: selectedAddress ?? this.selectedAddress,
      addressesStatus: addressesStatus ?? this.addressesStatus,
      addressesFailure: addressesFailure ?? this.addressesFailure,
      addresses: addresses ?? this.addresses,
      addAddressestatus: addAddressestatus ?? this.addAddressestatus,
      addAddressFailure: addAddressFailure ?? this.addAddressFailure,
    );
  }

  @override
  String toString() {
    return 'AddressState(addressesStatus: $addressesStatus, addressesFailure: $addressesFailure, addresses: $addresses, addAddressestatus: $addAddressestatus, addAddressFailure: $addAddressFailure)';
  }

  @override
  List<Object?> get props => [
        selectedAddress,
        addressesStatus,
        addressesFailure,
        addresses,
        addAddressestatus,
        addAddressFailure,
      ];
}
