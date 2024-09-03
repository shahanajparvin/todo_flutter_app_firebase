
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/core/di/injector.config.dart';

final injector = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)

 Future configureDependencies() async => injector.init();