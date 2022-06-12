import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/auth/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/auth/auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:untitled1/splash.dart';

const AndroidNotificationChannel channel1 = AndroidNotificationChannel(
    'High importance channel', 'Hight importance notification',
    description: 'This channel is used for important notifications',
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin notifications =
    FlutterLocalNotificationsPlugin();
Future<void> firebaseMessagingBackground(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A background message showed up : ${message}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackground);
  await notifications
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel1);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage messeage) {
      RemoteNotification? notification = messeage.notification;
      AndroidNotification? android = messeage.notification?.android;
      if (notification != null && android != null) {
        notifications.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(channel1.id, channel1.name,
                    channelDescription: channel1.description,
                    playSound: true,
                    icon: '@mipmap/ic_launcher')));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage messeage) {
      RemoteNotification? notification = messeage.notification;
      AndroidNotification? android = messeage.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (BuildContext) {
              return AlertDialog(
                title: AutoSizeText('${notification.title}'),
                content: AutoSizeText('${notification.body}'),
              );
            });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      value: AuthService().user,
      initialData: null,
      catchError: (e, i) => null,
      child: ScreenUtilInit(
        designSize: const Size(360, 800), //154.3,244.5

        minTextAdapt: true,
        splitScreenMode: true,

        builder: (BuildContext, Widget) => OverlaySupport.global(
          child: MaterialApp(
            debugShowCheckedModeBanner: false, // no more debug
            home: SplachScreen(),
          ),
        ),
      ),
    );
  }
}
