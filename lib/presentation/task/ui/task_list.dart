/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/di/injector.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/presentation/task/bloc/task_bloc.dart';
import 'package:todo_app/presentation/task/bloc/task_event.dart';
import 'package:todo_app/presentation/task/bloc/task_state.dart';
import 'package:workmanager/workmanager.dart';


class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskBloc>(
        create: (context) {
      return injector();
    },
    child:TaskList());
  }
}




class TaskList extends StatefulWidget {
  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {

  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(FetchTasks());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Todo List')),
        body: BlocListener<TaskBloc, TaskState>(
          listener: (context, state) {
            if (state is TaskError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              print('---------state '+state.toString());
              if (state is TaskLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is TaskLoaded) {
                return ListView.builder(
                  itemCount: state.tasks.length,
                  itemBuilder: (context, index) {
                    final task = state.tasks[index];
                    return ListTile(
                      title: Text(task.title),
                      trailing: Expanded(
                        child: Row(
                          mainAxisSize : MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                final newTask = Task(title: 'Edited task', description: 'twssssss');
                                context.read<TaskBloc>().add(UpdateTask(task.id!, newTask));
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                context.read<TaskBloc>().add(DeleteTask(task.id!));
                              },
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        // Handle task edit
                      },
                    );
                  },
                );
              } else {
                return Center(child: Text('No tasks available'));
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final newTask = Task(title: 'Synch data test 2', description: 'twsssssddszfzds');
            context.read<TaskBloc>().add(AddTask(newTask));


            context.read<TaskBloc>().add(FetchUnsynchedTasks());

          },
          child: Icon(Icons.add),
        ));
  }
}
*/
