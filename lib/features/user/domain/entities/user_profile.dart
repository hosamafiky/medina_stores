part of '../domain_imports.dart';

class UserProfile extends User with EquatableMixin {
  final String firstName;
  final String lastName;
  final num wallet;
  final DateTime createdAt;

  String get abbrev => firstName.characters.first.toUpperCase() + lastName.characters.first.toUpperCase();

  const UserProfile({
    super.id,
    super.name,
    super.email,
    super.phone,
    super.dialingCode,
    super.token,
    this.firstName = '',
    this.lastName = '',
    this.wallet = 0,
    required this.createdAt,
  });

  factory UserProfile.fromUser(User user) {
    return UserProfile(
      id: user.id,
      name: user.name,
      firstName: user.name.split(' ').first,
      lastName: user.name.split(' ').last,
      email: user.email,
      phone: user.phone,
      dialingCode: user.dialingCode,
      token: user.token,
      createdAt: DateTime.now(),
    );
  }

  @override
  UserProfile copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? dialingCode,
    String? token,
    String? firstName,
    String? lastName,
    num? wallet,
    DateTime? createdAt,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      dialingCode: dialingCode ?? this.dialingCode,
      token: token ?? this.token,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      wallet: wallet ?? this.wallet,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        firstName,
        lastName,
        wallet,
        createdAt,
      ];
}
