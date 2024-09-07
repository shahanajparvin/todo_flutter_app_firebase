import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/base/app_routes.dart';
import 'package:todo_app/core/base/app_settings.dart';
import 'package:todo_app/core/constant/app_color.dart';
import 'package:todo_app/core/constant/app_constants.dart';
import 'package:todo_app/core/constant/app_size.dart';
import 'package:todo_app/core/di/injector.dart';
import 'package:todo_app/core/managers/add_name_manager.dart';
import 'package:todo_app/core/utils/core_utils.dart';
import 'package:todo_app/core/utils/modal_controller.dart';
import 'package:todo_app/presentation/task/ui/widgets/app_button.dart';
import 'package:todo_app/presentation/task/ui/widgets/localization_icon.dart';

import '../../../../core/utils/app_analytics_utils.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  ModalController modalController = ModalController();
  AppSettings appSettings = injector();

  @override
  void initState() {
    super.initState();
    logSplashOpen();
      _startTimer();
  }

  void _startTimer() async {
    Timer(const Duration(milliseconds: kSplashTimeInMillis), () {
      if (!mounted) {
        return;
      }
      if(appSettings.getName().isNotEmpty)
        context.goNamed(AppRoutes.home.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: const BoxDecoration(color: AppColor.themeColor),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Gap(MediaQuery.of(context).viewPadding.top),
            if(!appSettings.getName().isNotEmpty)
              Row(children: [
                if (Directionality.of(context) == TextDirection.ltr) Spacer(),
                TranslateIcon(
                  color: Colors.white,
                  modalController: modalController,
                ),
                if (Directionality.of(context) == TextDirection.rtl) Spacer(),
              ]),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50.0,
                    child: Icon(
                      Icons.task_alt,
                      color: Colors.black,
                      size: AppHeight.s50,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: AppHeight.s20)),
                  Text(
                    context.text.welcome_todo_app,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppTextSize.s20,
                        color: Colors.black),
                  ),
                ],
              ),
            )
          ],
        ),
        if(!appSettings.getName().isNotEmpty)
          Container(
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.only(
                bottom: AppHeight.s30, right: AppWidth.s30, left: AppWidth.s30),
            child: Row(
              children: [
                if (Directionality.of(context) == TextDirection.ltr) Spacer(),
                AppButton(
                    onPressed: () {
                      AddNameManager.showNameInputModal(context);
                    },
                    isIcon: true,
                    labelColor: AppColor.themeColor,
                    backGroundColor: Colors.white,
                    height: AppHeight.s32,
                    label: context.text.next),
                if (Directionality.of(context) == TextDirection.rtl) Spacer(),
              ],
            ),
          )
      ],
    ));
  }


}
