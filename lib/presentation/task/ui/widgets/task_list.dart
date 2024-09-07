import 'package:flutter/material.dart';
import 'package:todo_app/core/constant/app_size.dart';
import 'package:todo_app/core/utils/modal_controller.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/presentation/task/bloc/task_bloc.dart';
import 'package:todo_app/presentation/task/ui/widgets/task_list_item.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final ModalController modalController;
  final TaskBloc taskBloc;


  const TaskList({super.key, required this.tasks, required this.modalController, required this.taskBloc});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) {
          return SizedBox(
            height: AppHeight.s15,
          );
        },
      padding: EdgeInsets.symmetric(horizontal: AppWidth.s20,vertical: AppHeight.s10),
      itemCount:tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskListItem(
          index: index,
          taskBloc: taskBloc,
          task:task,
          modalController:modalController,
        );
      },
    );
  }
}
