import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app/core/utils/app_loading_indicatore.dart';

void showLoadingIndicator() {
  EasyLoading.show(
    indicator: AppLoadingIndicator(),
  );
}

void dismissLoadingIndicator() {
  EasyLoading.dismiss();
}

demoLoading() async {
  showLoadingIndicator();
  await Future.delayed(const Duration(seconds: 3)); // Simulate a network delay
  dismissLoadingIndicator();
}
