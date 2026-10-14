import 'package:flutter/material.dart';
import 'package:meditator/models/meditation_exercise_model.dart';
import 'package:meditator/services/meditation_service.dart';

class CustomDataProvider extends ChangeNotifier {
  final List<MeditationExercise> _meditations = [];

  // getter
  List<MeditationExercise> get allMeditations => _meditations;

  // method to add new meditaion
  void addMeditation(MeditationExercise meditation, BuildContext context) {
    try {
      // adding meditation to the list
      _meditations.add(meditation);

      // saving meditaion in local storage
      try {
        MeditationService().addMeditation(meditation, context);
      } catch (error) {
        print("Provide local storage error : $error");
      }

      notifyListeners();
    } catch (error) {
      print("Provider error : $error");
    }
  }
}
