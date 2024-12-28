part of 'net_state_bloc_bloc.dart';

enum NetState { available, notAvailable, loading }

class NetStateBlocState extends Equatable {
  final NetState state;
  const NetStateBlocState({
    required this.state,
  });

  factory NetStateBlocState.intial() {
    return const NetStateBlocState(state: NetState.loading);
  }
  @override
  List<Object> get props => [state];

  NetStateBlocState copyWith({
    NetState? state,
  }) {
    return NetStateBlocState(
      state: state ?? this.state,
    );
  }

  @override
  bool get stringify => true;
}
