import 'package:equatable/equatable.dart';

abstract class StopWatchState extends Equatable {
  final int duration;

  const StopWatchState(this.duration);

  @override
  List<Object> get props => [duration];
}

class Ready extends StopWatchState {
  const Ready() : super(0);
}

class Paused extends StopWatchState {
  const Paused(int duration) : super(duration);

  @override
  String toString() => 'Paused { duration: $duration }';
}

class Running extends StopWatchState {
  const Running(int duration) : super(duration);

  @override
  String toString() => 'Running { duration: $duration }';
}
