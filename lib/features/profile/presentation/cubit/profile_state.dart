part of '../presentation_imports.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.profilesStatus = UsecaseStatus.idle,
    this.profilesFailure,
    this.profiles = const [],
    this.addProfileStatus = UsecaseStatus.idle,
    this.addProfileFailure,
  });

  final UsecaseStatus profilesStatus;
  final Failure? profilesFailure;
  final List<Profile> profiles;

  final UsecaseStatus addProfileStatus;
  final Failure? addProfileFailure;

  ProfileState copyWith({
    UsecaseStatus? profilesStatus,
    Failure? profilesFailure,
    List<Profile>? profiles,
    UsecaseStatus? addProfileStatus,
    Failure? addProfileFailure,
  }) {
    return ProfileState(
      profilesStatus: profilesStatus ?? this.profilesStatus,
      profilesFailure: profilesFailure ?? this.profilesFailure,
      profiles: profiles ?? this.profiles,
      addProfileStatus: addProfileStatus ?? this.addProfileStatus,
      addProfileFailure: addProfileFailure ?? this.addProfileFailure,
    );
  }

  @override
  String toString() {
    return 'ProfileState(profilesStatus: $profilesStatus, profilesFailure: $profilesFailure, profiles: $profiles, addProfileStatus: $addProfileStatus, addProfileFailure: $addProfileFailure)';
  }

  @override
  List<Object?> get props => [
        profilesStatus,
        profilesFailure,
        profiles,
        addProfileStatus,
        addProfileFailure,
      ];
}
