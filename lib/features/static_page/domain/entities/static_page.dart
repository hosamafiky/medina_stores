part of '../domain_imports.dart';

class StaticPage extends Equatable {
  final int userId;
  final int id;
  final String title;
  final String body;

  const StaticPage({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  StaticPage copyWith({
    int? userId,
    int? id,
    String? title,
    String? body,
  }) {
    return StaticPage(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  @override
  List<Object?> get props => [userId, id, title, body];
}
