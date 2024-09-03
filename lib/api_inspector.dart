import 'package:flutter/material.dart';
import 'package:flutter_alice/alice.dart';
import 'package:todo_app/core/flavor/flavor_config.dart';

class ApiInspector {
  final FlavorConfig flavorConfig;
  Alice? _alice;

  ApiInspector(this.flavorConfig) {
    if (isStaging) {
      _alice = Alice(showNotification: false);
    }
  }

  void init(GlobalKey<NavigatorState> navigatorKey) {
    if (isStaging) {
      _alice?.setNavigatorKey(navigatorKey);
    }
  }


  bool get isStaging {
    return flavorConfig.flavorType == FlavorType.staging;
  }

  void showApiInspector() {
    if (isStaging && _alice != null) {
      _alice!.showInspector();
    }
  }

}