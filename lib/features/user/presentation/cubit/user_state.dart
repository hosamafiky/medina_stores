part of '../presentation_imports.dart';

class UserState extends Equatable {
  const UserState({
    this.user,
    this.loginStatus = UsecaseStatus.idle,
    this.loginFailure,
    this.logoutStatus = UsecaseStatus.idle,
    this.logoutFailure,
    this.registerStatus = UsecaseStatus.idle,
    this.registerFailure,
    this.sendOTPStatus = UsecaseStatus.idle,
    this.sendOTPFailure,
  });

  final UsecaseStatus loginStatus;
  final Failure? loginFailure;

  final UsecaseStatus logoutStatus;
  final Failure? logoutFailure;

  final UsecaseStatus registerStatus;
  final Failure? registerFailure;

  final UsecaseStatus sendOTPStatus;
  final Failure? sendOTPFailure;

  final ApiResponse<User?>? user;

  UserState copyWith({
    UsecaseStatus? loginStatus,
    Failure? loginFailure,
    UsecaseStatus? logoutStatus,
    Failure? logoutFailure,
    UsecaseStatus? registerStatus,
    Failure? registerFailure,
    UsecaseStatus? sendOTPStatus,
    Failure? sendOTPFailure,
    ApiResponse<User?>? user,
  }) {
    return UserState(
      loginStatus: loginStatus ?? UsecaseStatus.idle,
      loginFailure: loginFailure,
      logoutStatus: logoutStatus ?? UsecaseStatus.idle,
      logoutFailure: logoutFailure,
      registerStatus: registerStatus ?? UsecaseStatus.idle,
      registerFailure: registerFailure,
      sendOTPStatus: sendOTPStatus ?? UsecaseStatus.idle,
      sendOTPFailure: sendOTPFailure,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props {
    return [
      loginStatus,
      loginFailure,
      logoutStatus,
      logoutFailure,
      registerStatus,
      registerFailure,
      sendOTPStatus,
      sendOTPFailure,
      user,
    ];
  }
}
