import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_counter/blocs/achievement_bloc/achievement_cubit.dart';
import 'package:step_counter/blocs/pedometer_cubit/pedometer_cubit.dart';
import 'package:step_counter/models/achievement.dart';
import 'package:step_counter/screens/achievement_screen/achievement_screen.dart';
import 'package:step_counter/screens/components/loading_indicator.dart';

class AchievementWidget extends StatelessWidget {
  const AchievementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AchievementCubit, Achievement?>(
      builder: (context, state) {
        context.read<AchievementCubit>().getAchievement(int.tryParse(
                context.read<PedometerCubit>().state.pedometerStepCount) ??
            0);

        if (state == null) {
          return const LoadingIndicator();
        }
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AchievementScreen(),
            ),
          ),
          child: SizedBox(
            child: Row(
              children: [
                Image.network(
                  state.imageUrl,
                  scale: 2,
                  fit: BoxFit.scaleDown,
                ),
                Text(state.name),
              ],
            ),
          ),
        );
      },
    );
  }
}
