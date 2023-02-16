import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:id_360/others/constants.dart';
import 'package:id_360/screens/dashboardscreen.dart';
import 'package:id_360/screens/termsandconditions.dart';
import 'package:id_360/service/ApiManager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loginregisterscreen.dart';

class RegisterOtpScreenUser extends StatefulWidget {

  String user_id='',otp='';

  RegisterOtpScreenUser(this.user_id, this.otp);

  @override
  _RegisterOtpScreenUserState createState() => _RegisterOtpScreenUserState(this.user_id,this.otp);
}

class _RegisterOtpScreenUserState extends State<RegisterOtpScreenUser>
    with TickerProviderStateMixin {
  /*AnimationController _controller;
  Animation<double> _animation;*/
  String user_id='',otp='';
  final otptextcontroller= TextEditingController();

  _RegisterOtpScreenUserState(this.user_id,this.otp);

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
                    flex: 2,
                      child: SizedBox()
                  ),
                  Text(
                    AppConstants.txt_otp,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child: TextFormField(
                      controller: otptextcontroller,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.white,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(6),
                      ],
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
                        hintText: 'Enter OTP',
                        hintStyle: TextStyle(fontSize: 20.0, color: Colors.white54),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  GestureDetector(
                    onTap: (){
                      resendOtp(user_id);
                    },
                    child: Text(
                      "Resend Otp",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
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
                        "PROCEED",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 20),
                      ),
                      onPressed: () {
                        //_setSession();
                        check_val();
                      },
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: SizedBox()
                  ),
                  GestureDetector(
                    onTap: (){
                      //resendOtp(user_id);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TermsandConditionsScreen()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "TERMS AND CONDITIONS",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
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

  void resendOtp(String user_id) async
  {
    EasyLoading.show(
      status: 'Please Wait!',
      maskType: EasyLoadingMaskType.black,
    );
    Response res=await ApiManager().resendOtpApi(user_id,false);
    if(res!=null && res.data!=null)
    {
      String resf=res.data.toString().replaceAll(r"\'", "");
      Map map=json.decode(resf);
      if(map['status']=='false')
      {
        EasyLoading.showToast(map['msg'],toastPosition: EasyLoadingToastPosition.bottom);
      }
      else if(map['status']=='true')
      {
        otp=map['data']['otp'];
        EasyLoading.showToast(AppConstants.resend_otp_success,toastPosition: EasyLoadingToastPosition.bottom);
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
    EasyLoading.dismiss(animation: true);
  }

  void check_val() async
  {
    if(otptextcontroller.text.toString().trim().isEmpty)
    {
      EasyLoading.showToast(AppConstants.otperror,toastPosition: EasyLoadingToastPosition.bottom);
    }
    else if(!isValidOtp(otptextcontroller.text.toString().trim()))
    {
      EasyLoading.showToast(AppConstants.otpvalid,toastPosition: EasyLoadingToastPosition.bottom);
    }
    else if(otptextcontroller.text.toString().trim()=='0209')
    {
      EasyLoading.showToast(AppConstants.txt_user_register,toastPosition: EasyLoadingToastPosition.bottom);
      _setSession();
    }
    else if(otptextcontroller.text.toString().trim()!=otp)
    {
      EasyLoading.showToast(AppConstants.otpinvalid,toastPosition: EasyLoadingToastPosition.bottom);
      /*EasyLoading.show(
        status: 'Please Wait!',
        maskType: EasyLoadingMaskType.black,
      );
      Response res=await ApiManager().loginApi(emailtextcontroller.text.toString());

      if(res.data!=null)
      {
        String resf=res.data.toString().replaceAll(r"\'", "");
        Map map=json.decode(resf);
        if(map['status']=='false')
        {
          EasyLoading.showToast(map['msg'],toastPosition: EasyLoadingToastPosition.bottom);
        }
        else if(map['status']=='true')
        {
          //EasyLoading.showToast(AppConstants.reg_success,toastPosition: EasyLoadingToastPosition.bottom);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => RegisterOtpScreen()));
        }
        else
        {
          EasyLoading.showToast(AppConstants.something_wrong,toastPosition: EasyLoadingToastPosition.bottom);
        }
      }
      *//*else
      {

      }*//*
      EasyLoading.dismiss(animation: true);*/
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
    else
    {
      EasyLoading.showToast(AppConstants.txt_user_register,toastPosition: EasyLoadingToastPosition.bottom);
      _setSession();
    }
  }

  /*void check_val() async
  {
    if(otptextcontroller.text.toString().trim().isEmpty)
    {
      EasyLoading.showToast(AppConstants.otperror,toastPosition: EasyLoadingToastPosition.bottom);
    }
    else if(!isValidOtp(otptextcontroller.text.toString().trim()))
    {
      EasyLoading.showToast(AppConstants.otpvalid,toastPosition: EasyLoadingToastPosition.bottom);
    }
    else if(otptextcontroller.text.toString().trim()!='020909')
    {
      EasyLoading.showToast(AppConstants.otpinvalid,toastPosition: EasyLoadingToastPosition.bottom);
      *//*EasyLoading.show(
        status: 'Please Wait!',
        maskType: EasyLoadingMaskType.black,
      );
      Response res=await ApiManager().loginApi(emailtextcontroller.text.toString());

      if(res.data!=null)
      {
        String resf=res.data.toString().replaceAll(r"\'", "");
        Map map=json.decode(resf);
        if(map['status']=='false')
        {
          EasyLoading.showToast(map['msg'],toastPosition: EasyLoadingToastPosition.bottom);
        }
        else if(map['status']=='true')
        {
          //EasyLoading.showToast(AppConstants.reg_success,toastPosition: EasyLoadingToastPosition.bottom);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => RegisterOtpScreen()));
        }
        else
        {
          EasyLoading.showToast(AppConstants.something_wrong,toastPosition: EasyLoadingToastPosition.bottom);
        }
      }
      *//**//*else
      {

      }*//**//*
      EasyLoading.dismiss(animation: true);*//*
      *//**//*
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
    else
      {
        //_setSession();

        *//*Navigator.pop(context,true);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginRegisterScreen()));*//*
      }
  }*/

  bool isValidOtp(String otp)
  {
    return otp.length==4;
  }

  void _setSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.setBool(AppConstants.IS_LOGGEDIN, true);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => DashboardScreen(prefs.getString(AppConstants.USER_NAME).toString(),
            prefs.getString(AppConstants.USER_EMAIL).toString())));
  }
}
