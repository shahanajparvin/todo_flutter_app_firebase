import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

enum DeviceType {
  mobile,
  tablet,
}

Future<DeviceType> getDeviceType() async {
  if (Platform.isIOS) {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

    return iosInfo.model.toLowerCase() == "ipad" ? DeviceType.tablet : DeviceType.mobile;
  } else {
    // The equivalent of the "smallestWidth" qualifier on Android.
    //var shortestSide = MediaQuery.of(context).size.shortestSide;
    final firstView = WidgetsBinding.instance.platformDispatcher.views.first;
    final logicalShortestSide = firstView.physicalSize.shortestSide / firstView.devicePixelRatio;

    // Determine if we should use mobile layout or not, 600 here is
    // a common breakpoint for a typical 7-inch tablet.
    return logicalShortestSide > 600 ? DeviceType.tablet : DeviceType.mobile;
  }
}