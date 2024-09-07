part of '../presentation_imports.dart';

class NewTabState extends Equatable {
  const NewTabState({
    this.newTabsStatus = UsecaseStatus.idle,
    this.newTabsFailure,
    this.newTabs = const [],
    this.addNewTabStatus = UsecaseStatus.idle,
    this.addNewTabFailure,
  });

  final UsecaseStatus newTabsStatus;
  final Failure? newTabsFailure;
  final List<NewTab> newTabs;

  final UsecaseStatus addNewTabStatus;
  final Failure? addNewTabFailure;

  NewTabState copyWith({
    UsecaseStatus? newTabsStatus,
    Failure? newTabsFailure,
    List<NewTab>? newTabs,
    UsecaseStatus? addNewTabStatus,
    Failure? addNewTabFailure,
  }) {
    return NewTabState(
      newTabsStatus: newTabsStatus ?? this.newTabsStatus,
      newTabsFailure: newTabsFailure ?? this.newTabsFailure,
      newTabs: newTabs ?? this.newTabs,
      addNewTabStatus: addNewTabStatus ?? this.addNewTabStatus,
      addNewTabFailure: addNewTabFailure ?? this.addNewTabFailure,
    );
  }

  @override
  String toString() {
    return 'NewTabState(newTabsStatus: $newTabsStatus, newTabsFailure: $newTabsFailure, newTabs: $newTabs, addNewTabStatus: $addNewTabStatus, addNewTabFailure: $addNewTabFailure)';
  }

  @override
  List<Object?> get props => [
        newTabsStatus,
        newTabsFailure,
        newTabs,
        addNewTabStatus,
        addNewTabFailure,
      ];
}
