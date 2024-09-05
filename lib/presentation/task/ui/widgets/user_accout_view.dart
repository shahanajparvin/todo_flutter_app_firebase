import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/core/constant/app_size.dart';
import 'package:todo_app/core/constant/image_constants.dart';
import 'package:todo_app/core/utils/core_utils.dart';

class UserAccountView extends StatelessWidget {
  const UserAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child:Padding(
            padding:  EdgeInsets.symmetric(horizontal:AppWidth.s5),
            child:Row(children: [
              Image(
                image: const AssetImage(ImageConstants.icUser),
                width: AppHeight.s40,
                height:  AppHeight.s40,
              ),
              Gap(AppWidth.s8),
              Column(
                crossAxisAlignment : CrossAxisAlignment.start,
                children: [
                  Text( context.text.hi,style: TextStyle(fontSize: AppTextSize.s14,color: Colors.grey)),
                  Text('Shahanaj Parvin',style: TextStyle(fontSize: AppTextSize.s16,color: Colors.black))
                ],)
            ],)));
  }
}
