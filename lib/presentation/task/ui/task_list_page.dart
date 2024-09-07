import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/base/app_routes.dart';
import 'package:todo_app/core/base/app_settings.dart';
import 'package:todo_app/core/constant/app_size.dart';
import 'package:todo_app/core/constant/image_constants.dart';
import 'package:todo_app/core/di/injector.dart';
import 'package:todo_app/core/services/task_sync_manager.dart';
import 'package:todo_app/core/utils/core_utils.dart';
import 'package:todo_app/core/utils/modal_controller.dart';
import 'package:todo_app/domain/entities/language.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/main_common.dart';
import 'package:todo_app/presentation/changelanguage/ui/change_language_view.dart';
import 'package:todo_app/presentation/lanuage/bloc/language_bloc.dart';
import 'package:todo_app/presentation/lanuage/bloc/language_event.dart';
import 'package:todo_app/presentation/task/bloc/task_bloc.dart';
import 'package:todo_app/presentation/task/bloc/task_event.dart';
import 'package:todo_app/presentation/task/bloc/task_state.dart';
import 'package:todo_app/presentation/task/ui/widgets/add_task_widget.dart';
import 'package:todo_app/presentation/task/ui/widgets/header_section.dart';
import 'package:todo_app/presentation/task/ui/widgets/localization_icon.dart';
import 'package:todo_app/presentation/task/ui/widgets/no_task_widget.dart';
import 'package:todo_app/presentation/task/ui/widgets/slider_edit_delete_action_widget.dart';
import 'package:todo_app/presentation/task/ui/widgets/task_list.dart';
import 'package:todo_app/presentation/task/ui/widgets/task_shimmer_list.dart';
import 'package:todo_app/presentation/useraccount/ui/widgets/user_accout_view.dart';

class TaskListPage extends StatefulWidget {
  final TaskBloc taskBloc;

  const TaskListPage({super.key, required this.taskBloc});

  @override
  State<TaskListPage> createState() => _TaskListState();
}

class _TaskListState extends State<TaskListPage> {
  late ModalController modalController;
  late StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    widget.taskBloc.add(FetchTasks());
    modalController = ModalController();
    getConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: AppHeight.s80,
        title: UserAccountRoot(),
        actions: [
          TranslateIcon(
            modalController: modalController,
          )
        ],
      ),
      body: Column(
        children: [
          HeaderSection(
            modalController: modalController,
            taskBloc: widget.taskBloc,
          ),
          Flexible(
              child: BlocBuilder<TaskBloc, TaskState>(
            bloc: widget.taskBloc,
            builder: (context, state) {
              if (state is TaskLoading) {
                return const ShimmerTaskList();
              } else if (state is TaskLoaded && state.tasks.isNotEmpty) {
                return TaskList(tasks: state.tasks, modalController: modalController, taskBloc: widget.taskBloc);
              }
              return NoResultsScreen(onPressCallBack: () {
                modalController.showModal(
                  context,
                  AddTaskWidget(
                      modalController: modalController,
                      taskBloc: widget.taskBloc),
                );
              });
            },
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.taskBloc.add(FetchTasks());
        },
      ),
    );
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          if (result == ConnectivityResult.mobile ||
              result == ConnectivityResult.wifi) {
            TaskSyncUtil.syncData(
                remoteDataSource: injector(),
                localDataSource: injector(),
                connectionChecker: injector());
            print("Connected to the internet.");
          } else {
            print("No internet connection.");
          }
        },
      );
}