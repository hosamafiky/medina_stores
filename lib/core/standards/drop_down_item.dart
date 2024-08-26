import 'dart:convert';

import 'package:equatable/equatable.dart';

class DropdownItem extends Equatable {
  final int id;
  final String name;

  const DropdownItem({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}

class DropdownItemModel extends DropdownItem {
  const DropdownItemModel({required super.id, required super.name});

  factory DropdownItemModel.fromMap(Map<String, dynamic> json) {
    return DropdownItemModel(
      id: json['id'],
      name: json['name'],
    );
  }

  factory DropdownItemModel.fromJson(String source) => DropdownItemModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() => {'id': id, 'name': name};

  String toJson() => json.encode(toMap());
}
