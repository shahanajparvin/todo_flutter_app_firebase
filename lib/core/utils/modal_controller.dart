import 'package:flutter/material.dart';
import 'package:todo_app/core/constant/app_color.dart';

// ModalController to manage showing, closing, and switching modals
class ModalController {
  // Show a new modal
  void showModal(BuildContext context, Widget modalContent) {

    showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: false,
      context: context,
      builder: (context) => modalContent,
    );
  }

  // Close the current modal
  void closeModal(BuildContext context) {
    Navigator.pop(context);
  }

  void switchModal(BuildContext context, Widget newModalContent) {
    Future.delayed(Duration(milliseconds: 500), () {
      showModal(context, newModalContent); // Open the new modal
    });
  }
}
