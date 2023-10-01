import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_counter/blocs/achievement_bloc/achievement_cubit.dart';

import 'package:step_counter/models/achievement.dart';
import 'package:step_counter/screens/components/app_dimensions.dart';

class AchievementItem extends StatelessWidget {
  final Achievement achievement;

  const AchievementItem({super.key, required this.achievement});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: AppDimensions.borderRadius8,
        color: Colors.black12,
        border: context.read<AchievementCubit>().state?.name == achievement.name
            ? Border.all(color: Colors.green)
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            achievement.imageUrl,
            scale: 3,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(achievement.name),
              Text(achievement.description),
            ],
          ),
        ],
      ),
    );
  }
}
