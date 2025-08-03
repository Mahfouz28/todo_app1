import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app1/auth/login/model/usermodel.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
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
  void getUserData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final userModel = UserModel(
      id: pref.getInt('userId') ?? 0,
      username: pref.getString('username') ?? '',
      email: pref.getString('email') ?? '',
      created: DateTime.now(),
    );

    emit(
      UserDataLoaded(userModel),
    ); 
  }
}
