import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<int> {
  OnboardingCubit() : super(0);
  PageController controller = PageController();
  void ChangePage(int index) {
    emit(index);
  }

  void NextPage() {
    if (controller.hasClients && state < 2) {
      controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      emit(state + 1);
    }
  }

  void PreviousPage() {
    if (controller.hasClients && state > 0) {
      controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      emit(state - 1);
    }
  }

  void skipToLast() {
    if (controller.hasClients) {
      controller.jumpToPage(2);
    }
  }
}
