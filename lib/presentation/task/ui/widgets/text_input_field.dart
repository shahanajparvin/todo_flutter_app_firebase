

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/core/constant/app_color.dart';
import 'package:todo_app/core/constant/app_constants.dart';
import 'package:todo_app/core/constant/app_size.dart';
import 'package:todo_app/core/constant/app_text.dart';
import 'package:todo_app/core/utils/core_utils.dart';

class TextInputField extends StatelessWidget {

  final GlobalKey<FormFieldState<String>>? textFieldKey;
  final TextEditingController inputController;
  final String  hintText;
  final String label;
  final int maxLine;
  final IconData? icon;
  final bool readOnly;
  final GestureTapCallback? onTap;
  final String? errorText;
  final TextInputAction? textInputAction;


  const TextInputField({super.key, this.textFieldKey, required this.inputController, required this.hintText, required this.label,this.maxLine = 1, this.icon,  this.readOnly = false, this.onTap, this.errorText, this.textInputAction});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize : MainAxisSize.min,
      crossAxisAlignment : CrossAxisAlignment.start,
      children: [
        Text(label,
            style: context.textTheme.displaySmall!.copyWith(
                fontSize: AppTextSize.s15, fontWeight: FontWeight.w500)),
        Gap(AppHeight.s10),
        SizedBox(
          child: TextFormField(
            textInputAction: textInputAction ?? TextInputAction.next,
            key: textFieldKey,
            onEditingComplete: (){
              if(textFieldKey!=null)
              textFieldKey!.currentState!.validate();
            },
            style: context.textTheme.bodyLarge?.copyWith(
                color: AppColor.darkBlue,
                fontSize: AppTextSize.s14,
                fontWeight: FontWeight.w400),
            controller: inputController,
            maxLines: maxLine,
            readOnly: readOnly,
            onTap: onTap,
            decoration: InputDecoration(
              prefixIcon: icon!=null?Icon(icon,color: AppColor.hintColor,size: AppWidth.s20,):null,
              contentPadding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 16), // Adjust padding as needed
              hintText: hintText,
              hintStyle: context.textTheme.bodyLarge?.copyWith(
                  color: AppColor.hintColor,
                  fontSize: AppTextSize.s14,
                  fontWeight: FontWeight.w400),
              errorStyle: context.textTheme.bodyLarge?.copyWith(
                  color: AppColor.errorColor,
                  fontSize: AppTextSize.s13,
                  fontWeight: FontWeight.w400),
              fillColor: Colors.grey.shade200,
              filled: true,

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: Colors.transparent),),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: Colors.transparent),),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: AppColor.errorColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: AppColor.errorColor,
                ),
              ),

            ),
            validator: errorText!=null?(value) {
              print('----valid ');
              if (value == null || value.isEmpty) {
                return errorText;
              }
              return null;
            }:null,
          ),
        ),
      ],
    );
  }
}
