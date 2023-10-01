class PedometerState {
  String pedometerStepCount;

  PedometerState({this.pedometerStepCount = 'unknown step count'});

  PedometerState copyWith(String? pedometerStepCount) {
    return PedometerState(
      pedometerStepCount: pedometerStepCount ?? this.pedometerStepCount,
    );
  }
}
