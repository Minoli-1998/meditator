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

  // method to get all exercises
  // need to get List of MindfulnessExercises so the return type is List<MindfulnessExercise>
  List<MindfulnessExercise> getMindfulnessExercises() {
    try {
      // get all data in Mindfulness box in hive
      final dynamic allExercises = mindfulExerciseBox.get('mindfulness_data');

      // checking if the data is null and if the data is a list
      if (allExercises != null && allExercises is List) {
        return allExercises.map((mindfulnessExercise) {
          if (mindfulnessExercise is Map<String, dynamic>) {
            return MindfulnessExercise.fromJson(mindfulnessExercise);
          } else {
            return MindfulnessExercise.fromJson(
              Map<String, dynamic>.from(mindfulnessExercise),
            );
          }
        }).toList();
      } else {
        return [];
      }
    } catch (error) {
      print("Service error : $error");
      return [];
    }
  }

  // methode to delete an exersice
  Future<void> deleteMindfulnessExersice(
    MindfulnessExercise exercise,
    BuildContext context,
  ) async {
    try {
      // get all the exercises from the box
      final dynamic allMindfulnessExersicesJson = await mindfulExerciseBox.get(
        'mindfulness_data',
      );

      List<Map<String, dynamic>> allMindfulnessExercises = [];

      // check if the data is null and a list
      if (allMindfulnessExersicesJson != null &&
          allMindfulnessExersicesJson is List) {
        // converting json data list into List<Map<String, dynamic>>
        allMindfulnessExercises = List<Map<String, dynamic>>.from(
          allMindfulnessExersicesJson.map((exercise) {
            return Map<String, dynamic>.from(exercise);
          }),
        );

        // removing exercise from the list if the name and category are matched
        allMindfulnessExercises.removeWhere((element) {
          MindfulnessExercise currentExercise = MindfulnessExercise.fromJson(
            Map<String, dynamic>.from(element),
          );

          return currentExercise.name == exercise.name &&
              currentExercise.category == exercise.category;
        });

        await mindfulExerciseBox.put(
          'mindfulness_data',
          allMindfulnessExercises,
        );

        // display a message after deleting
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Exersice deleted"),
              duration: Duration(seconds: 1),
            ),
          );
        }
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error in deleting exercise"),
            duration: Duration(seconds: 1),
          ),
        );
      }
    }
  }
}
