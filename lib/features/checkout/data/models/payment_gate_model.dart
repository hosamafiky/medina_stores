part of '../data_imports.dart';

class PaymentGateModel extends PaymentGate {
  const PaymentGateModel({
    required super.id,
    required super.name,
    required super.type,
    required super.image,
    required super.paymentMethods,
    required super.createdAt,
  });

  factory PaymentGateModel.fromGate(PaymentGate gate) {
    return PaymentGateModel(
      id: gate.id,
      name: gate.name,
      type: gate.type,
      image: gate.image,
      paymentMethods: gate.paymentMethods,
      createdAt: gate.createdAt,
    );
  }

  factory PaymentGateModel.fromMap(Map<String, dynamic> map) {
    return PaymentGateModel(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      image: map['image'],
      paymentMethods: (map['payment_methods'] as List).map((e) => DropdownItemModel.fromMap(e)).toList(),
      createdAt: map['created_at'],
    );
  }

  factory PaymentGateModel.fromJson(String source) => PaymentGateModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'image': image,
      'payment_methods': paymentMethods.map((e) => DropdownItemModel.fromDropdown(e).toMap()).toList(),
      'created_at': createdAt,
    };
  }

  String toJson() => json.encode(toMap());
}
