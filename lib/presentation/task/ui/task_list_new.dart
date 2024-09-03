import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/core/di/injector.dart';
import 'package:todo_app/core/utils/modal_controller.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/presentation/task/bloc/task_bloc.dart';
import 'package:todo_app/presentation/task/bloc/task_event.dart';
import 'package:todo_app/presentation/task/bloc/task_state.dart';
import 'package:todo_app/presentation/task/ui/widgets/add_task_widget.dart';
import 'package:todo_app/presentation/task/ui/widgets/slider_action_widget.dart';

class TaskPageNew extends StatefulWidget {
  const TaskPageNew({super.key});

  @override
  State<TaskPageNew> createState() => _TaskPageNewState();
}

class _TaskPageNewState extends State<TaskPageNew> {
  
  late TaskBloc _taskBloc;

  
  @override
  void initState() {
    super.initState();
    _taskBloc = injector();
  }
  
  @override
  Widget build(BuildContext context) {
    return TaskList(taskBloc: _taskBloc);
  }
}

class TaskList extends StatefulWidget {
  final TaskBloc taskBloc;


  const TaskList({super.key, required this.taskBloc});
  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {

  late ModalController modalController;

  @override
  void initState() {
    super.initState();
    widget.taskBloc.add(FetchTasks());
    modalController = ModalController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF3F3F3),
        appBar: AppBar(
          title: Text('Todo List'),
          backgroundColor: Colors.white,
        ),
        body: BlocListener<TaskBloc, TaskState>(
          bloc: widget.taskBloc,
          listener: (context, state) {
            if (state is TaskError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: Column(
            children: [
              Row(
                children: [
                  Text('Task List'),
                  SizedBox(
                    height: 35,
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.add,
                        size: 18,
                      ),
                      label: const Text("Test"),
                      onPressed: () {
                        ModalController modalController = ModalController();
                        modalController.showModal(
                          context,
                          AddTaskWidget(modalController: modalController, taskBloc: widget.taskBloc,),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFC2D5ED),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              5), // Makes the button rectangular
                        ),
                      ),
                    ),)

                ],
              ),
              Gap(16),
              BlocBuilder<TaskBloc, TaskState>(
                bloc: widget.taskBloc,
                builder: (context, state) {
                  print('---------state ' + state.toString());
                  if (state is TaskLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is TaskLoaded) {
                    return Flexible(
                      child: ListView.builder(
                        itemCount: state.tasks.length,
                        itemBuilder: (context, index) {
                          final task = state.tasks[index];
                          return  SlidableListItem(
                              onDelete:(){
                                widget.taskBloc.add(DeleteTask(task.id!));
                              },
                              child:Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                left: BorderSide(
                                  color: Colors.blue, // Border color
                                  width: 10.0, // Border width
                                ),
                              ),
                              borderRadius: BorderRadius.circular(
                                  10.0), // Radius applied to all corners
                            ),
                            margin: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          task.title,
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4.0),
                                        Text(
                                          task.description,
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                        SizedBox(height: 8.0),
                                        Row(
                                          children: [
                                            Icon(Icons.calendar_today,
                                                size: 16.0),
                                            SizedBox(width: 4.0),
                                            Text(task.date),
                                            SizedBox(width: 16.0),
                                            Icon(Icons.access_time, size: 16.0),
                                            SizedBox(width: 4.0),
                                            Text(task.time),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Checkbox(
                                        value: task.isCompleted,
                                        onChanged: (value) {
                                          widget.taskBloc.
                                          add(UpdateIsCompleted(task.id!,value!));
                                        },
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.edit),
                                            onPressed: () {

                                              modalController.showModal(
                                                context,
                                                AddTaskWidget(modalController: modalController, taskBloc: widget.taskBloc,task: task,),
                                              );
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: () {

                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ));
                        },
                      ),
                    );
                  } else {
                    return Center(child: Text('No tasks available'));
                  }
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final newTask = Task(
                title: 'zATTTDGGRsfsdfsdfsfsdfsfs',
                description: 'twssssss',
                date: '12/23/3',
                time: '12:00',
                isCompleted: true,
                category: 'Wok');
            widget.taskBloc.add(AddTask(newTask));
            },
          child: Icon(Icons.add),
        ));
  }



}
