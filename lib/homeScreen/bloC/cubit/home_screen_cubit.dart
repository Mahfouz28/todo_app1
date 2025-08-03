import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app1/homeScreen/model/note_model.dart';
import 'package:todo_app1/homeScreen/repo/note_repo.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  final Map<String, bool> _cardStates = {
    'All Notes': false,
    'Favourites': false,
    'Hidden': false,
    'Trash': false,
  };

  HomeScreenCubit() : super(HomeScreenInitial()) {
    getUserData();
    getNotes();
  }

  final NoteRepo noteRepo = NoteRepo();

  // USER INFO
  int? userId;
  String? userName;
  String? email;

  // NOTES
  final List<NoteModel> _notes = [];
  List<NoteModel> get notes => _notes;

  void toggleCard(String title) {
    _cardStates[title] = !(_cardStates[title] ?? false);
    emit(CategoryColorsUpdated({..._cardStates}));
  }

  bool getCardState(String title) => _cardStates[title] ?? false;

  void getUserData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    userId = pref.getInt("userId");
    email = pref.getString("email");
    userName = pref.getString("username");
  }

  Future<void> getNotes() async {
    try {
      final fetchedNotes = await noteRepo.getAllNotes();
      _notes
        ..clear()
        ..addAll(fetchedNotes);
      emit(NotesFetched()); 
    } catch (e) {
      print("Error fetching notes: $e");
    }
  }
}
