import 'dart:async';
// import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hike_it/session_helper.dart';
import 'package:hike_it/sign/sign_in.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hike_it/dashboard.dart';
import 'package:hike_it/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  } else {
    Firebase.app();
  }

  log('${message.data}');

  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: message.hashCode,
        channelKey: 'basic_channel',
        title: message.notification?.title ?? '',
        wakeUpScreen: true,
        body: message.notification?.body ?? '',
        notificationLayout: NotificationLayout.Default,
        payload: {'notification': 'value'}),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ));

  AwesomeNotifications().initialize(
      'resource://drawable/hiking',
      [
        NotificationChannel(
            channelGroupKey: 'basic_tests',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: const Color(0xFF9D50DD),
            ledColor: Colors.white,
            importance: NotificationImportance.High),
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupkey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  AwesomeNotifications().actionStream.listen((receivedNotification) {});

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(primarySwatch: Colors.purple, fontFamily: 'Nunito'),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    startListeningNotifications();
    nextRoute();
    super.initState();
  }

  void startListeningNotifications() async {
    if (!identical(0, 0.0)) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      // Your action
      if (message != null) {
        log("onIntial ${message.notification?.title}");
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      log('FCM-Message data: ${message.notification?.body}');
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: message.hashCode,
            channelKey: 'basic_channel',
            title: message.notification?.title ?? '',
            wakeUpScreen: true,
            body: message.notification?.body ?? '',
            notificationLayout: NotificationLayout.Default,
            payload: {'notification': 'value'}),
      );
      // log(Get.currentRoute);
    });

    // FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
  }

  void nextRoute() async {
    bool isLoggin = await SessionHelper.isLoggin();
    Timer(const Duration(seconds: 4),
        () => Get.offAll(() => isLoggin ? const Dashboard() : const SignIn()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/Splash_bg.png",
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          SizedBox(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: getHeight(150),
                  ),
                  SimpleShadow(
                    child: SvgPicture.asset("assets/images/Vertical_logo.svg"),
                  ),
                  SizedBox(
                    height: getHeight(40),
                  ),
                  const Text(
                    "Aplikasi Pendakian dan Perkemahan\nLumajang-Jember",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.5,
                      letterSpacing: 1,
                      fontWeight: normal,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "Versi 1.0",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: normal,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(30),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class SecondScreen extends StatelessWidget {
//   const SecondScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Dashboard();
//   }
// }
