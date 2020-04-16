import 'package:meta/meta.dart';

@immutable
class StopWatchDuration {
  final int seconds;

  const StopWatchDuration(this.seconds);

  String get hourStr =>
      ((seconds / 3600) % 3600).floor().toString().padLeft(2, '0');

  String get minutesStr =>
      ((seconds / 60) % 60).floor().toString().padLeft(2, '0');

  String get secondsStr => (seconds % 60).floor().toString().padLeft(2, '0');
}
