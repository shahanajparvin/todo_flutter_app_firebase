import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/core/base/app_settings.dart';
import 'package:todo_app/core/constant/app_color.dart';
import 'package:todo_app/core/constant/app_size.dart';
import 'package:todo_app/core/di/injector.dart';
import 'package:todo_app/core/utils/core_utils.dart';
import 'package:todo_app/core/utils/modal_controller.dart';
import 'package:todo_app/presentation/common/widgets/app_close_icon.dart';
import 'package:todo_app/presentation/task/ui/widgets/app_button.dart';
import 'package:todo_app/presentation/task/ui/widgets/text_input_field.dart';

class AddNameWidget extends StatefulWidget {
  final ModalController modalController;
  final Function(String) onCallBack;
  final bool isUpdate;


  const AddNameWidget(
      {super.key, required this.modalController, required this.onCallBack, required this.isUpdate});

  @override
  State<AddNameWidget> createState() => _AddNameWidgetState();
}

class _AddNameWidgetState extends State<AddNameWidget> {
  late TextEditingController nameController;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    AppSettings  appSettings = injector();
    nameController.text = appSettings.getName();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(AppHeight.s30),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          AppCloseIcon(modalController: widget.modalController),
          Gap(AppHeight.s20),
          Form(
              key: _formKey,
              child: TextInputField(
                maxLength: 25,
                label: context.text.name,
                inputController: nameController,
                hintText: context.text.enter_name,
                errorText: context.text.title_error,
              )),
          Gap(AppHeight.s20),
          Row(children: [
            AppButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onCallBack(nameController.text);
                  }
                },
                labelColor: AppColor.windowBackgroundColor,
                backGroundColor: AppColor.themeColor,
                height: AppHeight.s32,
                label: widget.isUpdate?context.text.update:context.text.save),
          ])
        ]));
  }
}
