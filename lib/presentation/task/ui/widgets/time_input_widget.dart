

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/constant/app_text.dart';
import 'package:todo_app/core/utils/core_utils.dart';
import 'package:todo_app/core/utils/language_code_utility.dart';
import 'package:todo_app/presentation/task/ui/widgets/text_input_field.dart';

class TimeInputWidget extends StatelessWidget {

  final TextEditingController timeController;

  const TimeInputWidget({super.key, required this.timeController});

  @override
  Widget build(BuildContext context) {
    return  Flexible(
        child: TextInputField(
          icon: Icons.schedule,
          label: context.text.time,
          inputController: timeController,
          hintText: context.text.time_hint,
          readOnly: true,
          errorText: context.text.time_error,
          onTap: (){
            _selectTime(context);
          },
        ));
  }


  TimeOfDay _getTimeFromController() {
    final text = timeController.text;
    if (text.isNotEmpty) {
      // Parse the time using the DateFormat
      final dateTime = DateFormat('hh:mm a',LangUtility.getLanCode()).parse(text);
      return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
    } else {
      // If the controller is empty, use the current time
      return TimeOfDay.now();
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final initialTime = _getTimeFromController();

    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: initialTime,
        initialEntryMode : TimePickerEntryMode.input
    );

    if (picked != null) {
      final now = DateTime.now();
      final selectedTime = DateTime(now.year, now.month, now.day, picked.hour, picked.minute);

      final formattedTime = DateFormat('hh:mm a',LangUtility.getLanCode()).format(selectedTime);
      timeController.text = formattedTime;
    }
  }
}
