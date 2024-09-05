import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/core/constant/app_color.dart';
import 'package:todo_app/core/constant/app_size.dart';
import 'package:todo_app/core/di/injector.dart';
import 'package:todo_app/core/utils/app_context.dart';


@Injectable()
class AppCustomAlertManager {
  String? _message;
  bool _isError = false;
  bool _isCenterText = false;

  Flushbar? _flushbar;

  // Private constructor
  AppCustomAlertManager._internal();

  // Factory constructor to return the same instance
  factory AppCustomAlertManager() => _instance;

  static final AppCustomAlertManager _instance = AppCustomAlertManager._internal();

  static void setup(final injector) {
    injector.registerSingleton<AppCustomAlertManager>(_instance);
  }

  // Setter methods
  void setMessage(String? message) {
    _message = message;
  }

  void setIsError(bool isError) {
    _isError = isError;
  }

  void setIsCenterText(bool isCenterText) {
    _isCenterText = isCenterText;
  }


  Flushbar build() {
    _flushbar = Flushbar(
      icon: !_isError
          ? const Icon(
        Icons.check_circle,
        color: Colors.white,
      )
          : null,
      message: _message ?? "Something went wrong",
      padding: EdgeInsets.zero,
      messageText: Row(
        children: [
          if (_isError)
            SizedBox(
              width: AppWidth.s16,
            ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: AppHeight.s5),
              child: Text(
                _message!,
                maxLines: null,
                style: Theme.of(AppContext.context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Colors.white, height: 1),
              ),
            ),
          ),
        ],
      ),
      duration: Duration(seconds: 3),
      margin: REdgeInsets.all(15.0),
      isDismissible: false,
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.BOTTOM,
      messageColor: Colors.white,
      textDirection: Directionality.of(AppContext.context),
      boxShadows: [AppColor.kBackGroundShadow],
      borderRadius: BorderRadius.circular(AppRound.s5),
      backgroundColor: _isError ? AppColor.errorColor : Colors.green,
      mainButton: Padding(
        padding: EdgeInsets.all(AppWidth.s5),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(AppWidth.s100),
            onTap: () {
              dismiss();
            },
            child: Padding(
              padding: EdgeInsets.all(AppWidth.s5),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: AppWidth.s18,
              ),
            ),
          ),
        ),
      ),
    );

    return _flushbar!;
  }

  void show(BuildContext context) {
    if(_flushbar!=null&&_flushbar!.isShowing()){
      _flushbar!.dismiss();
      build().show(context);
    }else{
      build().show(context);
    }
  }

  void dismiss() {
    if(_flushbar!=null&&_flushbar!.isShowing()){
      _flushbar!.dismiss();
    }

  }
}

void showAlert({
  required String? message,
  bool isError = false,
  bool isCenterText = false,
}) {
  AppCustomAlertManager alertManager = injector();

  alertManager
    ..setMessage(message)
    ..setIsError(isError)
    ..show(AppContext.context);
}

void dismissExistingAlert(){
  AppCustomAlertManager alertManager = injector();
  alertManager.dismiss();

}