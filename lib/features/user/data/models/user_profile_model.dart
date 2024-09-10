part of '../data_imports.dart';

class UserProfileModel extends UserProfile {
  const UserProfileModel({
    super.id,
    super.name,
    super.email,
    super.phone,
    super.dialingCode,
    super.token,
    super.firstName,
    super.lastName,
    super.wallet,
    required super.createdAt,
  });

  factory UserProfileModel.fromUserProfile(UserProfile user) {
    return UserProfileModel(
      id: user.id,
      name: user.name,
      email: user.email,
      phone: user.phone,
      dialingCode: user.dialingCode,
      token: user.token,
      firstName: user.firstName,
      lastName: user.lastName,
      wallet: user.wallet,
      createdAt: user.createdAt,
    );
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      id: map['id'],
      name: map['name'] ?? map['first_name'] + ' ' + map['last_name'],
      email: map['email'],
      phone: map['phone'],
      dialingCode: map['dialing_code'],
      token: map['token'] ?? '',
      firstName: map['first_name'],
      lastName: map['last_name'],
      wallet: map['wallet'] ?? 0,
      createdAt: DateFormat(ApiConstants.dateFormat).parse(map['created_at']),
    );
  }

  factory UserProfileModel.fromJson(String source) => UserProfileModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "phone": phone,
      "dialing_code": dialingCode,
      "wallet": wallet,
      "created_at": DateFormat(ApiConstants.dateFormat).format(createdAt),
    };
  }

  String toJson() => json.encode(toMap());
}
