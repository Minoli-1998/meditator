import 'package:flutter/material.dart';
import 'package:meditator/models/meditation_exercise_model.dart';
import 'package:meditator/models/mindfull_exercise_model.dart';
import 'package:meditator/models/sleep_exercise_model.dart';
import 'package:meditator/providers/meditation_provider.dart';
import 'package:meditator/providers/mindfull_exercise_provider.dart';
import 'package:meditator/providers/sleep_exercise_provider.dart';
import 'package:provider/provider.dart';

class FilteredProvider extends ChangeNotifier {
  List<dynamic> _allData = [];
  List<dynamic> _filteredData = [];

  // methode to get all data from providers
  Future<void> getAllData(BuildContext context) async {
    // ensures this runs after build
    await Future.delayed(Duration.zero);

    // mindfull exercises
    final List<MindfulnessExercise> mindfullExercises =
        Provider.of<MindfullExerciseProvider>(
          context,
          listen: false,
        ).mindfullExercies;

    // meditation exercises
    final List<MeditationExercise> meditationExercises =
        Provider.of<MeditationProvider>(
          context,
          listen: false,
        ).meditationExercies;

    // sleep stories exercises
    final List<SleepExercise> sleepExercises =
        Provider.of<SleepExerciseProvider>(
          context,
          listen: false,
        ).sleepExercies;

    // saving all lists under _allData
    _allData = [
      ...mindfullExercises,
      ...meditationExercises,
      ...sleepExercises,
    ];

    // since we always return flitered data
    _filteredData = _allData;

    notifyListeners();
  }
}
