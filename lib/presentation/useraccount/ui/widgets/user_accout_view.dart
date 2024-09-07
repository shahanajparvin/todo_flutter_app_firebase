import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/core/base/app_settings.dart';
import 'package:todo_app/core/constant/app_color.dart';
import 'package:todo_app/core/constant/app_size.dart';
import 'package:todo_app/core/constant/image_constants.dart';
import 'package:todo_app/core/di/injector.dart';
import 'package:todo_app/core/managers/add_name_manager.dart';
import 'package:todo_app/core/utils/core_utils.dart';
import 'package:todo_app/presentation/useraccount/bloc/username_bloc.dart';

class UserAccountRoot extends StatelessWidget {
  const UserAccountRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UserNameBloc(), child: UserAccountView());
  }
}

class UserAccountView extends StatefulWidget {
  const UserAccountView({super.key});

  @override
  State<UserAccountView> createState() => _UserAccountViewState();
}

class _UserAccountViewState extends State<UserAccountView> {
  late String name;

  @override
  void initState() {
    super.initState();
    AppSettings appSettings = injector();
    name = appSettings.getName();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserNameBloc, UserNameState>(
      builder: (context, state) {
        return InkWell(
          splashColor: AppColor.themeColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            AddNameManager.showNameInputModal(context, isUpdate: true);
          },
          child: Container(
              margin: EdgeInsets.all(AppHeight.s10),
              alignment: Alignment.center,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppWidth.s5),
                  child: Row(children: [
                    Image(
                      image: const AssetImage(ImageConstants.icUser),
                      width: AppHeight.s40,
                      height: AppHeight.s40,
                    ),
                    Gap(AppWidth.s8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(context.text.hi,
                            
                            style: TextStyle(
                                fontSize: AppTextSize.s14, color: Colors.grey)),
                        Row(
                          children: [
                            Text(state.userName.isNotEmpty?state.userName:name,
                                style: TextStyle(
                                    fontSize: AppTextSize.s16, color: Colors.black)),
                          ],
                        )
                      ],
                    )
                  ]))),
        );
      },
    );
  }
}
