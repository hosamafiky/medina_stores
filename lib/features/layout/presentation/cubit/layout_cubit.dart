part of '../presentation_imports.dart';

class LayoutCubit extends Cubit<int> {
  LayoutCubit() : super(0);

  void changeIndex(int index) => emit(index);
}
