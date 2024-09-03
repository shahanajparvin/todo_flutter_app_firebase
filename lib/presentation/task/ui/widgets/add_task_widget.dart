import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/constant/app_color.dart';
import 'package:todo_app/core/constant/app_size.dart';
import 'package:todo_app/core/constant/app_text.dart';
import 'package:todo_app/core/di/injector.dart';
import 'package:todo_app/core/utils/core_utils.dart';
import 'package:todo_app/core/utils/modal_controller.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/presentation/task/bloc/task_bloc.dart';
import 'package:todo_app/presentation/task/bloc/task_event.dart';
import 'package:todo_app/presentation/task/ui/task_list_new.dart';
import 'package:todo_app/presentation/task/ui/widgets/add_task_button_section.dart';
import 'package:todo_app/presentation/task/ui/widgets/app_button.dart';
import 'package:todo_app/presentation/task/ui/widgets/category_section_widget.dart';
import 'package:todo_app/presentation/task/ui/widgets/date_input_widget.dart';
import 'package:todo_app/presentation/task/ui/widgets/text_input_field.dart';
import 'package:todo_app/presentation/task/ui/widgets/time_input_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class AddTaskWidget extends StatefulWidget {
  final ModalController modalController;
  final TaskBloc taskBloc;
  final Task? task;

  const AddTaskWidget({super.key, required this.modalController, required this.taskBloc,  this.task});

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _dateController = TextEditingController();

  final TextEditingController _timeController = TextEditingController();

  final _titlekey = GlobalKey<FormFieldState<String>>();

  final _formKey = GlobalKey<FormState>();

  final _descriptionKey = GlobalKey<FormFieldState<String>>();

  late String _selectedValue;

  @override
  void initState() {
    super.initState();

    if(widget.task!=null){
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _dateController.text = widget.task!.date;
      _timeController.text = widget.task!.time;
      _selectedValue = widget.task!.category;
    }


  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom, // Adjust padding for keyboard
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Padding(
               padding: EdgeInsets.symmetric(
                  horizontal: AppWidth.s30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment : CrossAxisAlignment.start,
                // This will force the Column to take up all available vertical space
                children: [
                  Gap(AppHeight.s25),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Material(
                      shape: CircleBorder(),
                      color: Colors.grey.shade300,
                      child: InkWell(
                        splashColor: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(100),
                        onTap: (){
                          widget.modalController.closeModal(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                  Gap(AppHeight.s25),
                  TextInputField(
                    textFieldKey: _titlekey,
                    label: AppText.title,
                    inputController: _titleController,
                    hintText: AppText.titleHint,
                    errorText: AppText.titleError,
                  ),
                  Gap(AppHeight.s20),
                  TextInputField(
                    textFieldKey: _descriptionKey,
                    label: AppText.description,
                    inputController: _descriptionController,
                    hintText: AppText.description,
                    maxLine: 4,
                  ),
                  Gap(AppHeight.s20),
                  CategorySectionWidget(
                    onValueChanged: (value){
                      _selectedValue = value!;
                    },
                  ),
                  Gap(AppHeight.s20),
                  Row(children: [
                    DateInputWidget(dateController:_dateController),
                    Gap(AppWidth.s20),
                    TimeInputWidget(timeController: _timeController,)
                  ]),
                  Gap(AppHeight.s20),

                  AddTaskButtonSection(
                    onCancelCallback: (){
                      widget.modalController.closeModal(context);
                    },
                    onCreateCallBack: (){

                      if(_formKey.currentState!.validate()){


                        if(widget.task!=null){
                          print('============task '+ widget.task!.date.toString());
                          final task = Task(
                              id: widget.task!.id,
                              title: _titleController.text,
                              description: _descriptionController.text,
                              date: _dateController.text,
                              time: _timeController.text,
                              isCompleted: widget.task!.isCompleted,
                              category: _selectedValue);
                          _updateTask(task);
                        }else{
                          final task = Task(
                              title: _titleController.text,
                              description: _descriptionController.text,
                              date: _dateController.text,
                              time: _timeController.text,
                              isCompleted: false,
                              category: _selectedValue);
                          _addTask(task);
                        }
                      }

                    },
                  ),
                  Gap(AppHeight.s30),
                ],
              ),
            )),
          )),
    );
  }
  _addTask(Task newTask){
    widget.taskBloc.add(AddTask(newTask));
    widget.modalController.closeModal(context);
  }


  _updateTask(Task task){
    print('sdfsdfsd '+ task.id.toString());
    widget.taskBloc.add(
        UpdateTask(
            task.id!, task));
    widget.modalController.closeModal(context);
  }


}
