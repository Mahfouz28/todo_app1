import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app1/core/constanis/endpoint_constants%20(1).dart';
import 'package:todo_app1/homeScreen/model/note_model.dart';
import 'package:todo_app1/core/network/dio_client.dart';
import 'package:todo_app1/homeScreen/repo/delete_repo.dart';
import 'package:todo_app1/homeScreen/repo/edit_repo.dart';
import 'package:todo_app1/homeScreen/repo/note_addrepo.dart';
import 'package:todo_app1/homeScreen/repo/note_repo.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  // UI state for the category cards (selected/unselected)
  final Map<String, bool> _cardStates = {
    'All Notes': false,
    'Favourites': false,
    'Hidden': false,
    'Trash': false,
  };

  // Repositories for interacting with the backend
  final NoteRepo noteRepo = NoteRepo();
  final NoteAddRepo noteAddRepo = NoteAddRepo();
  final DeleteRepo deleteRepo = DeleteRepo();

  final EditRepo editRepo = EditRepo();
  // Controllers for adding notes
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  HomeScreenCubit() : super(HomeScreenInitial()) {
    getUserData(); // Load user data and fetch notes on startup
  }

  // User info
  int? userId;
  String? userName;
  String? email;

  // List to hold notes in memory
  final List<NoteModel> _notes = [];
  List<NoteModel> get notes => _notes;

  // Returns current state (selected/unselected) for a given category card
  bool getCardState(String title) => _cardStates[title] ?? false;

  // Toggles the UI selection state of a category card
  void toggleCard(String title) {
    _cardStates[title] = !(_cardStates[title] ?? false);
    emit(CategoryColorsUpdated({..._cardStates}));
  }

  // Loads user data from SharedPreferences
  Future<void> getUserData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    userId = pref.getInt("userId");
    email = pref.getString("email");
    userName = pref.getString("username");

    if (userId != null && userName != null && email != null) {
      emit(UserDataLoaded(userId!, userName!, email!));
      await getNotes(); // Fetch notes after loading user info
    } else {
      emit(HomeScreenError("User data not found"));
    }
  }

  // Fetches all notes for the current user from the backend
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
        _notes.clear(); // Clear old notes
        final List<dynamic> data = response.data['data'];
        _notes.addAll(data.map((json) => NoteModel.fromJson(json)).toList());
        emit(NotesFetched()); // Notify UI to refresh
      } else {
        emit(
          HomeScreenError(
            'Failed to fetch notes: ${response.data['message'] ?? 'Unknown error'}',
          ),
        );
      }
    } catch (e) {
      emit(HomeScreenError('Error while fetching notes: $e'));
    }
  }

  // Refreshes notes (used after adding new note or returning from another screen)
  Future<void> refreshNotes() async {
    await getNotes();
  }

  /// Adds a new note using current title and content controllers.
  /// Performs optimistic UI update by adding the note locally before confirming with backend.
  Future<void> addNoteFromControllers() async {
    if (userId == null) {
      emit(HomeScreenError("User ID is null"));
      return;
    }

    final newNote = NoteModel(
      noteId: DateTime.now().millisecondsSinceEpoch, // Temporary unique ID
      title: titleController.text,
      content: contentController.text,
      usersId: userId!,
      createdAt: DateTime.now(),
    );

    // Optimistic update: add note locally and show immediately in UI
    _notes.add(newNote);
    emit(NotesFetched());

    // Clear form fields
    titleController.clear();
    contentController.clear();

    // Send to server
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

  // Delete a note
  Future<void> deleteNote(String noteId) async {
    try {
      await deleteRepo.deleteNote(noteId);

      _notes.removeWhere((note) => note.noteId.toString() == noteId);

      emit(NotesFetched());
    } catch (e) {
      emit(NoteError("Failed to delete note: $e"));
    }
  }

  void removeNoteFromList(String noteId) {
    notes.removeWhere((note) => note.noteId.toString() == noteId);
    emit(NotesFetched());
  }

  // edit notes
  Future<void> editNote(String noteId, String title, String content) async {
    try {
      await editRepo.editNote(noteId, title, content);
      emit(NoteUpdatedSuccess());

      await getNotes();
    } catch (e) {
      emit(NoteUpdatedFailure(e.toString()));
    }
  }
}
