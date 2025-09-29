// import 'package:agora_rtc_engine/rtc_engine.dart';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:lawyer_consultant/firebase_options.dart';
import 'package:lawyer_consultant/src/controllers/logged_in_user_controller.dart';
import 'package:lawyer_consultant/src/controllers/themes_controller.dart';
import 'package:lawyer_consultant/src/repositories/all_settings_repo.dart';
import 'package:lawyer_consultant/src/repositories/get_themes_repo.dart';
import 'package:lawyer_consultant/src/screens/agora_call/agora_logic.dart';
import 'package:resize/resize.dart';
// import 'firebase_options.dart';
import 'multi_language/languages.dart';
import 'src/api_services/get_service.dart';
import 'src/api_services/logic.dart';
import 'src/api_services/urls.dart';
import 'src/controllers/all_languages_controller.dart';
import 'src/controllers/all_settings_controller.dart';
import 'src/controllers/general_controller.dart';
import 'src/controllers/pusher_beams_controller.dart';
import 'src/controllers/search_controller.dart';
import 'src/repositories/all_languages_repo.dart';
import 'src/repositories/main_repo/main_logic.dart';
import 'src/routes.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'private-make-agora-call', // id
    'High Importance Notifications', // title
    // 'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  // ALL GOOD
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Get.put(ApiController());
  Get.put(GetAllSettingsController());
  Get.put(GetThemesController());
  Get.put(GetAllLanguagesController());
  Get.put(GeneralController());
  Get.put(LoggedInUserController());
  Get.put(PusherBeamsController());

  Get.put(SearchBarController());
  Get.put(MainLogic());
  Get.put(AgoraLogic());
  //-----load-configurations-from-local-json
  try {
    await GlobalConfiguration().loadFromUrl(getAllSettingUrl);
    log("Working");
  } catch (e) {
    log("Error");
    // something went wrong while fetching the config from the url ... do something
  }

  runApp(
    const MyApp(),
  );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(channel.id, channel.name,
              // channel.description,
              importance: Importance.high,
              priority: Priority.high,
              // color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher'),
        ),
      );
    }
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    super.initState();
    // Get All Settings
    getMethod(context, getAllSettingUrl, null, true, getAllSettingsRepo);
    // Get Themes
    getMethod(context, getThemesUrl, null, false, getThemesRepo);
    // Get All Languages
    getMethod(context, getAllLanguagesUrl, null, true, getAllLanguagesRepo);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // LocalNotificationService.initialize(context);
    return Resize(
      allowtextScaling: true,
      size: const Size(375, 812),
      builder: () {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          translations: LanguagesChang(),
          title: 'Law Advisor - Customer',
          initialBinding: BindingsBuilder(() {}),
          locale: Locale(
              '${Get.find<GeneralController>().storageBox.read('languageCode')}',
              '${Get.find<GeneralController>().storageBox.read('countryCode')}'),
          fallbackLocale: Locale(
              '${Get.find<GeneralController>().storageBox.read('languageCode')}',
              '${Get.find<GeneralController>().storageBox.read('countryCode')}'),
          theme: ThemeData(),
          initialRoute: PageRoutes.splashScreen,
          getPages: appRoutes(),
        );
      },
    );
  }
}
