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
    this.verifyOTPStatus = UsecaseStatus.idle,
    this.verifyOTPFailure,
  });

  final UsecaseStatus loginStatus;
  final Failure? loginFailure;

  final UsecaseStatus logoutStatus;
  final Failure? logoutFailure;

  final UsecaseStatus registerStatus;
  final Failure? registerFailure;

  final UsecaseStatus sendOTPStatus;
  final Failure? sendOTPFailure;

  final UsecaseStatus verifyOTPStatus;
  final Failure? verifyOTPFailure;

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
    UsecaseStatus? verifyOTPStatus,
    Failure? verifyOTPFailure,
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
      verifyOTPStatus: verifyOTPStatus ?? UsecaseStatus.idle,
      verifyOTPFailure: verifyOTPFailure,
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
      verifyOTPStatus,
      verifyOTPFailure,
      user,
    ];
  }
}
