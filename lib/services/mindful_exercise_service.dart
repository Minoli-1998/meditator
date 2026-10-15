import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meditator/models/mindfull_exercise_model.dart';

class MindfulExerciseService {
  // initialize hive box
  final mindfulExerciseBox = Hive.box('mindfulness_data');

  // add new exercise
  Future<void> addMindfullExercise(
    MindfulnessExercise exercise,
    BuildContext context,
  ) async {
    try {
      // get all exercises from box
      final dynamic allExercisesJson = mindfulExerciseBox.get(
        'mindfulness_data',
      );

      List<Map<String, dynamic>> allExercises = [];

      // converting
      if (allExercisesJson != null && allExercisesJson is List) {
        allExercises = List<Map<String, dynamic>>.from(
          allExercisesJson.map((exercise) {
            return Map<String, dynamic>.from(exercise);
          }),
        );
      }

      allExercises.add(exercise.toJSON());

      // save in hive
      await mindfulExerciseBox.put('mindfulness_data', allExercises);

      // displaying the message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Sleep exercise saved"),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } catch (error) {
      print("Service error : $error");

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error saving data"),
            duration: Duration(seconds: 1),
          ),
        );
      }
    }
  }
}
