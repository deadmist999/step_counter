import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:step_counter/blocs/pedometer_cubit/pedometer_state.dart';

class PedometerCubit extends Cubit<PedometerState> {
  StreamSubscription<StepCount>? _stepCountStream;

  PedometerCubit(this._stepCountStream) : super(PedometerState()) {
    Permission.activityRecognition.request().whenComplete(() {
      _stepCountStream = Pedometer.stepCountStream.listen(_onStepCount)
        ..onError(_onStepCountError);
    });
  }

  StreamSubscription<StepCount>? get stepCountStream => _stepCountStream;

  void _onStepCount(StepCount event) {
    emit(state.copyWith(event.steps.toString()));
  }

  void _onStepCountError(_) {
    emit(state.copyWith('Step Count not available'));
  }

  @override
  Future<void> close() {
    _stepCountStream?.cancel();
    return super.close();
  }
}
