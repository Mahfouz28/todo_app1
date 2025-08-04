part of 'home_screen_cubit.dart';

/// Base state class for the HomeScreenCubit
abstract class HomeScreenState extends Equatable {
  const HomeScreenState();

  @override
  List<Object?> get props => [];
}

/// Initial state when the screen loads for the first time
class HomeScreenInitial extends HomeScreenState {}

/// State used while notes are being fetched
class NotesLoading extends HomeScreenState {}

/// State emitted when notes have been successfully fetched
class NotesFetched extends HomeScreenState {}

/// State to track category/card toggle updates (e.g., Favourites, Trash, etc.)
class CategoryColorsUpdated extends HomeScreenState {
  final Map<String, bool> updatedStates;

  const CategoryColorsUpdated(this.updatedStates);

  @override
  List<Object?> get props => [updatedStates];
}

/// State emitted when there's an error on the screen
class HomeScreenError extends HomeScreenState {
  final String message;

  const HomeScreenError(this.message);

  @override
  List<Object?> get props => [message];
}

/// State when user data has been successfully loaded
class UserDataLoaded extends HomeScreenState {
  final int userId;
  final String username;
  final String email;

  const UserDataLoaded(this.userId, this.username, this.email);

  @override
  List<Object?> get props => [userId, username, email];
}
