part of 'home_screen_cubit.dart';

sealed class HomeScreenState extends Equatable {
  const HomeScreenState();

  @override
  List<Object> get props => [];
}

final class HomeScreenInitial extends HomeScreenState {}

final class CategoryColorsUpdated extends HomeScreenState {
  final Map<String, bool> cardStates;

  const CategoryColorsUpdated(this.cardStates);

  @override
  List<Object> get props => [cardStates];
}

final class NotesFetched extends HomeScreenState {}
