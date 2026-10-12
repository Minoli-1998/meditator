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
  String _selectedCategory = "All";

  // methode to get all data from providers
  Future<void> getAllData(BuildContext context) async {
    // ensures this runs after build
    await Future.delayed(Duration.zero);

    // mindfull exercises
    final List<MindfulnessExercise> mindfullExercises =
        Provider.of<MindfullExerciseProvider>(
          // ignore: use_build_context_synchronously
          context,
          listen: false,
        ).mindfullExercies;

    // meditation exercises
    final List<MeditationExercise> meditationExercises =
        Provider.of<MeditationProvider>(
          // ignore: use_build_context_synchronously
          context,
          listen: false,
        ).meditationExercies;

    // sleep stories exercises
    final List<SleepExercise> sleepExercises =
        Provider.of<SleepExerciseProvider>(
          // ignore: use_build_context_synchronously
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

  // method to get filtered data
  List<dynamic> get filteredData => _filteredData;

  // method to filter data
  // here category means the type of filtered data
  void filterDataIntoType(String category) {
    _selectedCategory = category;

    if (category == "All") {
      _filteredData = _allData;
    } else if (category == "Mindfulness") {
      _filteredData = _allData.whereType<MindfulnessExercise>().toList();
    } else if (category == "Meditation") {
      _filteredData = _allData.whereType<MeditationExercise>().toList();
    } else if (category == "Sleep Stories") {
      _filteredData = _allData.whereType<SleepExercise>().toList();
    }

    notifyListeners();
  }

  // get selected category
  String getSelectedCategory() {
    return _selectedCategory;
  }
}
