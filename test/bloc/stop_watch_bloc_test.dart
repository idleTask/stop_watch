import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:stop_watch/bloc/bloc.dart';
import 'package:stop_watch/data/stop_watch_ticker.dart';
import 'package:stop_watch/models/stop_watch_duration.dart';
import 'package:test/test.dart';

class MockStopWatchTicker extends Mock implements StopWatchTicker {}

void main() {
  StopWatchBloc bloc;
  MockStopWatchTicker mockStopWatchTicker;

  setUp(() {
    mockStopWatchTicker = MockStopWatchTicker();
    bloc = StopWatchBloc(ticker: mockStopWatchTicker);
  });

  group('StopWatchBloc', () {
    blocTest<StopWatchBloc, StopWatchEvent, StopWatchState>(
      'emits [Running()] when Start() event is added',
      build: () async {
        return bloc;
      },
      act: (stopWatchBloc) async {
        stopWatchBloc.add(Start());
      },
      expect: <StopWatchState>[const Running(StopWatchDuration(0))],
    );

    blocTest<StopWatchBloc, StopWatchEvent, StopWatchState>(
        'emits [Running()] when Start() event is added',
        build: () async {
          when(mockStopWatchTicker.tick()).thenAnswer(
              (_) => Stream.periodic(const Duration(seconds: 1), (x) => x + 1));
          return bloc;
        },
        act: (stopWatchBloc) async {
          stopWatchBloc.add(Start());
        },
        expect: <StopWatchState>[const Running(StopWatchDuration(0))],
        verify: (bloc1) async {
          verify(mockStopWatchTicker.tick().listen((event) {
            bloc1.add(Tick(duration: event));
          })).called(1);
        });

    test('subscribte to ticker stream', () {
      bloc.add(Start());
    });
  });
}
