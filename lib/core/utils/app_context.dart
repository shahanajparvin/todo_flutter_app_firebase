

import 'package:flutter/material.dart';

class AppContext {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext context = navigatorKey.currentContext!;
  static Object? argument = ModalRoute
      .of(context)!
      .settings
      .arguments;
  static GlobalKey key = GlobalKey();

}