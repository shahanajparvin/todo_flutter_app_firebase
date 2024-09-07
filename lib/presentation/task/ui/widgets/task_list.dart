import 'package:flutter/material.dart';
import 'package:todo_app/core/constant/app_size.dart';
import 'package:todo_app/core/utils/modal_controller.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/presentation/task/bloc/task_bloc.dart';
import 'package:todo_app/presentation/task/ui/widgets/task_list_item.dart';

import 'package:flutter/material.dart';
import 'package:todo_app/core/constant/app_size.dart';
import 'package:todo_app/core/utils/modal_controller.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/presentation/task/bloc/task_bloc.dart';
import 'package:todo_app/presentation/task/ui/widgets/task_list_item.dart';

class TaskList extends StatefulWidget {
  final List<Task> tasks;
  final ModalController modalController;
  final TaskBloc taskBloc;

  const TaskList({
    super.key,
    required this.tasks,
    required this.modalController,
    required this.taskBloc,
  });

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void didUpdateWidget(covariant TaskList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.tasks.length > oldWidget.tasks.length) {
      // Scroll to the end of the list when a new item is added
      Future.delayed(Duration(milliseconds: 300), () {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: _scrollController,
      separatorBuilder: (context, index) {
        return SizedBox(
          height: AppHeight.s15,
        );
      },
      padding: EdgeInsets.symmetric(
        horizontal: AppWidth.s20,
        vertical: AppHeight.s10,
      ),
      itemCount: widget.tasks.length,
      itemBuilder: (context, index) {
        final task = widget.tasks[index];
        return TaskListItem(
          index: index,
          taskBloc: widget.taskBloc,
          task: task,
          modalController: widget.modalController,
        );
      },
    );
  }
}

