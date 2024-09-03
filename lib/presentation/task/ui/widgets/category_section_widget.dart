import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/core/constant/app_size.dart';
import 'package:todo_app/core/constant/app_text.dart';
import 'package:todo_app/core/utils/core_utils.dart';

class CategorySectionWidget extends StatefulWidget {
  final String? selectedValue;
  final ValueChanged<String?> onValueChanged;

  CategorySectionWidget({required this.onValueChanged, this.selectedValue});

  @override
  _CategorySectionWidget createState() => _CategorySectionWidget();
}

class _CategorySectionWidget extends State<CategorySectionWidget> {
  String? _selectedValue;

  Map<String, Color> categories = {
    'General': Colors.green,
    'Learning': Colors.blue,
    'Working': Colors.amber,
  };

  @override
  void initState() {
    super.initState();
    // Set default value if none is selected
    if(widget.selectedValue!=null){
      _selectedValue = widget.selectedValue;
    }else {
      _selectedValue = categories.keys.first;
      widget.onValueChanged(_selectedValue); // Call the callback with default value
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppText.category,
            style: context.textTheme.displaySmall!.copyWith(
                fontSize: AppTextSize.s15, fontWeight: FontWeight.w500)),
        Gap(AppHeight.s5),
        Wrap(
          spacing: 16.0, // Horizontal spacing between widgets
          runSpacing: 8.0, // Vertical spacing between widgets
          children: categories.entries.map((entry) {
            return AppRadio(
              value: entry.key,
              customColor: entry.value,
              selectedValue: _selectedValue,
              onValueChanged: (String value) {
                setState(() {
                  _selectedValue = value;
                });
                widget.onValueChanged(_selectedValue); // Call the callback with updated value
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}




class AppRadio extends StatelessWidget {

  final String value;
  final Color customColor;
  final String? selectedValue;
  final ValueChanged<String> onValueChanged;

  AppRadio({

    required this.value,
    required this.customColor,
    required this.selectedValue,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      splashColor: Colors.blue.withOpacity(0.3),
      onTap: () {
        onValueChanged(value);
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisSize : MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 20.0,
              height: 20.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: customColor,
                  width: 2.0,
                ),
                color: Colors.white,
              ),
              child: selectedValue == value
                  ? Center(
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: customColor,
                  ),
                ),
              )
                  : null,
            ),
            SizedBox(width: 8.0),
            Text(
              value,
              style: TextStyle(color: customColor, fontSize: AppTextSize.s14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
