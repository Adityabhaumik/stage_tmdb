part of 'home_screen_state_bloc_bloc.dart';

class HomeScreenStateBlocState extends Equatable {
  bool isLoading;
  HomeScreenStateBlocState({
    required this.isLoading,
  });

  factory HomeScreenStateBlocState.initial() {
    return HomeScreenStateBlocState(isLoading: false);
  }

  HomeScreenStateBlocState copyWith({
    bool? isLoading,
  }) {
    return HomeScreenStateBlocState(
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [isLoading];

  @override
  bool get stringify => true;
}
