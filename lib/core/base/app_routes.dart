import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/presentation/home/home_page.dart';
import 'package:todo_app/presentation/splash/splash_page.dart';



enum AppRoutes {
  splash,
  home,
}

GoRouter provideGoRoute() {
  return GoRouter(
      /*redirect: (BuildContext context, GoRouterState state) {
        if (state.matchedLocation != "/" && !appSettings.isLoggedIn()) {
          return '/login';
        }
        return null;
      },*/
      initialLocation: "/home",
      debugLogDiagnostics: kDebugMode,
      routes: [
        GoRoute(
          path: "/",
          name: AppRoutes.splash.name,
          builder: (context, state) => const SplashPage(),
        ),

        GoRoute(
          path: "/home",
          name: AppRoutes.home.name,
          builder: (context, state) =>  HomePage(),
        ),



      ]);
}
