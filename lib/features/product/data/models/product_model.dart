part of '../data_imports.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.address,
    required super.region,
    required super.city,
    required super.country,
    required super.createdAt,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      region: map['region'] != null ? RegionModel.fromJson(map['region']) : const RegionModel(),
      city: map['city'] != null ? CityModel.fromJson(map['city']) : const CityModel(),
      country: map['country'] != null ? CountryModel.fromJson(map['country']) : const CountryModel(),
      createdAt: DateFormat('yyyy MMM dd hh:mm:ss').parse(map['created_at']),
    );
  }

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source));
}

class RegionModel extends Region {
  const RegionModel({
    super.id = 0,
    super.name = '',
  });

  factory RegionModel.fromJson(Map<String, dynamic> map) {
    return RegionModel(
      id: map['id'],
      name: map['name'],
    );
  }
}

class CityModel extends City {
  const CityModel({
    super.id = 0,
    super.name = '',
  });

  factory CityModel.fromJson(Map<String, dynamic> map) {
    return CityModel(
      id: map['id'],
      name: map['name'],
    );
  }
}

class CountryModel extends Country {
  const CountryModel({
    super.id = 0,
    super.name = '',
  });

  factory CountryModel.fromJson(Map<String, dynamic> map) {
    return CountryModel(
      id: map['id'],
      name: map['name'],
    );
  }
}
