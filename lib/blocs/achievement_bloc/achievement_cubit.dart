import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_counter/models/achievement.dart';
import 'package:step_counter/services/firestore_service.dart';

class AchievementCubit extends Cubit<Achievement?> {
  final FirestoreService firestoreService = FirestoreService();

  AchievementCubit() : super(null);

  Future<void> getAchievement(int stepCount) async {
    if (stepCount >= 0 && stepCount <= 10) {
      emit(await firestoreService.fetchAchievementByUserLvl(1));
    } else if (stepCount >= 11 && stepCount <= 20) {
      emit(await firestoreService.fetchAchievementByUserLvl(1));
    } else {
      emit(await firestoreService.fetchAchievementByUserLvl(1));
    }
  }
}
