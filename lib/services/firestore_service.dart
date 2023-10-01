import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:step_counter/models/achievement.dart';

class FirestoreService {
  final _achievementsCollection =
      FirebaseFirestore.instance.collection('achievements');

  Future<Achievement?> fetchAchievementByUserLvl(int lvl) async {
    final achievementSnapshot = await _achievementsCollection.get();
    Achievement? achievement;
    achievementSnapshot.docs.forEach((doc) {
      if (doc.id == lvl.toString()) {
        achievement = Achievement.fromSnapshot(doc);
      }
    });
    return achievement;
  }

  Future<List<Achievement>> fetchAchievementList() async {
    List<Achievement> res = [];

    final achievementSnapshot = await _achievementsCollection.get();

    achievementSnapshot.docs.forEach((doc) {
      res.add(Achievement.fromSnapshot(doc));
    });

    return res;
  }
}
