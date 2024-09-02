import 'dart:convert';

import 'package:equatable/equatable.dart';

class DropdownItem extends Equatable {
  final int id;
  final String name;

  const DropdownItem({
    this.id = 0,
    this.name = '',
  });

  @override
  List<Object?> get props => [id, name];
}

class DropdownItemModel extends DropdownItem {
  const DropdownItemModel({super.id, super.name});

  factory DropdownItemModel.fromDropdown(DropdownItem dropdown) {
    return DropdownItemModel(
      id: dropdown.id,
      name: dropdown.name,
    );
  }

  factory DropdownItemModel.fromMap(Map<String, dynamic>? json) {
    if (json == null) return const DropdownItemModel();
    return DropdownItemModel(
      id: json['id'],
      name: json['name'],
    );
  }

  factory DropdownItemModel.fromJson(String source) => DropdownItemModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() => {'id': id, 'name': name};

  String toJson() => json.encode(toMap());
}
