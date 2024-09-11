part of '../presentation_imports.dart';

class UserState extends Equatable {
  const UserState({
    this.user,
    this.loginStatus = UsecaseStatus.idle,
    this.loginFailure,
    this.logoutStatus = UsecaseStatus.idle,
    this.logoutFailure,
    this.deleteAccountStatus = UsecaseStatus.idle,
    this.deleteAccountFailure,
    this.registerStatus = UsecaseStatus.idle,
    this.registerFailure,
    this.sendOTPStatus = UsecaseStatus.idle,
    this.sendOTPFailure,
    this.verifyOTPStatus = UsecaseStatus.idle,
    this.verifyOTPFailure,
    this.verifyPasswordOTPStatus = UsecaseStatus.idle,
    this.verifyPasswordOTPFailure,
    this.resetPasswordStatus = UsecaseStatus.idle,
    this.resetPasswordFailure,
    this.userProfileStatus,
    this.userProfileFailure,
    this.updateProfileStatus,
    this.updateProfileFailure,
    this.updateUserPasswordStatus,
    this.updateUserPasswordFailure,
    this.updateUserPasswordResponse,
    this.userProfile,
  });

  final UsecaseStatus loginStatus;
  final Failure? loginFailure;

  final UsecaseStatus deleteAccountStatus;
  final Failure? deleteAccountFailure;

  final UsecaseStatus logoutStatus;
  final Failure? logoutFailure;

  final UsecaseStatus registerStatus;
  final Failure? registerFailure;

  final UsecaseStatus sendOTPStatus;
  final Failure? sendOTPFailure;

  final UsecaseStatus verifyOTPStatus;
  final Failure? verifyOTPFailure;

  final UsecaseStatus verifyPasswordOTPStatus;
  final Failure? verifyPasswordOTPFailure;

  final UsecaseStatus resetPasswordStatus;
  final Failure? resetPasswordFailure;

  final ApiResponse<User?>? user;

  final UsecaseStatus? userProfileStatus;
  final Failure? userProfileFailure;
  final UsecaseStatus? updateProfileStatus;
  final Failure? updateProfileFailure;
  final ApiResponse<UserProfile>? userProfile;

  final UsecaseStatus? updateUserPasswordStatus;
  final Failure? updateUserPasswordFailure;
  final ApiResponse<void>? updateUserPasswordResponse;

  UserState copyWith({
    UsecaseStatus? loginStatus,
    Failure? loginFailure,
    UsecaseStatus? logoutStatus,
    Failure? logoutFailure,
    UsecaseStatus? deleteAccountStatus,
    Failure? deleteAccountFailure,
    UsecaseStatus? registerStatus,
    Failure? registerFailure,
    UsecaseStatus? sendOTPStatus,
    Failure? sendOTPFailure,
    UsecaseStatus? verifyOTPStatus,
    Failure? verifyOTPFailure,
    UsecaseStatus? verifyPasswordOTPStatus,
    Failure? verifyPasswordOTPFailure,
    UsecaseStatus? resetPasswordStatus,
    Failure? resetPasswordFailure,
    ApiResponse<User?>? user,
    UsecaseStatus? userProfileStatus,
    Failure? userProfileFailure,
    UsecaseStatus? updateProfileStatus,
    Failure? updateProfileFailure,
    UsecaseStatus? updateUserPasswordStatus,
    Failure? updateUserPasswordFailure,
    ApiResponse<void>? updateUserPasswordResponse,
    ApiResponse<UserProfile>? userProfile,
  }) {
    return UserState(
      loginStatus: loginStatus ?? UsecaseStatus.idle,
      loginFailure: loginFailure,
      logoutStatus: logoutStatus ?? UsecaseStatus.idle,
      logoutFailure: logoutFailure,
      deleteAccountStatus: deleteAccountStatus ?? UsecaseStatus.idle,
      deleteAccountFailure: deleteAccountFailure,
      registerStatus: registerStatus ?? UsecaseStatus.idle,
      registerFailure: registerFailure,
      sendOTPStatus: sendOTPStatus ?? UsecaseStatus.idle,
      sendOTPFailure: sendOTPFailure,
      verifyOTPStatus: verifyOTPStatus ?? UsecaseStatus.idle,
      verifyOTPFailure: verifyOTPFailure,
      verifyPasswordOTPStatus: verifyPasswordOTPStatus ?? UsecaseStatus.idle,
      verifyPasswordOTPFailure: verifyPasswordOTPFailure,
      resetPasswordStatus: resetPasswordStatus ?? UsecaseStatus.idle,
      resetPasswordFailure: resetPasswordFailure,
      user: user ?? this.user,
      userProfileStatus: userProfileStatus ?? this.userProfileStatus,
      userProfileFailure: userProfileFailure,
      updateProfileStatus: updateProfileStatus ?? this.updateProfileStatus,
      updateProfileFailure: updateProfileFailure,
      updateUserPasswordStatus: updateUserPasswordStatus ?? UsecaseStatus.idle,
      updateUserPasswordFailure: updateUserPasswordFailure,
      updateUserPasswordResponse: updateUserPasswordResponse ?? this.updateUserPasswordResponse,
      userProfile: userProfile ?? this.userProfile,
    );
  }

  @override
  List<Object?> get props {
    return [
      loginStatus,
      loginFailure,
      logoutStatus,
      logoutFailure,
      deleteAccountStatus,
      deleteAccountFailure,
      registerStatus,
      registerFailure,
      sendOTPStatus,
      sendOTPFailure,
      verifyOTPStatus,
      verifyOTPFailure,
      verifyPasswordOTPStatus,
      verifyPasswordOTPFailure,
      resetPasswordStatus,
      resetPasswordFailure,
      user,
      userProfileStatus,
      userProfileFailure,
      updateProfileStatus,
      updateProfileFailure,
      updateUserPasswordStatus,
      updateUserPasswordFailure,
      updateUserPasswordResponse,
      userProfile,
    ];
  }
}
