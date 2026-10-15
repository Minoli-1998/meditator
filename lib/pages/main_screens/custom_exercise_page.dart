import 'package:flutter/material.dart';
import 'package:meditator/widgets/tabs/meditation_tab.dart';
import 'package:meditator/widgets/tabs/mindfull_exercise_tab.dart';
import 'package:meditator/widgets/tabs/sleep_exercise_tab.dart';

class CustomExercisePage extends StatelessWidget {
  const CustomExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Your Exercises"),
          bottom: TabBar(
            tabs: [
              Tab(text: "Meditations"),
              Tab(text: "Sleep Exercises"),
              Tab(text: "Mindfull Exercises"),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            MeditationTab(),
            SleepExerciseTab(),
            MindfullExerciseTab(),
          ],
        ),
      ),
    );
  }
}
