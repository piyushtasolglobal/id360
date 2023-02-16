import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:id_360/others/constants.dart';
import 'package:id_360/screens/registerotp.dart';
import 'package:id_360/service/ApiManager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboardscreen.dart';

class LoginEmailScreen extends StatefulWidget {
  @override
  _LoginEmailScreenState createState() => _LoginEmailScreenState();
}

class _LoginEmailScreenState extends State<LoginEmailScreen>
    with TickerProviderStateMixin {



  /*Future<void> _fetch_pref() async {
    final SharedPreferences prefs = SharedPreferences.getInstance();
  }*/

  /*AnimationController _controller;
  Animation<double> _animation;*/
  final emailtextcontroller= TextEditingController();
  //final passwordtextcontroller= TextEditingController();

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
    super.initState();
    //emailtextcontroller.text="atvp@gmail.com";

    //loadCounter();
  }

  @override
  dispose() {
    //_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.dash_back),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Image(
                    height: 100,
                    width: 100,
                    alignment: Alignment.center,
                    image: AssetImage(AppImages.icn_logo),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    AppConstants.appName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  Expanded(
                      child: SizedBox()
                  ),
                  Text(
                    AppConstants.txt_email,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailtextcontroller,
                      cursorColor: Colors.white,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white
                          ),
                        ),
                        /*icon: const Icon(Icons.phone),*/
                        hintText: AppConstants.txt_emaile,
                        hintStyle: TextStyle(fontSize: 20.0, color: Colors.white54),
                      ),
                    ),
                  ),
                  /*SizedBox(
                    height: 25,
                  ),
                  Text(
                    AppConstants.txt_password,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child: TextFormField(
                      obscureText: true,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      controller: passwordtextcontroller,
                      cursorColor: Colors.white,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white
                          ),
                        ),
                        *//*icon: const Icon(Icons.phone),*//*
                        hintText: AppConstants.txt_epassword,
                        hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ),*/
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40,right: 40),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(AppColors.bg_reg_options),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(15))
                      ),
                      child: Text(
                        AppConstants.txt_login,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 20),
                      ),
                      onPressed: () {
                        check_val();
                      },
                    ),
                  ),
                  Expanded(
                      child: SizedBox()
                  ),
                  Expanded(
                      child: SizedBox()
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 10,left: 5),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios,color: AppColors.whiteColor,),
                    iconSize: 20.0,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void check_val() async
  {
    if(emailtextcontroller.text.toString().trim().isEmpty)
    {
      EasyLoading.showToast(AppConstants.emailerror,toastPosition: EasyLoadingToastPosition.bottom);
    }
    else if(!isValidEmail(emailtextcontroller.text.toString().trim()))
      {
        EasyLoading.showToast(AppConstants.emailvaliderror,toastPosition: EasyLoadingToastPosition.bottom);
      }
    else
    {
      String token='';
      try{
        token=await FirebaseMessaging.instance.getToken();
        print("Firebase Token Fetch");
      }
      catch(e){print("Device Token Fetch Failed"+e.toString());}
      print("Device Token: "+token);
      EasyLoading.show(
        status: 'Please Wait!',
        maskType: EasyLoadingMaskType.black,
      );
      Response res=await ApiManager().loginApi(emailtextcontroller.text.toString(),token,false);

      if(res!=null && res.data!=null)
      {
        String resf=res.data.toString().replaceAll(r"\'", "");
        print("String result is==> $resf");

        Map map=json.decode(resf);
        if(map['status']=='false' || map['status']=='0' )
          {
            EasyLoading.showToast(map['msg'],toastPosition: EasyLoadingToastPosition.bottom);
          }
        else if(map['status']=='true' || map['status']=='1')
          {
            //EasyLoading.showToast(AppConstants.reg_success,toastPosition: EasyLoadingToastPosition.bottom);
            /*Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => RegisterOtpScreen()));*/
            EasyLoading.showToast(map['msg'],toastPosition: EasyLoadingToastPosition.bottom);
            _setSession(map['id'],map['name'],map['email']/*,map['type']*/,utf8.decode(base64.decode(map['otp'])));
          }
        else
          {
            EasyLoading.showToast(AppConstants.something_wrong,toastPosition: EasyLoadingToastPosition.bottom);
          }
      }
      else
        {
          EasyLoading.showToast(AppConstants.something_wrong,toastPosition: EasyLoadingToastPosition.bottom);
        }
      /*else
      {

      }*/
      EasyLoading.dismiss(animation: true);
      /**/
      // EasyLoading.show(
      //   status: 'Please Wait!',
      //   maskType: EasyLoadingMaskType.black,
      // );
      // Response res=await ApiManager().loginApi(emailtextcontroller.text.toString(),passwordtextcontroller.text.toString());
      // if(res.data!=null && res.data['api_status']==0)
      // {
      //   EasyLoading.showToast(res.data['message'],toastPosition: EasyLoadingToastPosition.bottom);
      // }
      // else
      // {
      //   EasyLoading.showToast(AppConstants.login_success,toastPosition: EasyLoadingToastPosition.bottom);
      //
      // }
      // EasyLoading.dismiss(animation: true);
    }
  }

  void _setSession(int user_id,String name,String email/*,String type*/,String otp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(AppConstants.USER_ID, user_id);
    prefs.setString(AppConstants.USER_NAME, name);
    prefs.setString(AppConstants.USER_EMAIL, email);
    //prefs.setString(AppConstants.USER_TYPE, type);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => RegisterOtpScreen(otp,user_id.toString())));
  }





  bool isValidEmail(String email)
  {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
}
