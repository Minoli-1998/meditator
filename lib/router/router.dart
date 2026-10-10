import 'package:go_router/go_router.dart';
import 'package:meditator/pages/main_screen.dart';
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
    ],
  );
}
