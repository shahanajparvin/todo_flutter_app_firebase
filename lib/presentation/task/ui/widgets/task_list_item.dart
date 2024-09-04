import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/core/constant/app_color.dart';
import 'package:todo_app/core/constant/app_size.dart';
import 'package:todo_app/core/utils/core_utils.dart';
import 'package:todo_app/core/utils/modal_controller.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/presentation/task/bloc/task_bloc.dart';
import 'package:todo_app/presentation/task/bloc/task_event.dart';
import 'package:todo_app/presentation/task/ui/widgets/add_task_widget.dart';
import 'package:todo_app/presentation/task/ui/widgets/slider_edit_delete_action_widget.dart';

class TaskListItem extends StatelessWidget {
  final ModalController modalController;
  final TaskBloc taskBloc;
  final Task task;


  const TaskListItem({super.key, required this.modalController, required this.taskBloc, required this.task});

  @override
  Widget build(BuildContext context) {
    TextDirection direction = Directionality.of(context);
    return SlidableListItem(
        onDelete:(){
         taskBloc.add(DeleteTask(task.id!));
        },
        onUpdate: () {
          modalController.showModal(
            context,
            AddTaskWidget(modalController: modalController, taskBloc: taskBloc,task: task,),
          );
        },
        child:Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: direction==TextDirection.ltr?Border(
              left: BorderSide(
                color: Colors.blue, // Border color
                width: AppWidth.s8, // Border width
              ),
            ):Border(
              right: BorderSide(
                color: Colors.blue, // Border color
                width: AppWidth.s8, // Border width
              ),
            ),
            borderRadius: BorderRadius.circular(
                10.0), // Radius applied to all corners
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            task.title,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          AppCircularCheckbox(
                            onChanged: (value) {
                              taskBloc.
                              add(UpdateIsCompleted(task.id!,value!));
                            }, isChecked: task.isCompleted,
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        task.description,
                        style: TextStyle(fontSize: 16.0),
                      ),
                     Gap(AppHeight.s10),
                     Divider(color: Colors.grey.shade200,height:0.5),
                      Gap(AppHeight.s10),
                     Row(
                        children: [
                          Icon(Icons.calendar_today,
                              size: 16.0),
                          SizedBox(width: 4.0),
                          Directionality(
                            textDirection: TextDirection.ltr, // Force LTR layout
                            child:Text(task.date)),
                          SizedBox(width: 16.0),
                          Icon(Icons.access_time, size: 16.0),
                          SizedBox(width: 4.0),
                          Directionality(
                                textDirection: TextDirection.ltr, // Force LTR layout
                                child:Text(task.time)),
                          Spacer(),
                          Text(
                            localizeCategory(context,task.category),
                            style: TextStyle(fontSize: 16.0),
                          ),



                        ],
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ));
  }

  String localizeCategory(BuildContext context, String category){
    if(category=='Working'){
      return context.text.working;
    }else if(category=='General'){
      return context.text.working;
    }else if(category=='General'){
      return context.text.working;
    }
    return category;
  }

  Color getColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.selected)) {
      return Colors.red; // Color when checked
    }
    return Colors.grey; // Color when unchecked
  }

}



class AppCircularCheckbox extends StatefulWidget {
  final bool isChecked;
  final ValueChanged<bool> onChanged;

  AppCircularCheckbox({
    required this.isChecked,
    required this.onChanged,
  });

  @override
  _AppCircularCheckboxState createState() => _AppCircularCheckboxState();
}

class _AppCircularCheckboxState extends State<AppCircularCheckbox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.isChecked);
      },
      child: Container(
        width: AppWidth.s20, // Size of the checkbox
        height: AppWidth.s20,
        decoration: BoxDecoration(
          color: widget.isChecked ? AppColor.themeColor : Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey.shade300, // Border color
            width: 1.0,
          ),
        ),
        child: widget.isChecked
            ? Center(
          child: Icon(
            Icons.check,
            color: AppColor.whiteColor, // Checkmark color
            size: AppWidth.s14, // Checkmark size
          ),
        )
            : null,
      ),
    );
  }
}

