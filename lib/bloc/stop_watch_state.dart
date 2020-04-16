import 'package:equatable/equatable.dart';
import 'package:stop_watch/models/stop_watch_duration.dart';

abstract class StopWatchState extends Equatable {
  final StopWatchDuration duration;

  const StopWatchState(this.duration);

  @override
  List<Object> get props => [duration];
}

class Ready extends StopWatchState {
  const Ready() : super(const StopWatchDuration(0));
}

class Paused extends StopWatchState {
  const Paused(StopWatchDuration duration) : super(duration);

  @override
  String toString() => 'Paused { duration: ${duration.seconds} }';
}

class Running extends StopWatchState {
  const Running(StopWatchDuration duration) : super(duration);

  @override
  String toString() => 'Running { duration: ${duration.seconds} }';
}
