import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/base/app_routes.dart';
import 'package:todo_app/core/base/device_info.dart';
import 'package:todo_app/core/constant/app_constants.dart';
import 'package:todo_app/core/constant/image_constants.dart';
import 'package:todo_app/main_common.dart';

import '../../../../core/utils/app_analytics_utils.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
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
      context.goNamed(AppRoutes.home.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _splashLogo
      ],
    );
  }

  Widget get _splashLogo {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(top: 157),
      child: Image(
        image: const AssetImage(ImageConstants.icSplashLogo),
        width: dimension.splashAppIconWidth,
        height: dimension.splashAppIconWidth,
      ),
    );
  }
}
