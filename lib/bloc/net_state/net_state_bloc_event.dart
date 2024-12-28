part of 'net_state_bloc_bloc.dart';

sealed class NetStateBlocEvent extends Equatable {
  const NetStateBlocEvent();

  @override
  List<Object> get props => [];
}

class CheckNetStatusEvent extends NetStateBlocEvent {}
