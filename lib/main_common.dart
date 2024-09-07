import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:todo_app/api_inspector.dart';
import 'package:todo_app/core/base/app_settings.dart';
import 'package:todo_app/core/base/device_info.dart';
import 'package:todo_app/core/base/dimension_ipad.dart';
import 'package:todo_app/core/base/dimensions.dart';
import 'package:todo_app/core/base/dimensions_mobile.dart';
import 'package:todo_app/core/constant/app_color.dart';
import 'package:todo_app/core/constant/app_text.dart';
import 'package:todo_app/core/constant/pref_keys.dart';
import 'package:todo_app/core/di/dependencies.dart';
import 'package:todo_app/core/flavor/flavor_config.dart';
import 'package:todo_app/core/services/task_sync_service.dart';
import 'package:todo_app/core/services/workmanager_services.dart';
import 'package:todo_app/core/utils/internet_connection_checker.dart';
import 'package:todo_app/core/utils/sharedpreferences_helper.dart';
import 'package:todo_app/data/datasources/local/local_data_source.dart';
import 'package:todo_app/data/datasources/remote/remote_data_source.dart';
import 'package:todo_app/domain/entities/language.dart';
import 'package:todo_app/presentation/lanuage/bloc/language_bloc.dart';
import 'package:todo_app/presentation/lanuage/bloc/language_state.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/di/injector.dart';
import 'firebase_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as screenutil;

// main.dart
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';


late FlavorConfig flavorConfig;
late Dimension dimension;

late DeviceType deviceType;
double screenWidth = 0;
double screenHeight = 0;

late AppLocalizations localizations;
late ApiInspector apiInspector;

void mainCommon(FlavorConfig config) async {
  flavorConfig = config;
  await init();
  runApp(const MyApp());
}



void updateLocalization(Language language) async {
  localizations = await AppLocalizations.delegate.load(language.locale);
}


Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  apiInspector = ApiInspector(flavorConfig);
  await initFirebase();
  deviceType = await getDeviceType();
  dimension = deviceType == DeviceType.mobile ? DimensionsMobile() : DimensionIPad();
  await DependencyManager.inject(flavorConfig);
  SharedPreferencesHelper preferencesHelper = injector();
  await preferencesHelper.init();
  BackgroundTaskSycServices.initService();
}



Future<void> initFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = (errorDetails) {
   // FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
   // FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppSettings appSettings = injector();
      updateLocalization(appSettings.getSelectedLanguage());
    });
  }




  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _getProviders(),
      child:_buildAppWithLanguage(),

    );
  }

  List<BlocProvider> _getProviders() {
    AppSettings appSettings = injector();
    return [
      BlocProvider<LanguageBloc>(
        create: (context) => LanguageBloc(appSettings.getSelectedLanguage()),
      ),

    ];
  }



    Widget _buildAppWithLanguage() {

      return BlocProvider(
        create: (context) =>
            LanguageBloc(injector<AppSettings>().getSelectedLanguage()),
        child: BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, state) => _buildScreenUtilInit(state),
        ),
      );
    }

  Widget _buildScreenUtilInit(LanguageState state) {
    return screenutil.ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => _buildMaterialApp(state),
    );
  }

  Widget _buildMaterialApp(LanguageState state) {
    GoRouter router = injector();
    apiInspector.init(router.routerDelegate.navigatorKey);

    return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: state.selectedLanguage.locale,
      builder: (BuildContext context,  child) {
        EasyLoading.instance
          ..maskType = EasyLoadingMaskType.custom
          ..displayDuration = const Duration(milliseconds: 1)
          ..indicatorType = EasyLoadingIndicatorType.fadingCircle
          ..loadingStyle = EasyLoadingStyle.custom
          ..indicatorSize = 45.0
          ..radius = 5.0
          ..progressColor = Colors.yellow
          ..backgroundColor = AppColor.whiteColor
          ..indicatorColor =  AppColor.themeColor
          ..textColor = AppColor.themeColor
          ..maskColor = Colors.black.withOpacity(0.7)
          ..userInteractions = false;

        return FlutterEasyLoading(child: child);
      },
        );
  }
}
