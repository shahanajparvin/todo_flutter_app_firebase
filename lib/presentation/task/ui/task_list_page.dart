import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/constant/app_size.dart';
import 'package:todo_app/core/constant/app_text.dart';
import 'package:todo_app/core/di/injector.dart';
import 'package:todo_app/core/services/task_sync_manager.dart';
import 'package:todo_app/core/utils/app_alert_manager.dart';
import 'package:todo_app/core/utils/app_easy_loading.dart';
import 'package:todo_app/core/utils/core_utils.dart';
import 'package:todo_app/core/utils/modal_controller.dart';
import 'package:todo_app/presentation/task/bloc/task_bloc.dart';
import 'package:todo_app/presentation/task/bloc/task_event.dart';
import 'package:todo_app/presentation/task/bloc/task_state.dart';
import 'package:todo_app/presentation/task/ui/widgets/add_task_widget.dart';
import 'package:todo_app/presentation/task/ui/widgets/header_section.dart';
import 'package:todo_app/presentation/task/ui/widgets/localization_icon.dart';
import 'package:todo_app/presentation/task/ui/widgets/no_task_widget.dart';
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
                child: BlocListener<TaskBloc, TaskState>(
                    listener: (context, state) {
                      if (state is TaskLoading) {
                        showLoadingIndicator(); // Show loading indicator
                      }
                      else if (state is TaskLoaded) {
                        dismissLoadingIndicator();
                        if (state.message != null) {
                          dismissWithMessage(message: state.message!, isError: state.isError);
                        }
                      }else{
                        dismissLoadingIndicator();
                        if(state is TaskError)
                        dismissWithMessage(message: state.message);
                      }
                    },
                    child: BlocBuilder<TaskBloc, TaskState>(
                      builder: (context, state) {
                        if (state is TaskLoading) {
                          return const ShimmerTaskList();
                        } else if (state is TaskLoaded &&
                            state.tasks.isNotEmpty) {
                          return TaskList(
                              tasks: state.tasks,
                              modalController: modalController,
                              taskBloc: widget.taskBloc);
                        }
                        return NoResultsScreen(onPressCallBack: () {
                          modalController.showModal(
                            context,
                            AddTaskWidget(
                                modalController: modalController,
                                taskBloc: widget.taskBloc),
                          );
                        });
                      }
                    )))
          ]
        ));
  }

  dismissWithMessage({required String message, bool isError = true}) {
    dismissLoadingIndicator();
    showAlert(
        message: _messageTranslated(message),
        isError: isError
    );
  }

  String _messageTranslated(String message) {
    switch (message) {
      case AppConst.addSuccess:
        return context.text.success_add;
      case AppConst.addFail:
        return context.text.fail_add;

      case AppConst.updateSuccess:
        return context.text.success_update;
      case AppConst.updateFail:
        return context.text.fail_update;

      case AppConst.deleteSuccess:
        return context.text.success_delete;
      case AppConst.deleteFail:
        return context.text.fail_delete;

      case AppConst.statusSuccess:
        return context.text.success_status;
      case AppConst.statusFail:
        return context.text.fail_status;
      default:
        return message;
    }
    }


  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          if (result == ConnectivityResult.mobile ||
              result == ConnectivityResult.wifi) {
            TaskSyncUtil.syncData(
                taskBloc: widget.taskBloc,
                remoteDataSource: injector(),
                localDataSource: injector(),
                connectionChecker: injector());
          }
        },
      );
}
