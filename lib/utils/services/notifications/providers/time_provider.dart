import 'dart:async';

abstract class TimerProvider {
  Timer createTimer(Duration duration, Function() callback);
  void cancel(Timer timer);
}

class RealTimerProvider implements TimerProvider {
  @override
  Timer createTimer(Duration duration, Function() callback) {
    return Timer(duration, callback);
  }

  @override
  void cancel(Timer timer) {
    timer.cancel();
  }
}
