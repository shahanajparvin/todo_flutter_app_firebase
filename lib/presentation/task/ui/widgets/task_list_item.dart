import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/core/constant/app_color.dart';
import 'package:todo_app/core/constant/app_size.dart';
import 'package:todo_app/core/constant/pref_keys.dart';
import 'package:todo_app/core/utils/date_time_utility.dart';
import 'package:todo_app/core/utils/core_utils.dart';
import 'package:todo_app/core/utils/modal_controller.dart';
import 'package:todo_app/data/datasources/dummy_category_list.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/presentation/task/bloc/task_bloc.dart';
import 'package:todo_app/presentation/task/bloc/task_event.dart';
import 'package:todo_app/presentation/task/ui/widgets/add_task_widget.dart';
import 'package:todo_app/presentation/task/ui/widgets/slider_edit_delete_action_widget.dart';

class TaskListItem extends StatefulWidget {
  final ModalController modalController;
  final TaskBloc taskBloc;
  final Task task;
  final int index;


   TaskListItem({super.key, required this.modalController, required this.taskBloc, required this.task, required this.index});

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  double screenHeight = 0;

  double screenWidth = 0;

  bool startAnimation = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    TextDirection direction = Directionality.of(context);
    String localizedCategory =  localizeCategory(context,widget.task.category);
    Color getColor = DummyData.getColor(context,localizeCategory(context,localizedCategory));
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SlidableListItem(
        onDelete:(){
         widget.taskBloc.add(DeleteTask(widget.task.id!));
        },
        onUpdate: () {
          widget.modalController.showModal(
            context,
            AddTaskWidget(modalController: widget.modalController, taskBloc: widget.taskBloc,task: widget.task,buildContext: context,),
          );
        },
        child:AnimatedContainer(
          decoration: BoxDecoration(
            color: Colors.white,
            border: direction==TextDirection.ltr?Border(
              left: BorderSide(
                color: getColor, // Border color
                width: AppWidth.s6, // Border width
              ),
            ):Border(
              right: BorderSide(
                color: getColor, // Border color
                width: AppWidth.s6, // Border width
              ),
            ),
            borderRadius: BorderRadius.circular(
                10.0), // Radius applied to all corners
          ),
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: (300 + (widget.index * 200)).toInt()),
          transform: Matrix4.translationValues(startAnimation ? 0 : screenWidth, 0, 0),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Use spaceBetween to separate the items
                        children: [
                          Flexible(
                            child: Text(
                              widget.task.title,
                              style: TextStyle(
                                fontSize: AppTextSize.s16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Gap(AppWidth.s10),
                          AppCircularCheckbox(
                            onChanged: (value) {
                              widget.taskBloc.add(UpdateIsCompleted(widget.task.id!, value!));
                            },
                            isChecked: widget.task.isCompleted,
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        widget.task.description,
                        style: TextStyle(
                          fontSize: AppTextSize.s14,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                     Gap(AppHeight.s10),
                     Divider(color: Colors.grey.shade200,height:0.5),
                      Gap(AppHeight.s10),
                     Row(
                        children: [
                          Icon(Icons.calendar_month,
                              size: AppWidth.s16),
                          SizedBox(width: 4.0),
                          Text(DateTimeUtility.stringConvertToDateLocalization(dateString: widget.task.date,parseCode: 'en'),style: TextStyle(fontSize: AppTextSize.s14, color: Colors.grey.shade600,fontWeight: FontWeight.w400)),

                          SizedBox(width: AppWidth.s16),
                          Icon(Icons.access_time, size: AppWidth.s16),
                          SizedBox(width: AppWidth.s4),
                          Text(DateTimeUtility.stringConvertToATimeLocalization(timeString: widget.task.time,parseCode: 'en'), style: TextStyle(fontSize: AppTextSize.s14, color: Colors.grey.shade600,fontWeight: FontWeight.w400)),

                          Spacer(),
                          Text(
                            localizedCategory,
                            style: TextStyle(fontSize: AppTextSize.s14,color: getColor,fontWeight: FontWeight.w500),
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
    if(category==AppKey.working){
      return context.text.working;
    }else if(category==AppKey.general){
      return context.text.general;
    }else if(category==AppKey.learning){
      return context.text.learning;
    }
    return category;
  }

  Color getColor(Set<WidgetStateProperty> states) {
    if (states.contains(WidgetState.selected)) {
      return Colors.transparent; // Color when checked
    }
    return AppColor.themeColor; // Color when unchecked
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
    return InkWell(
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

