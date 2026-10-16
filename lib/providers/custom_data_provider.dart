import 'package:flutter/material.dart';
import 'package:meditator/models/meditation_exercise_model.dart';
import 'package:meditator/models/mindfull_exercise_model.dart';
import 'package:meditator/models/sleep_exercise_model.dart';
import 'package:meditator/services/meditation_service.dart';
import 'package:meditator/services/mindful_exercise_service.dart';
import 'package:meditator/services/sleep_exercise_service.dart';

class CustomDataProvider extends ChangeNotifier {
  final List<MeditationExercise> _meditations = [];
  final List<SleepExercise> _sleepexercises = [];
  final List<MindfulnessExercise> _mindfulnessExercises = [];

  // getter
  List<MeditationExercise> get allMeditations => _meditations;
  List<SleepExercise> get allSleepExercises => _sleepexercises;
  List<MindfulnessExercise> get allMindfulnessExercises =>
      _mindfulnessExercises;

  // --- ADD ---
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

  // method to add new sleep exercise
  void addSleepEcercise(SleepExercise exercise, BuildContext context) {
    try {
      // adding exercise to list
      _sleepexercises.add(exercise);

      // saving exercise in local storage
      try {
        SleepExerciseService().addSleepExercise(exercise, context);
      } catch (error) {
        print("Provider local storage : $error");
      }

      notifyListeners();
    } catch (error) {
      print("Provide error : $error");
    }
  }

  // void add new mindfulness exercise
  void addMindfulnessExercise(
    MindfulnessExercise exercise,
    BuildContext context,
  ) {
    try {
      // adding to list
      _mindfulnessExercises.add(exercise);

      // saving in local storage
      try {
        MindfulExerciseService().addMindfullExercise(exercise, context);
      } catch (error) {
        print("Error local storage provider : $error");
      }

      notifyListeners();
    } catch (error) {
      print("Provider error : $error");
    }
  }

  // --- GET ---
  // method to get meditations exercises
  List<MeditationExercise> getMeditationExersices() {
    try {
      final meditationExersices = MeditationService().getAllMeditations();

      return meditationExersices;
    } catch (error) {
      print("Provider error : $error");
      return [];
    }
  }

  // method to get mindfulness exercises
  List<MindfulnessExercise> getMindfulnessExercises() {
    try {
      final mindfulnessExersices = MindfulExerciseService()
          .getMindfulnessExercises();
      return mindfulnessExersices;
    } catch (error) {
      print("Provider error : $error");
      return [];
    }
  }

  // method to get sleep exercises
  List<SleepExercise> getSleepExercises() {
    try {
      final sleepExersices = SleepExerciseService().getAllSleepExercises();
      return sleepExersices;
    } catch (error) {
      print("Provider error : $error");
      return [];
    }
  }

  // --- DELETE ---
  // delete meditation exersice
  void deleteMeditation(MeditationExercise meditation, BuildContext context) {
    try {
      // remove from the list in provider
      _meditations.remove(meditation);

      // remove from local storage
      try {
        MeditationService().deleteMeditation(meditation, context);
      } catch (error) {
        print("Provider delete service error : $error");
      }

      notifyListeners();
    } catch (error) {
      print("Provider error : $error");
    }
  }

  // delete mindfulness exersice
  void deleteMindfulness(
    MindfulnessExercise mindfulness,
    BuildContext context,
  ) {
    try {
      _mindfulnessExercises.remove(mindfulness);

      try {
        MindfulExerciseService().deleteMindfulnessExersice(
          mindfulness,
          context,
        );
      } catch (error) {
        print("Provider local storage deletion error : $error");
      }

      notifyListeners();
    } catch (error) {
      print("Provider error : $error");
    }
  }

  // delete sleep exercise
  void deleteSleepExersice(SleepExercise sleepExercise, BuildContext context) {
    try {
      _sleepexercises.remove(sleepExercise);

      try {
        SleepExerciseService().deleteSleepExersice(sleepExercise, context);
      } catch (error) {
        print("Provider local storage deletion error : $error");
      }

      notifyListeners();
    } catch (error) {
      print("Provider error : $error");
    }
  }
}
