

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/core/constant/app_color.dart';
import 'package:todo_app/core/constant/app_size.dart';
import 'package:todo_app/core/constant/app_text.dart';
import 'package:todo_app/presentation/task/ui/widgets/app_button.dart';

class AddTaskButtonSection extends StatelessWidget {

  final VoidCallback onCancelCallback;
  final VoidCallback onCreateCallBack;

  const AddTaskButtonSection({super.key, required this.onCancelCallback, required this.onCreateCallBack});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: SizedBox(
              width: double.infinity,
              child: AppButton(
                isBorder: true,
                borderColor: AppColor.buttonColor.withOpacity(.7),
                onPressed: onCancelCallback,
                backGroundColor: Colors.white,
                height: AppHeight.s40,
                label: AppText.cancel,
                labelColor: AppColor.buttonColor.withOpacity(.7),
              )),
        ),
        Gap(AppWidth.s20),
        Expanded(
          child: SizedBox(
              width: double.infinity,
              child: AppButton(
                  onPressed: onCreateCallBack,
                  backGroundColor: AppColor.buttonColor,
                  height: AppHeight.s40,
                  label: AppText.create,
                  labelColor: AppColor.windowBackgroundColor
              )),
        )
      ],
    );
  }
}
