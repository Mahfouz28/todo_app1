import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app1/core/constanis/endpoint_constants%20(1).dart';
import 'package:todo_app1/homeScreen/model/note_model.dart';
import 'package:todo_app1/core/network/dio_client.dart';
import 'package:todo_app1/homeScreen/repo/note_addrepo.dart';
import 'package:todo_app1/homeScreen/repo/note_repo.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  final Map<String, bool> _cardStates = {
    'All Notes': false,
    'Favourites': false,
    'Hidden': false,
    'Trash': false,
  };

  final NoteRepo noteRepo = NoteRepo();
  final NoteAddRepo noteAddRepo = NoteAddRepo();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  HomeScreenCubit() : super(HomeScreenInitial()) {
    getUserData();
  }

  int? userId;
  String? userName;
  String? email;

  final List<NoteModel> _notes = [];
  List<NoteModel> get notes => _notes;

  bool getCardState(String title) => _cardStates[title] ?? false;

  void toggleCard(String title) {
    _cardStates[title] = !(_cardStates[title] ?? false);
    emit(CategoryColorsUpdated({..._cardStates}));
  }

  Future<void> getUserData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    userId = pref.getInt("userId");
    email = pref.getString("email");
    userName = pref.getString("username");

    if (userId != null && userName != null && email != null) {
      emit(UserDataLoaded(userId!, userName!, email!));
      await getNotes();
    } else {
      emit(HomeScreenError("User data not found"));
    }
  }

  Future<void> getNotes() async {
    if (userId == null) {
      emit(HomeScreenError("User ID is null"));
      return;
    }

    emit(NotesLoading());

    try {
      final dio = DioClient();
      final response = await dio.get(
        EndpointConstants.getAll,
        queryParameters: {"users_id": userId.toString()},
      );

      if (response.statusCode == 200 && response.data['status'] == "success") {
        _notes.clear();
        final List<dynamic> data = response.data['data'];
        _notes.addAll(data.map((json) => NoteModel.fromJson(json)).toList());
        emit(NotesFetched());
      } else {
        emit(HomeScreenError(
            'Failed to fetch notes: ${response.data['message'] ?? 'Unknown error'}'));
      }
    } catch (e) {
      emit(HomeScreenError('Error while fetching notes: $e'));
    }
  }

  Future<void> refreshNotes() async {
    await getNotes();
  }

  /// This method adds the note directly and sends it to the backend
  Future<void> addNoteFromControllers() async {
    if (userId == null) {
      emit(HomeScreenError("User ID is null"));
      return;
    }

    final newNote = NoteModel(
      noteId: DateTime.now().millisecondsSinceEpoch,
      title: titleController.text,
      content: contentController.text,
      usersId: userId!,
      createdAt: DateTime.now(),
    );

    // Optimistic update: show the note immediately
    _notes.add(newNote);
    emit(NotesFetched());

    // Clear the controllers
    titleController.clear();
    contentController.clear();

    // Then try sending it to the backend
    try {
      await noteAddRepo.addNote(
        newNote.title!,
        newNote.content!,
        userId.toString(),
      );
    } catch (e) {
      emit(HomeScreenError("Error adding note to server: $e"));
    }
  }
}
