
//import 'package:firebase_core/firebase_core.dart';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:id_360/models/PushNotification.dart';
import 'package:id_360/others/constants.dart';
import 'package:id_360/screens/cardlayoutscreen.dart';
import 'package:id_360/screens/citystatecountry.dart';
import 'package:id_360/screens/splash.dart';

import 'service/notification_service.dart';

void main() async{

  //FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationService notificationService=NotificationService();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
     statusBarColor: AppColors.bg_reg,
  ));
  try{
    await Firebase.initializeApp();
    print("Firebase Initiallize");
  }
  catch(e){print("Firebase Initialization Exception"+e.toString());}
  /*final pushNotificationService = NotificationService(_firebaseMessaging);
  pushNotificationService.initialise();*/
  registerNotification();
  runApp(MyApp());
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
AndroidNotificationChannel channel;
void registerNotification() async {
  // 1. Initialize the Firebase app
  //late ;
  //await Firebase.initializeApp();

  // 2. Instantiate Firebase Messaging
  channel=const AndroidNotificationChannel("id_360", "ID360",description: "ID360 Notification Channel",importance: Importance.high);
  flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("Notification Message");
    /*PushNotification notification = PushNotification(
      title: message.notification?.title,
      body: message.notification?.body,
    );*/
    show_Notification(message);
  });
  // 3. On iOS, this helps to take the user permissions
  if(Platform.isIOS)
    {
      NotificationSettings settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true,sound: true,badge: true);
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          // Parse the message received
          print("Notification Received");
          PushNotification notification = PushNotification(
            title: message.notification?.title,
            body: message.notification?.body,
          );
          //AndroidNotification
        });
      } else {
        print('User declined or has not accepted permission');
      }
    }
  else
    {

      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: false,sound: true,badge: true);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Parse the message received
        print("Notification Received");
        /*PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
        );*/
        show_Notification(message);
      });

    }
}

void show_Notification(RemoteMessage remoteMessage)
{
  RemoteNotification remoteNotification=remoteMessage.notification;
  AndroidNotification androidNotification=remoteMessage.notification.android;
  if(remoteNotification!=null && androidNotification!=null)
    {
      flutterLocalNotificationsPlugin.show(remoteNotification.hashCode, remoteNotification.title,
          remoteNotification.body, NotificationDetails(
            android: AndroidNotificationDetails(
                channel.id,channel.name,channelDescription: channel.description,icon: "app_icon"
            ),
          ));
    }
}

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //print("Handling a background message: ${message.messageId}");
  show_Notification(message);
}


class MyApp extends StatelessWidget {
  //static final FirebaseMessaging firebaseMessaging = FirebaseMessaging();


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        unselectedWidgetColor:Colors.white,
      ),
      home: /*CityStateCountry()*/SplashScreen(),
      builder: EasyLoading.init(),
    );
  }


}

