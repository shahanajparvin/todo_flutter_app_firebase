import 'package:flutter/material.dart';
import 'package:todo_app/core/constant/app_color.dart';
import 'package:todo_app/core/utils/app_context.dart';
import 'package:todo_app/core/utils/core_utils.dart';

class DummyData{


  static Map<String, Color> getCategories(BuildContext context) {
    Map<String, Color> categories = {
      (context.text.general).trim(): Colors.green,
      (context.text.learning).trim(): Colors.blue,
      (context.text.working).trim(): Colors.amber,
    };
    return categories;
  }


  static Color getColor(BuildContext context,String category) {
    return getCategories(context)[category.trim()] ?? AppColor.themeColor; // Default color if category is not found
  }
}


