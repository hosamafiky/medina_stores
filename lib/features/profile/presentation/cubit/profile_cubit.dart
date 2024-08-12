part of '../presentation_imports.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required this.getProfilesUsecase,
    required this.addProfileUsecase,
  }) : super(const ProfileState());

  final GetProfilesUsecase getProfilesUsecase;
  final AddProfileUsecase addProfileUsecase;

  Future<void> getProfiles() async {
    emit(state.copyWith(profilesStatus: UsecaseStatus.running));
    final result = await getProfilesUsecase();
    result.fold(
      (failure) {
        emit(state.copyWith(profilesStatus: UsecaseStatus.error, profilesFailure: failure));
      },
      (profiles) {
        emit(state.copyWith(profilesStatus: UsecaseStatus.completed, profiles: profiles.data));
      },
    );
  }

  Future<void> addProfile(AddProfileParams params) async {
    emit(state.copyWith(addProfileStatus: UsecaseStatus.running));
    final result = await addProfileUsecase(params);
    result.fold(
      (failure) {
        emit(state.copyWith(addProfileStatus: UsecaseStatus.error, addProfileFailure: failure));
      },
      (response) {
        final oldProfiles = List<Profile>.from(state.profiles);
        emit(state.copyWith(addProfileStatus: UsecaseStatus.completed, profiles: oldProfiles..insert(0, response.data!)));
      },
    );
  }
}
