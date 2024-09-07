
import 'package:flutter/cupertino.dart';
import 'package:todo_app/core/constant/app_text.dart';
import 'package:todo_app/core/constant/pref_keys.dart';
import 'package:todo_app/core/di/injector.dart';
import 'package:todo_app/core/utils/internet_connection_checker.dart';
import 'package:todo_app/data/datasources/local/local_data_source.dart';
import 'package:todo_app/data/datasources/remote/remote_data_source.dart';
import 'package:todo_app/presentation/task/bloc/task_bloc.dart';
import 'package:todo_app/presentation/task/ui/task_list_page.dart';
import 'package:workmanager/workmanager.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late TaskBloc _taskBloc;


  @override
  void initState() {
    super.initState();
    _taskBloc = injector();
    registerTask();
  }

  @override
  Widget build(BuildContext context) {
    return TaskListPage(taskBloc: _taskBloc);
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


  Workmanager().registerPeriodicTask(
    "1", // Unique identifier for the task
    AppConst.syncService,
    inputData: inputData,
    frequency: Duration(minutes: 15), // The frequency with which to run the task
  );
}

