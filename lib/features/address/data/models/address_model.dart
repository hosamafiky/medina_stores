part of '../data_imports.dart';

class AddressModel extends Address {
  AddressModel({
    required super.id,
    required super.title,
    required super.latitude,
    required super.longitude,
    required super.createdAt,
  });

  factory AddressModel.fromAddress(Address address) {
    return AddressModel(
      id: address.id,
      title: address.title,
      latitude: address.latitude,
      longitude: address.longitude,
      createdAt: address.createdAt,
    );
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'],
      title: map['title'],
      latitude: map['lat'],
      longitude: map['lon'],
      createdAt: DateFormat(ApiConstants.dateFormat, 'en_US').parse(map['created_at']),
    );
  }

  factory AddressModel.fromJson(String source) => AddressModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "lat": latitude,
      "lon": longitude,
      "created_at": DateFormat(ApiConstants.dateFormat, 'en_US').format(createdAt),
    };
  }

  String toJson() => json.encode(toMap());
}
