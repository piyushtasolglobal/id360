import 'dart:async';
import 'package:flutter/material.dart';
import 'package:id_360/others/constants.dart';
import 'package:id_360/screens/loginemail.dart';
import 'package:id_360/screens/registeremail.dart';
import 'package:id_360/screens/registeroptionsscreen.dart';

class LoginRegisterScreen extends StatefulWidget {
  @override
  _LoginRegisterScreenState createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen>
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
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.dash_back),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Spacer(),
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
              /*Expanded(
                  child: SizedBox()
              ),*/
              SizedBox(
                height: 40,
              ),
              Text(
                AppConstants.txt_haveac,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 18),
              ),
              SizedBox(
                height: 10,
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
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.only(
                          left: 15,right: 15,top: 20,bottom: 20,
                        ))
                    ),
                    child: Text(
                      AppConstants.txt_login,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginEmailScreen()));
                      /*Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => LoginEmailScreen()));*/
                    },
                  ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                AppConstants.txt_noac,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 18),
              ),
              SizedBox(
                height: 10,
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
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.only(
                        left: 15,right: 15,top: 20,bottom: 20,
                      ))
                  ),
                  child: Text(
                    AppConstants.txt_register,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  onPressed: () {
                    /*Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => LoginEmailScreen()));*/
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => RegisterOptionsScreen()));
                  },
                ),
              ),
              Spacer(),
              /*Expanded(
                  child: SizedBox()
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
