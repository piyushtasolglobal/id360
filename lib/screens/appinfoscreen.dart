import 'dart:async';
import 'package:country_picker/country_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:id_360/others/constants.dart';
import 'package:id_360/others/user_controller.dart';
import 'package:id_360/screens/registerotp.dart';
import 'package:id_360/service/ApiManager.dart';
import 'package:intl/intl.dart';
import 'package:select_dialog/select_dialog.dart';

class AppInfoScreen extends StatefulWidget {
  @override
  _AppInfoScreenState createState() => _AppInfoScreenState();


}



class _AppInfoScreenState extends State<AppInfoScreen>
    with TickerProviderStateMixin {


  //UserController _userController=new UserController();
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
    //configLoading();
  }

  @override
  dispose() {
    //_controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print("Value: 2 $inst_sel");
    return Scaffold(
      backgroundColor: AppColors.bg_reg,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 20.0,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        elevation: 0,
        bottomOpacity: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          AppConstants.txt_appinfo,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Center(
                child: Container(
                  /*decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages.splash_back),
                      fit: BoxFit.fill,
                    ),
                  ),*/
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Image(
                        height: 100,
                        width: 100,
                        alignment: Alignment.center,
                        image: AssetImage(AppImages.icn_logo),
                      ),
                      /*Expanded(
                          child: SizedBox()
                      ),*/
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        AppConstants.txt_appinfoappname,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        AppConstants.appName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        AppConstants.txt_appinfoversion,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "v1.0.0",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*Future<List> fetchComplexData() async {
    await Future.delayed(Duration(milliseconds: 1000));
    //List _list = new List();
    List _jsonList = [
      {'vips12343'},
      {'vips1234'},
      {'test'},
      {'vips123'},
    ];
    // create a list from the text input of three items
    // to mock a list of items from an http call where
    // the label is what is seen in the textfield and something like an
    // ID is the selected value

    return _jsonList;
  }*/



  bool isValidEmail(String email)
  {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
}
