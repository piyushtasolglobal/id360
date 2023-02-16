import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:id_360/models/PushNotification.dart';
import 'package:id_360/others/constants.dart';
import 'package:id_360/screens/dashboardscreen.dart';
import 'package:id_360/screens/loginregisterscreen.dart';
import 'package:id_360/screens/managescreen.dart';
import 'package:id_360/screens/registercompany.dart';
import 'package:id_360/screens/registeroptionsscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dynamicformuseraddscreen.dart';
import 'loginemail.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  /*AnimationController _controller;
  Animation<double> _animation;*/

  @override
  void initState() {
    /*if (storageManager.getToken == null) {*/
      // Timer(
      //     Duration(seconds: 3),
      //     () => Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(builder: (_) => LoginScreen())));
    /*} else {
      Timer(
          Duration(seconds: 3),
          () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => HomeScreen())));
    }*/
    /*_controller = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this, value: 0.1);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);

    _controller.forward();*/
    checkForInitialMessage();

    Timer(
        Duration(seconds: 3),
            () => proceed_further());
    super.initState();
  }

  checkForInitialMessage() async {
    //await Firebase.initializeApp();
    RemoteMessage initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
      );

    }
  }


  void proceed_further() async
  {
    bool b=await _fetchSession();
    String temp_name_email=await _fetchUserData();
    String name=temp_name_email.split(",")[0],email=temp_name_email.split(",")[1];

    if(b!=null && b){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DashboardScreen(name,email)));
    }
    else
    {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => /*UserDynamicRegistrationFormScreen("7")*/LoginRegisterScreen()));
    }
  }

  Future<bool> _fetchSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey(AppConstants.IS_LOGGEDIN))
    {
      return prefs.getBool(AppConstants.IS_LOGGEDIN);
    }
    else
      return false;
  }

  Future<String> _fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return "${prefs.getString(AppConstants.USER_NAME)},${prefs.getString(AppConstants.USER_EMAIL)}";
  }

  @override
  dispose() {
    //_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.splash_back),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                height: 150,
                width: 150,
                image: AssetImage(AppImages.icn_logo),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                AppConstants.appName,
                style: TextStyle(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
