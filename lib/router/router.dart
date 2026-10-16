import 'dart:convert';

import 'package:go_router/go_router.dart';
import 'package:meditator/models/functions_data_model.dart';
import 'package:meditator/models/mindfull_exercise_model.dart';
import 'package:meditator/models/sleep_exercise_model.dart';
import 'package:meditator/pages/functions_page.dart';
import 'package:meditator/pages/main_screen.dart';
import 'package:meditator/pages/main_screens/create_custom_exercise_page.dart';
import 'package:meditator/pages/mindful_exercise_details_page.dart';
import 'package:meditator/pages/mindful_exercise_timer.dart';
import 'package:meditator/pages/sleep_exercise_timer.dart';
import 'package:meditator/router/route_names.dart';

class AppRouter {
  final GoRouter appRoutes = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: AppRouteNames.mainPage,
        builder: (context, state) {
          return MainScreen();
        },
      ),

      // mindful exercise page
      GoRoute(
        path: '/mindfulExercise',
        name: AppRouteNames.mindfulExercise,
        builder: (context, state) {
          // get object as a json data
          final exerciseJson = state.uri.queryParameters["mindfullExercises"];

          // convert it to Mindfullexercise
          final exercise = MindfulnessExercise.fromJson(
            json.decode(exerciseJson!),
          );

          return MindfulExerciseDetailsPage(mindfulExercise: exercise);
        },
      ),

      // functions page
      GoRoute(
        path: '/functions',
        name: AppRouteNames.functions,
        builder: (context, state) {
          final FunctionsData functionsData = state.extra as FunctionsData;
          return FunctionsPage(functionData: functionsData);
        },
      ),

      // Mindful exercise timer
      GoRoute(
        path: '/mindfulExerciseTimer',
        name: AppRouteNames.mindfulExerciseTimer,
        builder: (context, state) {
          final mindfulExerciseJson =
              state.uri.queryParameters["mindfulExercise"];

          final exercise = MindfulnessExercise.fromJson(
            json.decode(mindfulExerciseJson!),
          );
          return MindfulExerciseTimer(exercise: exercise);
        },
      ),

      // Sleep exercise timer
      GoRoute(
        path: '/sleepExerciseTimer',
        name: AppRouteNames.sleepExerciseTimer,
        builder: (context, state) {
          SleepExercise sleepExercise = state.extra as SleepExercise;
          return SleepExerciseTimer(sleepExercise: sleepExercise);
        },
      ),

      // create page
      GoRoute(
        path: '/createCustomExercise',
        name: AppRouteNames.createCustomExercise,
        builder: (context, state) {
          return CreateCustomExercisePage();
        },
      ),
    ],
  );
}
