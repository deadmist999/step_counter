import 'package:flutter/material.dart';

import 'package:step_counter/screens/achievement_screen/components/achievement_item.dart';
import 'package:step_counter/screens/components/loading_indicator.dart';
import 'package:step_counter/services/firestore_service.dart';

class AchievementScreen extends StatelessWidget {
  const AchievementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: FirestoreService().fetchAchievementList(),
        builder: (context, snapshot) {
          return snapshot.data == null
              ? const LoadingIndicator()
              : GridView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return AchievementItem(
                      achievement: snapshot.data![index],
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 50,
                    childAspectRatio: 3,
                  ),
                );
        },
      ),
    );
  }
}
