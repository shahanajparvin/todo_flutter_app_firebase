import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/base/app_routes.dart';
import 'package:todo_app/core/base/app_settings.dart';
import 'package:todo_app/core/di/injector.dart';
import 'package:todo_app/core/flavor/flavor_config.dart';
import 'package:todo_app/core/synch_service.dart';
import 'package:todo_app/core/utils/sharedpreferences_helper.dart';



class DependencyManager {
  static Future<void> inject(
    FlavorConfig flavorConfig,
  ) async {
    SharedPreferencesHelper helper = SharedPreferencesHelper();
    AppSettings appSettings = AppSettings(helper);
    GoRouter routes = provideGoRoute();
    injector.registerLazySingleton<SharedPreferencesHelper>(() => helper);
    injector.registerSingleton(appSettings);
    injector.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
    injector.registerLazySingleton<FlavorConfig>(() => flavorConfig);
    injector.registerLazySingleton<GoRouter>(() => routes);
    await configureDependencies();
  }
}
