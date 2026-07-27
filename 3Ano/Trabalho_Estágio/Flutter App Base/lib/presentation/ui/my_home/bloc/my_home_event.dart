part of 'my_home_bloc.dart';

@immutable
abstract class MyHomeEvent extends Equatable {
  const MyHomeEvent();
}

class LoadMyHomeEvent extends MyHomeEvent {
  const LoadMyHomeEvent();

  @override
  List<Object> get props => [];
}

class IncrementHomeEvent extends MyHomeEvent {
  const IncrementHomeEvent();

  @override
  List<Object> get props => [];
}

class SubtractHomeEvent extends MyHomeEvent {
  const SubtractHomeEvent();

  @override
  List<Object> get props => [];
}

class ResetHomeEvent extends MyHomeEvent {
  const ResetHomeEvent();

  @override
  List<Object> get props => [];
}
