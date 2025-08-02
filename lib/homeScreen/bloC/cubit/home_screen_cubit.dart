import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  // Key = title of the card, value = isSelected
  final Map<String, bool> _cardStates = {
    'All Notes': false,
    'Favourites': false,
    'Hidden': false,
    'Trash': false,
  };

  HomeScreenCubit() : super(HomeScreenInitial());

  void toggleCard(String title) {
    _cardStates[title] = !(_cardStates[title] ?? false);
    emit(CategoryColorsUpdated({..._cardStates}));
  }

  bool getCardState(String title) => _cardStates[title] ?? false;
}
