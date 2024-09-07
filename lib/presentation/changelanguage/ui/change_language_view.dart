import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/base/app_settings.dart';
import 'package:todo_app/core/constant/app_color.dart';
import 'package:todo_app/core/constant/app_size.dart';
import 'package:todo_app/core/di/injector.dart';
import 'package:todo_app/core/utils/core_utils.dart';
import 'package:todo_app/core/utils/modal_controller.dart';
import 'package:todo_app/domain/entities/language.dart';
import 'package:todo_app/main_common.dart';
import 'package:todo_app/presentation/common/widgets/app_close_icon.dart';
import 'package:todo_app/presentation/lanuage/bloc/language_bloc.dart';
import 'package:todo_app/presentation/lanuage/bloc/language_event.dart';
import 'package:todo_app/presentation/task/ui/widgets/app_button.dart';

import '../../../../core/constant/image_constants.dart';

class ChangeLanguageView extends StatefulWidget {

  final ModalController modalController;

  const ChangeLanguageView({super.key, required this.modalController});

  @override
  State<StatefulWidget> createState() => ChangeLanguageViewState();
}

class ChangeLanguageViewState extends State<ChangeLanguageView> {
  Language selectedLanguage = Language.english;
  late final Function(Language) onLangChange;

  @override
  void initState() {
    super.initState();
    AppSettings appSettings = injector();
    selectedLanguage = appSettings.getSelectedLanguage();
    onLangChange = (changedLanguage) {
      setState(() {
        selectedLanguage = changedLanguage;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.symmetric(horizontal: AppWidth.s20,vertical: AppHeight.s20),
      child: Column(
        mainAxisSize : MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppCloseIcon(modalController: widget.modalController),
          _getTitle(),
          Gap(AppHeight.s25),
           Divider(
            height: .5,
            color: Colors.grey.shade300
          ),
          _getLanguageItem(
              language: Language.english,
              icon: ImageConstants.icEnLang,
              onChange: onLangChange),
          Divider(
              height: .5,
              color: Colors.grey.shade300
          ),
          _getLanguageItem(
              language: Language.arabic,
              icon: ImageConstants.icArabic,
              onChange: onLangChange),
          Divider(
              height: .5,
              color: Colors.grey.shade300
          ),
           Gap(AppHeight.s20),
          SizedBox(
            width: double.infinity,
            child: AppButton(
              label:  context.text.save,
              onPressed: () async {
                 print(selectedLanguage.toString());
                AppSettings appSettings = injector();
                Language lang =
                Language.getLanguageByCode((selectedLanguage.languageCode));
                await appSettings.setSelectedLanguage(lang);
                updateLocalization(lang);
                context
                    .bloc<LanguageBloc>()
                    .add(ChangeLanguage(selectedLanguage: lang));
                widget.modalController.closeModal(context);
                //GoRouter.of(context).pop(selectedLanguage.name);
              },
              backGroundColor: AppColor.themeColor,
              labelColor: Colors.white,
              height: AppHeight.s40,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getLanguageItem(
      {required Language language,
      required String icon,
      required Function(Language) onChange}) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          onChange(language);
        },
        child: Container(
          padding: const EdgeInsets.only(top: 8,bottom: 8),
          child: Row(
            children: [
              Image(
                image: AssetImage(icon),
                width: 40,
                height: 40,
              ),
              const Gap(16),
              Text(Language.getLocalizedLanguageName(context, language.languageCode),style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: AppTextSize.s14
              )),
              const Spacer(),
              if (selectedLanguage == language)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.check,
                    color: AppColor.themeColor,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTitle() {
    return Text(
      context.text.select_preferred_language,
      style: TextStyle(fontWeight: FontWeight.w500,fontSize: AppTextSize.s18),
    );
  }
}
