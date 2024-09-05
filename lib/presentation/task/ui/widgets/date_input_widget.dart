

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/base/app_settings.dart';
import 'package:todo_app/core/constant/app_text.dart';
import 'package:todo_app/core/di/injector.dart';
import 'package:todo_app/core/utils/core_utils.dart';
import 'package:todo_app/core/utils/language_code_utility.dart';
import 'package:todo_app/domain/entities/language.dart';
import 'package:todo_app/presentation/task/ui/widgets/text_input_field.dart';

class DateInputWidget extends StatelessWidget {

  final TextEditingController dateController;

  const DateInputWidget({super.key, required this.dateController});

  @override
  Widget build(BuildContext context) {
    return  Flexible(
        child: TextInputField(
          icon: Icons.calendar_month,
          label: context.text.date,
          inputController: dateController,
          hintText: context.text.date_hint,
          readOnly: true,
          errorText: context.text.date_error,
          onTap: (){
            _selectDate(context);
          },
        ));
  }


  Future<void> _selectDate(BuildContext context) async {
    DateTime? initialDate;
    try {
      initialDate = DateFormat('dd/MM/yy',LangUtility.getLanCode()).parse(dateController.text);
    } catch (e) {
      initialDate = DateTime.now(); // Fallback to current date if parsing fails
    }
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      AppSettings appSettings = injector();
      Language selectedLanguage = appSettings.getSelectedLanguage();
      dateController.text = DateFormat('dd/MM/yy',selectedLanguage.languageCode).format(picked);
    }
  }
}
