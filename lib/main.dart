import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meditator/models/meditation_exercise_model.dart';
import 'package:meditator/models/mindfull_exercise_model.dart';
import 'package:meditator/models/sleep_exercise_model.dart';
import 'package:meditator/providers/custom_data_provider.dart';
import 'package:meditator/providers/filtered_provider.dart';
import 'package:meditator/providers/meditation_provider.dart';
import 'package:meditator/providers/mindfull_exercise_provider.dart';
import 'package:meditator/providers/sleep_exercise_provider.dart';
import 'package:meditator/router/router.dart';
import 'package:provider/provider.dart';

void main() async {
  // hive initialization
  await Hive.initFlutter();

  // register adapters
  Hive.registerAdapter(MeditationExerciseAdapter());
  Hive.registerAdapter(MindfulnessExerciseAdapter());
  Hive.registerAdapter(SleepExerciseAdapter());

  // creating boxes for data
  await Hive.openBox('meditation_data');
  await Hive.openBox('mindfulness_data');
  await Hive.openBox('sleep_data');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MindfullExerciseProvider()),
        ChangeNotifierProvider(create: (context) => MeditationProvider()),
        ChangeNotifierProvider(create: (context) => SleepExerciseProvider()),
        ChangeNotifierProvider(create: (context) => FilteredProvider()),
        ChangeNotifierProvider(create: (context) => CustomDataProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Meditate Application",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: GoogleFonts.lato().fontFamily),
      routerConfig: AppRouter().appRoutes,
    );
  }
}
