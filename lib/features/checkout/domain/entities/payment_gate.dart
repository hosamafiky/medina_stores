part of '../domain_imports.dart';

class PaymentGate extends Equatable {
  final int id;
  final String name;
  final String type;
  final String image;
  final List<DropdownItem> paymentMethods;
  final String createdAt;

  const PaymentGate({
    required this.id,
    required this.name,
    required this.type,
    required this.image,
    required this.paymentMethods,
    required this.createdAt,
  });

  PaymentGate copyWith({
    int? id,
    String? name,
    String? type,
    String? image,
    List<DropdownItem>? paymentMethods,
    String? createdAt,
  }) =>
      PaymentGate(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        image: image ?? this.image,
        paymentMethods: paymentMethods ?? this.paymentMethods,
        createdAt: createdAt ?? this.createdAt,
      );

  @override
  List<Object> get props {
    return [
      id,
      name,
      type,
      image,
      paymentMethods,
      createdAt,
    ];
  }
}
