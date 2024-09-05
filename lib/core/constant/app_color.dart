import 'package:flutter/material.dart';

class AppColor {
  AppColor._();


  static const Color backgroundWhite = Colors.white;
  static const Color background = Color(0xffF7FCFF);
  static const Color backgroundLightRed = Color(0xffFFDDDF);
  static const Color splashBackground = Color.fromARGB(255, 255, 237, 225);
  static const Color loginShadowColor = Color.fromARGB(255, 243, 220, 204);
  static const Color textFieldFillColor = Color(0x80F6F8FB);
  static const Color textColorBlack = Colors.black;
  static const Color textFieldHintsColor = Color(0x80000000);
  static const Color loginSubtextColor = Colors.black45;
  static const Color featureBorderColor = Color(0xFFDDDDDD);
  static const Color homeDividerColor = Color(0x80DDDDDD);
  static const Color transparent = Color(0x00FFFFFF);
  static const Color titleColor = Colors.black;
  static const Color subtitleColor = Color(0xFF5E6266);
  static const Color shimmerColor = Color(0xFFE6E7F2);
  static const Color windowBackgroundColor = Color(0xFFF9F9FF);
  static const Color bottomNavigationBackgroundColor = Color(0xFFECEDF8);
  static const Color tabSelectionColor = Color(0xFFBCD0FF);
  static const Color appBarColor = Color(0xFFECEDF8);
  static const Color themePrimaryColor = Color(0xFF004CA7);
  static const Color avatarBackgroundColor = Color(0xFF1DA0F1);
  static const Color themeSecondaryContainerColor = Color(0xFFBCD0FF);
  static const Color surfaceContainer = Color(0xFFECEDF8);
  static const Color gray600 = Color(0xFF545454);
  static const Color readTextColor = Color(0xFF006C3F);
  static const Color readTagColor = Color(0xFF9FF1C8);
  static const Color caseDividerColor = Color(0xFF8591AE);
  static const Color textThemeColor =  Color(0xFF424754);



  static const Color themeColor = Color(0xff6092DF);

  static const Color themeColor2= Color(0xff007dff);

  static const Color themeColor1 = Color(0xff9DCDFF);

  static const Color darkBlue = Color(0xff1D2823);

  static const Color hintColor = Color(0xffB0B0B0);

  static const Color errorColor = Color(0xFFBA1A1A);

  static const Color whiteColor = Color(0xFFFFFFFF);

  static const Color buttonColor = Colors.blue;


  static const Color inputBoxColor = Color(0xFFE5E5E5);

  static const Color deleteBgColor = Color(0xffFFDAD7);

  static final kBackGroundShadow = BoxShadow(
    color: const Color(0xFFABB0AC).withOpacity(0.25),
    blurRadius: 70,
    offset: const Offset(0, 4),
    spreadRadius: 0,
  );




}

extension ContextExtension on BuildContext {
  ColorScheme themeColorScheme() {
    return Theme.of(this).brightness == Brightness.light
        ? Theme.of(this).colorScheme
        : ThemeData.light().colorScheme;
  }
}
