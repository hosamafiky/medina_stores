part of '../domain_imports.dart';

class Order extends Equatable {
  final int userId;
  final int id;
  final String title;
  final String body;

  const Order({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  Order copyWith({
    int? userId,
    int? id,
    String? title,
    String? body,
  }) {
    return Order(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  @override
  List<Object?> get props => [userId, id, title, body];
}
