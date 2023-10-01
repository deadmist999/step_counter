import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:step_counter/blocs/auth_bloc/auth_bloc.dart';
import 'package:step_counter/blocs/pedometer_cubit/pedometer_cubit.dart';
import 'package:step_counter/blocs/pedometer_cubit/pedometer_state.dart';
import 'package:step_counter/screens/home_screen/components/achievement_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => context.read<AuthBloc>().add(LogoutEvent()),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<PedometerCubit, PedometerState>(
            builder: (context, state) {
              return Text(state.pedometerStepCount);
            },
          ),
          const AchievementWidget(),
        ],
      ),
    );
  }
}
