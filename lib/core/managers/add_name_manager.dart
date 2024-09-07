
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/base/app_routes.dart';
import 'package:todo_app/core/base/app_settings.dart';
import 'package:todo_app/core/di/injector.dart';
import 'package:todo_app/core/utils/modal_controller.dart';
import 'package:todo_app/presentation/common/widgets/add_name_widget.dart';
import 'package:todo_app/presentation/useraccount/bloc/username_bloc.dart';

class AddNameManager{

  static void showNameInputModal(BuildContext context,{bool isUpdate = false}) {
    ModalController modalController = ModalController();
    modalController.showModal(
        context,
        AddNameWidget(
          isUpdate: isUpdate,
            modalController: modalController,
            onCallBack: (name) {
              AppSettings appSettings = injector();
              appSettings.setName(name);
              if(isUpdate)
                context.read<UserNameBloc>().add(UpdateUserName(name));
              if(isUpdate){
                Navigator.of(context).pop();
              }else{
                context.goNamed(AppRoutes.home.name);
              }
          }));
  }

}