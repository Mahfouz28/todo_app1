part of 'home_screen_cubit.dart';

sealed class HomeScreenState extends Equatable {
  const HomeScreenState();

  @override
  List<Object> get props => [];
}

final class HomeScreenInitial extends HomeScreenState {}

final class HomeScreenColorChanged extends HomeScreenState {
  final bool isColored;

  const HomeScreenColorChanged(this.isColored);

  @override
  List<Object> get props => [isColored];
}
