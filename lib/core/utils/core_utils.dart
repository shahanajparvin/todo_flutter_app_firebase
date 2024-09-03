import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../main_common.dart';

void runAfter({required int milliSeconds, required void Function() callback}) {
  Timer(Duration(milliseconds: milliSeconds), () {
    callback.call();
  });
}

extension LocalizationExtension on BuildContext {
  AppLocalizations get text => AppLocalizations.of(this)!;
}

extension BlocExtension on BuildContext {
  T bloc<T extends BlocBase<dynamic>>() => read<T>();
}

extension TextThemeExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension ColorhemeExtension on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}

extension ThemeExtensions on BuildContext {
  //TextTheme get textTheme => Theme.of(this).textTheme;

  //ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextStyle textStyleWithColor(TextStyle? textStyle, Color color) =>
      textStyle!.copyWith(color: color);
}

