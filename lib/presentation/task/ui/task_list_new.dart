import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/base/app_routes.dart';
import 'package:todo_app/core/base/app_settings.dart';
import 'package:todo_app/core/constant/app_size.dart';
import 'package:todo_app/core/di/injector.dart';
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
import 'package:todo_app/presentation/task/ui/widgets/no_task_widget.dart';
import 'package:todo_app/presentation/task/ui/widgets/slider_edit_delete_action_widget.dart';
import 'package:todo_app/presentation/task/ui/widgets/task_list.dart';
import 'package:todo_app/presentation/task/ui/widgets/task_list_item.dart';



class HomePageChild extends StatefulWidget {
  final TaskBloc taskBloc;

  const HomePageChild({super.key, required this.taskBloc});
  @override
  State<HomePageChild> createState() => _TaskListState();
}

class _TaskListState extends State<HomePageChild> {

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
        backgroundColor: Colors.green,
        appBar: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: AppHeight.s80,
            title: Container(
                alignment: Alignment.center,
                child:Padding(
            padding:  EdgeInsets.symmetric(horizontal:AppWidth.s5),
                 child:Row(children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue
                    ),
                  ),
                  Gap(AppWidth.s8),
                  Column(
                    crossAxisAlignment : CrossAxisAlignment.start,
                    children: [
                    Text( context.text.hi,style: TextStyle(fontSize: AppTextSize.s14,color: Colors.grey)),
                    Text('Mohhasfdsds',style: TextStyle(fontSize: AppTextSize.s16,color: Colors.black))
                  ],)
                ],))),
           actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal:AppWidth.s12),
                child: Row(children: [
                  IconButton(onPressed: () async {
                    modalController.showModal(context, ChangeLanguageView(modalController: modalController,));
                 },
                   icon: Icon(Icons.calendar_month))
                ]),
              )

            ],

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
          child: Container(
            color: Color(0xFFF3F3F3),
            child:  BlocBuilder<TaskBloc, TaskState>(
              bloc: widget.taskBloc,
              builder: (context, state) {
                if (state is TaskLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is TaskLoaded) {
                  return Column(
                    children: [
                      HeaderSection(modalController: modalController,taskBloc: widget.taskBloc,),
                      Flexible(
                        child: TaskList(
                            taskBloc: widget.taskBloc,
                            tasks: state.tasks,
                            modalController: modalController
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(child: NoResultsScreen(onPressCallBack: () {
                    modalController.showModal(
                      context,
                      AddTaskWidget(modalController: modalController, taskBloc: widget.taskBloc),
                    );
                  }));
                }
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final newTask = Task(
                title: 'new task',
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
