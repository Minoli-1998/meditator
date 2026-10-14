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
}
