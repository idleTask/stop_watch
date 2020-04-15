abstract class StopWatchTicker {
  Stream<int> tick();
}

class StopWatchTickerImpl implements StopWatchTicker {
  @override
  Stream<int> tick() {
    return Stream.periodic(const Duration(seconds: 1), (x) => x + 1);
  }
}