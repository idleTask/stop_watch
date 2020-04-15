import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../data/stop_watch_ticker.dart';

import './bloc.dart';

class StopWatchBloc extends Bloc<StopWatchEvent, StopWatchState> {
  final StopWatchTicker _ticker;

  StreamSubscription<int> _tickerSubscription;

  StopWatchBloc({@required StopWatchTicker ticker})
      : assert(ticker != null),
        _ticker = ticker;

  @override
  StopWatchState get initialState => Ready();

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
    } else if (event is Reset) {
      yield* _mapResetToState(event);
    } else if (event is Tick) {
      yield* _mapTickToState(event);
    }
  }

  Stream<StopWatchState> _mapStartToState(Start start) async* {
    yield Running(state.duration);
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick()
        .listen((duration) => add(Tick(duration: duration)));
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
    yield Running(tick.duration);
  }
}
