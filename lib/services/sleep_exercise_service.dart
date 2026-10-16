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

  // method to get all sleep exercises in local storage
  List<SleepExercise> getAllSleepExercises() {
    try {
      // get all exersices from the Hive box
      final dynamic allExersices = sleepExerciseBox.get('sleep_data');
      List<SleepExercise> exersicesList = [];

      // checking if it's null and a list
      if (allExersices != null && allExersices is List) {
        exersicesList = allExersices.map((exercise) {
          if (exercise is Map<String, dynamic>) {
            return SleepExercise.fromJson(exercise);
          } else {
            return SleepExercise.fromJson(Map<String, dynamic>.from(exercise));
          }
        }).toList();

        return exersicesList;
      } else {
        return [];
      }
    } catch (error) {
      print("Service error in getting all sleep exercises : $error");
      return [];
    }
  }

  // method to delete an exersice
  Future<void> deleteSleepExersice(
    SleepExercise exercise,
    BuildContext context,
  ) async {
    try {
      // get all data
      final dynamic allExersices = sleepExerciseBox.get('sleep_data');
      allExersices.remove(exercise);
      await sleepExerciseBox.put('sleep_data', allExersices);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Sleep exersice deleted"),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error in deleting exersice"),
            duration: Duration(seconds: 1),
          ),
        );
      }
    }
  }
}
