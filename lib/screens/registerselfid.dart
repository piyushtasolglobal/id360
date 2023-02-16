import 'dart:async';
import 'dart:convert';
import 'package:country_picker/country_picker.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:id_360/others/constants.dart';
import 'package:id_360/others/user_controller.dart';
import 'package:id_360/screens/dashboardscreen.dart';
import 'package:id_360/screens/registerotp.dart';
import 'package:id_360/screens/registerotpuser.dart';
import 'package:id_360/service/ApiManager.dart';
import 'package:intl/intl.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterSelfIdScreen extends StatefulWidget {
  @override
  _RegisterSelfIdScreen createState() => _RegisterSelfIdScreen();
}

class _RegisterSelfIdScreen extends State<RegisterSelfIdScreen>
    with TickerProviderStateMixin {
  final fnamecontroller = TextEditingController();
  final lnamecontroller = TextEditingController();
  final dobcontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final websitecontroller = TextEditingController();
  final rolecontroller = TextEditingController();
  final countrycontroller = TextEditingController();
  final citycontroller = TextEditingController();
  //final insticontroller = TextEditingController();
  final noofcardscontroller = TextEditingController();
  //UserController _userController=new UserController();
  /*AnimationController _controller;
  Animation<double> _animation;*/
  bool isWebsiteChecked = false;
  DateTime selectedDate = DateTime.now();
  String inst_sel = "";
  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(1920),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.bg_reg, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.blueGrey.shade900, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: AppColors.bg_reg, // button text color
              ),
            ),
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        final f = DateFormat('yyyy-MM-dd');
        DateTime s =
            f.parse("${picked.year}-${picked.month}-${picked.day}").toLocal();
        selectedDate = s;
        dobcontroller.text = f.format(s);
      });
    }
  }

  void configLoading() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..displayDuration = const Duration(milliseconds: 1000)
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..maskType = EasyLoadingMaskType.none
      ..radius = 10.0
      ..maskColor = Colors.black.withOpacity(0.5)
      ..userInteractions = false
      ..dismissOnTap = false;
  }

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
    configLoading();
  }

  @override
  dispose() {
    //_controller.dispose();
    fnamecontroller.dispose();
    lnamecontroller.dispose();
    dobcontroller.dispose();
    phonecontroller.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    websitecontroller.dispose();
    rolecontroller.dispose();
    countrycontroller.dispose();
    citycontroller.dispose();
    //insticontroller.dispose();
    noofcardscontroller.dispose();
    if (EasyLoading.isShow) {
      EasyLoading.dismiss(animation: true);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Value: 2 $inst_sel");
    return Scaffold(
      backgroundColor: AppColors.bg_reg,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                /*decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.splash_back),
                    fit: BoxFit.fill,
                  ),
                ),*/
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
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppConstants.txt_fname,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: fnamecontroller,
                        keyboardType: TextInputType.name,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(50),
                        ],
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                        cursorColor: Colors.white,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          /*icon: const Icon(Icons.phone),*/
                          hintText: AppConstants.txt_efname,
                          hintStyle:
                              TextStyle(fontSize: 20.0, color: Colors.white54),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppConstants.txt_lname,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: lnamecontroller,
                        keyboardType: TextInputType.text,
                        inputFormatters: [LengthLimitingTextInputFormatter(30)],
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                        cursorColor: Colors.white,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          /*icon: const Icon(Icons.phone),*/
                          hintText: AppConstants.txt_elname,
                          hintStyle:
                              TextStyle(fontSize: 20.0, color: Colors.white54),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppConstants.txt_dob,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          controller: dobcontroller,
                          enabled: false,
                          keyboardType: TextInputType.datetime,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(100),
                          ],
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                          cursorColor: Colors.white,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            /*icon: const Icon(Icons.phone),*/
                            hintText: AppConstants.txt_edob,
                            hintStyle:
                                TextStyle(fontSize: 20.0, color: Colors.white54),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppConstants.txt_phonenumber,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: phonecontroller,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(40),
                        ],
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                        cursorColor: Colors.white,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          /*icon: const Icon(Icons.phone),*/
                          hintText: AppConstants.txt_ephonenumber,
                          hintStyle:
                              TextStyle(fontSize: 20.0, color: Colors.white54),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppConstants.txt_email1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: emailcontroller,
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(60),
                        ],
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                        cursorColor: Colors.white,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          /*icon: const Icon(Icons.phone),*/
                          hintText: AppConstants.txt_eemail1,
                          hintStyle:
                              TextStyle(fontSize: 20.0, color: Colors.white54),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        obscureText: true,
                        autocorrect: false,
                        controller: passwordcontroller,
                        keyboardType: TextInputType.visiblePassword,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(60),
                        ],
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                        cursorColor: Colors.white,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          /*icon: const Icon(Icons.phone),*/
                          hintText: AppConstants.txt_epassword,
                          hintStyle:
                              TextStyle(fontSize: 20.0, color: Colors.white54),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppConstants.txt_website1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(
                            value: isWebsiteChecked,
                            onChanged: (newValue) {
                              setState(() {
                                isWebsiteChecked = newValue;
                              });
                            }),
                        Text(
                          "No Website",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),

                      ],
                    ),
                    /*Align(
                      alignment: Alignment.center,
                      child: CheckboxListTile(
                        title: Text("No Website",style: TextStyle(
                          color: AppColors.whiteColor
                        ),),
                        value: isWebsiteChecked,
                        ,
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      ),
                    ),*/
                    if (!isWebsiteChecked)
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          controller: websitecontroller,
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(60),
                          ],
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                          cursorColor: Colors.white,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            /*icon: const Icon(Icons.phone),*/
                            hintText: AppConstants.txt_ewebsite1,
                            hintStyle:
                                TextStyle(fontSize: 20.0, color: Colors.white54),
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppConstants.txt_role1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: rolecontroller,
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(60),
                        ],
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                        cursorColor: Colors.white,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          /*icon: const Icon(Icons.phone),*/
                          hintText: AppConstants.txt_erole1,
                          hintStyle:
                              TextStyle(fontSize: 20.0, color: Colors.white54),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppConstants.txt_country1,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: AppColors.whiteColor, fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () async {
                        /*final Country? _country = await countryPicker(
                          context,///required
                          selectedColor: Colors.green,///optional
                          unSelectedColor: Colors.black,///optional
                          width: 100,///optional
                          height: 100,///optional
                          backgroundColor: Colors.white,///optional
                          hintStyle: TextStyle(),///optional
                          barrierDismissible: true,///optional
                          barrierColor: Colors.black54,///optional
                        );
                        print(_country.toString());*/
                        showCountryPicker(
                          context: context,
                          showPhoneCode:
                              false, // optional. Shows phone code before the country name.
                          onSelect: (Country country) {
                            countrycontroller.text = country.name;
                            //print('Select country: ${country.displayName}');
                          },
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          enabled: false,
                          controller: countrycontroller,
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(60),
                          ],
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                          cursorColor: Colors.white,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            /*icon: const Icon(Icons.phone),*/
                            hintText: AppConstants.txt_ecountry1,
                            hintStyle:
                                TextStyle(fontSize: 20.0, color: Colors.white54),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppConstants.txt_city,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: citycontroller,
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(60),
                        ],
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                        cursorColor: Colors.white,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          /*icon: const Icon(Icons.phone),*/
                          hintText: AppConstants.txt_ecity,
                          hintStyle:
                              TextStyle(fontSize: 20.0, color: Colors.white54),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    /*Text(
                      AppConstants.txt_insti1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        SelectDialog.showModal<String>(
                          context,
                          searchHint: "Enter Institution Name",
                          label: "Select Institution",
                          selectedValue: "",
                          items: fetchComplexData(),
                          onChange: (String selected) {
                            print("Value: $selected");
                            //insticontroller.text = selected;
                            setState(() {
                              insticontroller.text=selected;
                            });
                          },
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 20,right: 20),
                        child: TextFormField(
                          controller: insticontroller,
                          enabled: false,
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(60),
                          ],
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
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
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white
                              ),
                            ),
                            */ /*icon: const Icon(Icons.phone),*/ /*
                            hintText: AppConstants.txt_einsti1,
                            hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ),*/
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppConstants.txt_noofcards,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: noofcardscontroller,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                        ],
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                        cursorColor: Colors.white,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          /*icon: const Icon(Icons.phone),*/
                          hintText: AppConstants.txt_enoofcards,
                          hintStyle:
                              TextStyle(fontSize: 20.0, color: Colors.white54),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40, right: 40, bottom: 20),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.whiteColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                                    EdgeInsets.all(15))),
                        child: Text(
                          AppConstants.txt_next,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.normal,
                              fontSize: 20),
                        ),
                        onPressed: () {
                           check_val();

                          //check_val_2();

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
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 10, left: 5),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.whiteColor,
                  ),
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
  List<String> fetchComplexData() {
    //await Future.delayed(Duration(milliseconds: 1000));
    //List _list = new List();
    List<String> _jsonList = [
      "vips12343",
      "vips1234",
      "test",
      "vips123",
    ];
    // create a list from the text input of three items
    // to mock a list of items from an http call where
    // the label is what is seen in the textfield and something like an
    // ID is the selected value

    return _jsonList;
  }

  Future<void> check_val() async {
    if (fnamecontroller.text.toString().trim().isEmpty) {
      EasyLoading.showToast(AppConstants.fnameerror,
          toastPosition: EasyLoadingToastPosition.bottom);
    } else if (lnamecontroller.text.toString().trim().isEmpty) {
      EasyLoading.showToast(AppConstants.lnameerror,
          toastPosition: EasyLoadingToastPosition.bottom);
    } else if (dobcontroller.text.toString().trim().isEmpty) {
      EasyLoading.showToast(AppConstants.doberror,
          toastPosition: EasyLoadingToastPosition.bottom);
    } else if (phonecontroller.text.toString().trim().isEmpty) {
      EasyLoading.showToast(AppConstants.phoneerror,
          toastPosition: EasyLoadingToastPosition.bottom);
    } else if (emailcontroller.text.toString().trim().isEmpty) {
      EasyLoading.showToast(AppConstants.emailerror,
          toastPosition: EasyLoadingToastPosition.bottom);
    } else if (!isValidEmail(emailcontroller.text.toString().trim())) {
      EasyLoading.showToast(AppConstants.emailvaliderror,
          toastPosition: EasyLoadingToastPosition.bottom);
    } else if (passwordcontroller.text.toString().trim().isEmpty) {
      EasyLoading.showToast(AppConstants.passworderror,
          toastPosition: EasyLoadingToastPosition.bottom);
    } else if (!isWebsiteChecked && websitecontroller.text.toString().trim().isEmpty) {
      EasyLoading.showToast(AppConstants.websiteerror,
          toastPosition: EasyLoadingToastPosition.bottom);
    } else if (!isWebsiteChecked && !Uri.tryParse(websitecontroller.text.toString().trim())
        .isAbsolute) {
      EasyLoading.showToast(AppConstants.websitepropererror,
          toastPosition: EasyLoadingToastPosition.bottom);
    } else if (rolecontroller.value.toString().trim().isEmpty) {
      EasyLoading.showToast(AppConstants.roleerror,
          toastPosition: EasyLoadingToastPosition.bottom);
    } else if (countrycontroller.text.toString().trim().isEmpty) {
      EasyLoading.showToast(AppConstants.countryerror,
          toastPosition: EasyLoadingToastPosition.bottom);
    } else if (citycontroller.text.toString().trim().isEmpty) {
      EasyLoading.showToast(AppConstants.cityerror,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
    /*else if(insticontroller.text.toString().trim().isEmpty)
    {
      EasyLoading.showToast(AppConstants.institutionerror,toastPosition: EasyLoadingToastPosition.bottom);
    }*/
    else if (noofcardscontroller.text.toString().trim().isEmpty) {
      EasyLoading.showToast(AppConstants.noofcardserror,
          toastPosition: EasyLoadingToastPosition.bottom);
    } else {
      String token = '';
      try {
        token = await FirebaseMessaging.instance.getToken();
        print("Firebase Token Fetch");
      } catch (e) {
        print("Device Token Fetch Failed$e");
      }
      print("Device Token: $token");
      EasyLoading.show(
        status: 'Please Wait!',
        maskType: EasyLoadingMaskType.black,
      );
      Response res = await ApiManager().regselfidApi(
          fnamecontroller.text.toString(),
          lnamecontroller.text.toString(),
          dobcontroller.text.toString(),
          phonecontroller.text.toString(),
          emailcontroller.text.toString(),
          passwordcontroller.text.toString(),
          websitecontroller.text.toString(),
          rolecontroller.text.toString(),
          countrycontroller.text.toString(),
          citycontroller.text.toString(),
          "10",
          noofcardscontroller.text.toString(),
          token,false);

      print('The status code-->${res.statusCode.toString()}');

      if (res != null) {
        print(res.data);
        String resf = res.toString().replaceAll(r"\'", "");
        print(resf);
        Map map = json.decode(resf);

        if (map != null && map['api_status'] == 0) {
          EasyLoading.showToast(map['message'],
              toastPosition: EasyLoadingToastPosition.bottom);
        } else {
          EasyLoading.showToast(AppConstants.reg_success,
              toastPosition: EasyLoadingToastPosition.bottom);
          set_session(map['data'], map['authotp']);
        }
      } else {
        EasyLoading.showToast(AppConstants.something_wrong,
            toastPosition: EasyLoadingToastPosition.bottom);
      }

      EasyLoading.dismiss(animation: true);
    }
  }


  Future<void> check_val_2() async
  {
    String token = '';
    try {
      token = await FirebaseMessaging.instance.getToken();
      print("Firebase Token Fetch");
    } catch (e) {
      print("Device Token Fetch Failed$e");
    }
    print("Device Token: $token");
    EasyLoading.show(
      status: 'Please Wait!',
      maskType: EasyLoadingMaskType.black,
    );

      Response res = await ApiManager().regselfidApi(
          "piyu",
          "sha",
          "16-04-1990",
          "9865325412",
          "piyuu@gmail.com",
          "123",
          "https://www.hondacarindia.com",
          "admin",
          "India",
          "Jaipur",
          "10",
          "2",
          token,false);


      if (res != null)
      {

        print(res.data);
        String resf = res.toString().replaceAll(r"\'", "");
        print(resf);
        Map map = json.decode(resf);

        if (map != null && map['api_status'] == 0) {
          EasyLoading.showToast(map['message'],
              toastPosition: EasyLoadingToastPosition.bottom);
        } else {
          print('The status code-->${res.data.toString()}');

          EasyLoading.showToast(AppConstants.reg_success,
              toastPosition: EasyLoadingToastPosition.bottom);
          set_session(map['data'], map['authotp']);
        }
      }
      else {
        EasyLoading.showToast(AppConstants.something_wrong,
            toastPosition: EasyLoadingToastPosition.bottom);
      }

      EasyLoading.dismiss(animation: true);
    }



  void set_session(int id, String otp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(AppConstants.USER_ID, id);
    prefs.setBool(AppConstants.IS_LOGGEDIN, true);
    prefs.setString(
        AppConstants.USER_NAME,
        "${fnamecontroller.text} ${lnamecontroller.text}");
    prefs.setString(AppConstants.USER_EMAIL, emailcontroller.text.toString());
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => RegisterOtpScreenUser(id.toString(), otp)));
    /*Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => DashboardScreen(fnamecontroller.text.toString()+" "+
            lnamecontroller.text.toString(),
            emailcontroller.text.toString())));*/
  }

  bool isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}
