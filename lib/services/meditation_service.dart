import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meditator/models/meditation_exercise_model.dart';

class MeditationService {
  var meditationBox = Hive.box('meditation_data');

  // method to add new data
  Future<void> addMeditation(
    MeditationExercise meditation,
    BuildContext context,
  ) async {
    try {
      // get data from the box
      final dynamic allMeditations = meditationBox.get("meditation_data");

      // create a list of json data - type of json data is Map<String, dynamic>
      List<Map<String, dynamic>> meditationList = [];

      // converting allMeditations to a List that the type is Map<String, dynamic> and mapping through all data of allMeditation to convert one by one to Map<String,dynamic> type
      if (allMeditations != null && allMeditations is List) {
        meditationList = List<Map<String, dynamic>>.from(
          allMeditations.map(
            (meditation) => Map<String, dynamic>.from(meditation),
          ),
        );
      }

      // add to the list
      // the type of meditation is dynamic have to convert it to json
      meditationList.add(meditation.toJson());

      // save in Hive
      await meditationBox.put("meditation_data", meditationList);

      // dusplaying a message after saving data
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Meditation saved"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        print("Service error : $error");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error in saving meditation exercise"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  // method to get meditation data
  List<MeditationExercise> getAllMeditations() {
    try {
      // get all exercises from the box
      final dynamic allExercisesJson = meditationBox.get('meditation_data');

      if (allExercisesJson != null && allExercisesJson is List) {
        return allExercisesJson.map((meditation) {
          if (meditation is Map<String, dynamic>) {
            return MeditationExercise.fromJson(meditation);
          } else {
            return MeditationExercise.fromJson(
              Map<String, dynamic>.from(meditation),
            );
          }
        }).toList();
      } else {
        return [];
      }
    } catch (error) {
      print(error);
      return [];
    }
  }

  // method to delete an exercise
  Future<void> deleteMeditation(
    MeditationExercise meditationExercise,
    BuildContext context,
  ) async {
    try {
      // get all exercises from storage
      final allExercisesJson = meditationBox.get('meditation_data');
      List<Map<String, dynamic>> exercises = [];

      if (allExercisesJson != null && allExercisesJson is List) {
        exercises = List<Map<String, dynamic>>.from(
          allExercisesJson.map((meditation) {
            return Map<String, dynamic>.from(meditation);
          }),
        );

        // remove the exercise from the list
        exercises.removeWhere((meditation) {
          MeditationExercise currentexercise = MeditationExercise.fromJson(
            Map<String, dynamic>.from(meditation),
          );

          return currentexercise.name == meditationExercise.name &&
              currentexercise.category == meditationExercise.category;
        });

        // save the updated list in box
        await meditationBox.put('meditation_data', exercises);

        // display a message
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Exercise deleted"),
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
