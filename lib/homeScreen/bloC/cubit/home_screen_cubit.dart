import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  bool _isColored = false;

  HomeScreenCubit() : super(HomeScreenInitial());

  void toggleColor() {
    _isColored = !_isColored;
    emit(HomeScreenColorChanged(_isColored));
  }
}
