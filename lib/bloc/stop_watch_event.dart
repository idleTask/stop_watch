import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class StopWatchEvent extends Equatable {
  const StopWatchEvent();

  @override
  List<Object> get props => [];
}

class Start extends StopWatchEvent {}

class Pause extends StopWatchEvent {}

class Tick extends StopWatchEvent {
  final int duration;

  const Tick({@required this.duration});

  @override
  List<Object> get props => [duration];

  @override
  String toString() => "Tick { duration: $duration }";
}

class Reset extends StopWatchEvent {}
