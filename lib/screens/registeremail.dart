import 'dart:async';
import 'package:flutter/material.dart';
import 'package:id_360/others/constants.dart';
import 'package:id_360/screens/registerotp.dart';

class RegisterEmailScreen extends StatefulWidget {
  @override
  _RegisterEmailScreenState createState() => _RegisterEmailScreenState();
}

class _RegisterEmailScreenState extends State<RegisterEmailScreen>
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
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.splash_back),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
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
                /*Expanded(
                    child: SizedBox()
                ),*/
                Padding(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: TextFormField(
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
                      /*icon: const Icon(Icons.phone),*/
                      hintText: 'Email',
                      hintStyle: TextStyle(fontSize: 20.0, color: Colors.white54),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: TextFormField(
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
                      /*icon: const Icon(Icons.phone),*/
                      hintText: 'Email',
                      hintStyle: TextStyle(fontSize: 20.0, color: Colors.white54),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: TextFormField(
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
                      /*icon: const Icon(Icons.phone),*/
                      hintText: 'Email',
                      hintStyle: TextStyle(fontSize: 20.0, color: Colors.white54),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: TextFormField(
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
                      /*icon: const Icon(Icons.phone),*/
                      hintText: 'Email',
                      hintStyle: TextStyle(fontSize: 20.0, color: Colors.white54),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: TextFormField(
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
                      /*icon: const Icon(Icons.phone),*/
                      hintText: 'Email',
                      hintStyle: TextStyle(fontSize: 20.0, color: Colors.white54),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: TextFormField(
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
                      /*icon: const Icon(Icons.phone),*/
                      hintText: 'Email',
                      hintStyle: TextStyle(fontSize: 20.0, color: Colors.white54),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40,right: 40),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(AppColors.whiteColor),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(15))
                    ),
                    child: Text(
                      AppConstants.txt_next,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 20),
                    ),
                    onPressed: () {
                      /*Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => RegisterOtpScreen()));*/
                    },
                  ),
                ),
                /*Expanded(
                    child: SizedBox()
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
