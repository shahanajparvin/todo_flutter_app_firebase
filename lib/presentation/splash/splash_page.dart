import 'package:flutter/material.dart';
import 'package:todo_app/core/constant/app_text.dart';
import 'package:todo_app/core/constant/pref_keys.dart';
import 'package:todo_app/core/di/injector.dart';
import 'package:todo_app/core/synch_service.dart';
import 'package:todo_app/core/utils/internet_connection_checker.dart';
import 'package:todo_app/data/datasources/local/local_data_source.dart';
import 'package:todo_app/data/datasources/remote/remote_data_source.dart';
import 'package:todo_app/presentation/splash/ui/splash_view.dart';
import 'package:workmanager/workmanager.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    registerTask();

  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {

      },
      child: const Scaffold(
        body: SplashView(),
      ),
    );
  }
}

void registerTask() {


  final RemoteDataSource remoteDataSource = injector();
  final LocalDataSource localDataSource = injector();
  final InternetConnectionChecker connectionChecker  = injector();

  Map<String, dynamic> inputData = {
    AppKey.localDataSource: localDataSource,
    AppKey.remoteDataSource: remoteDataSource,
    AppKey.connectionChecker: connectionChecker,
  };

  print('----------inputData '+inputData.toString());

  Workmanager().registerPeriodicTask(
    "1", // Unique identifier for the task
    AppConst.syncService,
    inputData: inputData,
    frequency: Duration(minutes: 15), // The frequency with which to run the task
  );
}