import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meditator/models/sleep_exercise_model.dart';

class SleepExerciseService {
  // iniitialize Hive box
  final sleepExerciseBox = Hive.box('sleep_data');

  // add sleep exercise to box
  Future<void> addSleepExercise(
    SleepExercise sleepExercise,
    BuildContext context,
  ) async {
    try {
      final dynamic allExercisesJson = sleepExerciseBox.get('sleep_data');

      List<Map<String, dynamic>> allExercises = [];

      if (allExercisesJson != null && allExercisesJson is List) {
        allExercises = List<Map<String, dynamic>>.from(
          allExercisesJson.map((sleepExercise) {
            return Map<String, dynamic>.from(sleepExercise);
          }),
        );
      }

      allExercises.add(sleepExercise.toJson());

      // save in Hive
      sleepExerciseBox.put('sleep_data', allExercises);

      // display data
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Sleep exercise saved"),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error in saving sleep exercise"),
            duration: Duration(seconds: 1),
          ),
        );
      }
    }
  }
}
