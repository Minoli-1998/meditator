import 'dart:convert';

import 'package:go_router/go_router.dart';
import 'package:meditator/models/mindfull_exercise_model.dart';
import 'package:meditator/pages/main_screen.dart';
import 'package:meditator/pages/mindful_exercise_details_page.dart';
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
    ],
  );
}
