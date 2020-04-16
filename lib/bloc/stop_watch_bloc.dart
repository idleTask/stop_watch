import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stop_watch/models/stop_watch_duration.dart';
import '../stopwatch.dart';

class StopWatchBloc extends Bloc<StopWatchEvent, StopWatchState> {
  final StopWatchTicker _ticker;

  StreamSubscription<int> _tickerSubscription;

  StopWatchBloc({@required StopWatchTicker ticker})
      : assert(ticker != null),
        _ticker = ticker;

  @override
  StopWatchState get initialState => const Ready();

  @override
  void onTransition(Transition<StopWatchEvent, StopWatchState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<StopWatchState> mapEventToState(
    StopWatchEvent event,
  ) async* {
    if (event is Start) {
      yield* _mapStartToState(event);
    } else if (event is Pause) {
      yield* _mapPauseToState(event);
    } else if (event is Resume) {
      yield* _mapResumeToState(event);
    } else if (event is Reset) {
      yield* _mapResetToState(event);
    } else if (event is Tick) {
      yield* _mapTickToState(event);
    }
  }

  Stream<StopWatchState> _mapStartToState(Start start) async* {
    yield Running(state.duration);
    _tickerSubscription =
        _ticker.tick().listen((duration) {
          add(Tick(duration: duration));
        });
  }

  Stream<StopWatchState> _mapPauseToState(Pause pause) async* {
    if (state is Running) {
      _tickerSubscription?.pause();
      yield Paused(state.duration);
    }
  }

  Stream<StopWatchState> _mapResetToState(Reset reset) async* {
    _tickerSubscription?.cancel();
    yield const Ready();
  }

  Stream<StopWatchState> _mapTickToState(Tick tick) async* {
    yield Running(StopWatchDuration(tick.duration));
  }

  Stream<StopWatchState> _mapResumeToState(Resume resume) async* {
    if (state is Paused) {
      _tickerSubscription?.resume();
      yield Running(state.duration);
    }
  }
}
