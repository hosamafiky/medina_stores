part of '../presentation_imports.dart';

class UserState extends Equatable {
  const UserState({
    this.user,
    this.loginStatus = UsecaseStatus.idle,
    this.loginFailure,
  });

  final UsecaseStatus loginStatus;
  final Failure? loginFailure;
  final User? user;

  UserState copyWith({
    UsecaseStatus? loginStatus,
    Failure? loginFailure,
    User? user,
  }) {
    return UserState(
      loginStatus: loginStatus ?? UsecaseStatus.idle,
      loginFailure: loginFailure,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [loginStatus, loginFailure, user];
}
