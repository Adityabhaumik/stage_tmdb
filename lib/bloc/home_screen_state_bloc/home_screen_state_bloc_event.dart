part of 'home_screen_state_bloc_bloc.dart';

sealed class HomeScreenStateBlocEvent extends Equatable {
  const HomeScreenStateBlocEvent();

  @override
  List<Object> get props => [];
}

class ToggleHomeScreenLoadingState extends HomeScreenStateBlocEvent {
  final bool isLoading;

  const ToggleHomeScreenLoadingState({
    required this.isLoading,
  });

  @override
  List<Object> get props => [isLoading];

  @override
  String toString() => 'ToggleHomeScreenLoadingState(isLoading: $isLoading)';
}
