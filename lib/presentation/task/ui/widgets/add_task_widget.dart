import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/constant/app_color.dart';
import 'package:todo_app/core/constant/app_size.dart';
import 'package:todo_app/core/constant/app_text.dart';
import 'package:todo_app/core/constant/pref_keys.dart';
import 'package:todo_app/core/date_time_utility.dart';
import 'package:todo_app/core/di/injector.dart';
import 'package:todo_app/core/utils/core_utils.dart';
import 'package:todo_app/core/utils/modal_controller.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/presentation/common/widgets/app_close_icon.dart';
import 'package:todo_app/presentation/task/bloc/task_bloc.dart';
import 'package:todo_app/presentation/task/bloc/task_event.dart';
import 'package:todo_app/presentation/task/ui/task_list_page.dart';
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
  final BuildContext? buildContext;

  const AddTaskWidget({super.key, required this.modalController, required this.taskBloc,  this.task,this.buildContext});

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _dateController = TextEditingController();

  final TextEditingController _timeController = TextEditingController();

  final _titleKey = GlobalKey<FormFieldState<String>>();

  final _formKey = GlobalKey<FormState>();

  final _descriptionKey = GlobalKey<FormFieldState<String>>();

  final _dateKey = GlobalKey<FormFieldState<String>>();

  final _timeKey = GlobalKey<FormFieldState<String>>();

   String? _selectedValue;

  @override
  void initState() {
    super.initState();

    if(widget.task!=null){
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _dateController.text = DateTimeUtility.stringConvertToDateLocalization(dateString: widget.task!.date,parseCode: 'en');
      _timeController.text = DateTimeUtility.stringConvertToATimeLocalization(timeString: widget.task!.time,parseCode: 'en');
      _selectedValue = localizeCategory(widget.buildContext!,widget.task!.category);
    }
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
                  AppCloseIcon(modalController: widget.modalController),
                  Gap(AppHeight.s20),
                  TextInputField(
                    maxLength: 50,
                    textFieldKey: _titleKey,
                    label: context.text.title_task,
                    inputController: _titleController,
                    hintText: context.text.title_hint,
                    errorText: context.text.title_error,
                  ),
                  Gap(AppHeight.s20),
                  TextInputField(
                    maxLength: 150,
                    textFieldKey: _descriptionKey,
                    label: context.text.description,
                    inputController: _descriptionController,
                    hintText:context.text.description,
                    maxLine: 4,
                  ),
                  Gap(AppHeight.s20),
                  CategorySectionWidget(
                    selectedValue: _selectedValue!=null?_selectedValue:null,
                    buildContext: context,
                    onValueChanged: (value){
                      _selectedValue = value!;
                    },

                  ),
                  Gap(AppHeight.s20),
                  Row(children: [
                    DateInputWidget(dateController:_dateController,
                    textFieldKey: _dateKey,
                    ),
                    Gap(AppWidth.s20),
                    TimeInputWidget(timeController: _timeController,textFieldKey: _timeKey,)
                  ]),
                  Gap(AppHeight.s20),

                  AddTaskButtonSection(
                    buttonLabel: widget.task!=null?context.text.update:context.text.create,
                    onCancelCallback: (){
                      widget.modalController.closeModal(context);
                    },
                    onCreateCallBack: (){
                      if(_formKey.currentState!.validate()){
                        if(widget.task!=null){
                          final task = Task(
                              id: widget.task!.id,
                              title: _titleController.text,
                              description: _descriptionController.text,
                              date: DateTimeUtility.stringConvertToDateLocalization(dateString: _dateController.text,lanCode: 'en'),
                              time: DateTimeUtility.stringConvertToATimeLocalization(timeString: _timeController.text,lanCode: 'en'),
                              isCompleted: widget.task!.isCompleted,
                              category: _selectedValue!=null?deLocalizeCategory(context,_selectedValue!):'');
                          _updateTask(task);
                        }else{
                          final task = Task(
                              title: _titleController.text,
                              description: _descriptionController.text.isNotEmpty? _descriptionController.text:'',
                              date: DateTimeUtility.stringConvertToDateLocalization(dateString: _dateController.text,lanCode: 'en'),
                              time: DateTimeUtility.stringConvertToATimeLocalization(timeString: _timeController.text,lanCode: 'en'),
                              isCompleted: false,
                              category: _selectedValue!=null?deLocalizeCategory(context,_selectedValue!):'');
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
    widget.taskBloc.add(
        UpdateTask(
            task.id!, task));
    widget.modalController.closeModal(context);
  }

  String deLocalizeCategory(BuildContext context, String category){
    if(category==context.text.working){
      return AppKey.working;
    }else if(category==context.text.general){
      return AppKey.general;
    }else if(category==context.text.learning){
      return AppKey.learning;
    }
    return AppKey.general;
  }

  Widget _getTitle() {
    return Text(
      context.text.new_task,
      style: TextStyle(fontWeight: FontWeight.w500,fontSize: AppTextSize.s18),
    );
  }


}
