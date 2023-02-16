import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:id_360/database/dbprovider.dart';
import 'package:id_360/models/citymodel.dart';
import 'package:id_360/models/countrymodel.dart';
import 'package:id_360/others/constants.dart';
import 'package:id_360/screens/registerotp.dart';
import 'package:id_360/screens/registerotpcompany.dart';
import 'package:id_360/service/ApiManager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboardscreen.dart';

class RegisterCompanyScreen extends StatefulWidget {
  @override
  _RegisterCompanyScreen createState() => _RegisterCompanyScreen();
}

Country sel_countryreg;
City sel_cityreg;

class _RegisterCompanyScreen extends State<RegisterCompanyScreen>
    with TickerProviderStateMixin {
  /*AnimationController _controller;
  Animation<double> _animation;*/
  bool already_looged_in = false;
  List<Country> countrylist = [];
  List<City> citylist = [];
  final instcontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final countrycontroller = TextEditingController();
  final citycontroller = TextEditingController();
  final websitecontroller = TextEditingController();
  final rolecontroller = TextEditingController();
  final fullnamecontroller = TextEditingController();
  final noofcardscontroller = TextEditingController();

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
    if (sel_countryreg != null) countrycontroller.text = sel_countryreg.name;
    if (sel_cityreg != null) citycontroller.text = sel_cityreg.name;
    if (sel_cityreg == null) citycontroller.text = '';

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
          AppConstants.txt_instadd,
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
                    /*SizedBox(
                      height: 30,
                    ),
                    Image(
                      height: 100,
                      width: 100,

                      alignment: Alignment.center,
                      image: AssetImage(AppImages.icn_logo),
                    ),*/
                    /*SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppConstants.appName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),*/
                    /*Expanded(
                        child: SizedBox()
                    ),*/
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      AppConstants.txt_insname,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: instcontroller,
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
                          hintText: AppConstants.txt_insnamee,
                          hintStyle:
                              TextStyle(fontSize: 20.0, color: Colors.white54),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: emailcontroller,
                        keyboardType: TextInputType.emailAddress,
                        inputFormatters: [LengthLimitingTextInputFormatter(30)],
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
                          hintText: AppConstants.txt_emaile,
                          hintStyle:
                              TextStyle(fontSize: 20.0, color: Colors.white54),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppConstants.txt_country,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        show_countryPicker();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          enabled: false,
                          controller: countrycontroller,
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50)
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
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            /*icon: const Icon(Icons.phone),*/
                            hintText: AppConstants.txt_countrye,
                            hintStyle: TextStyle(
                                fontSize: 20.0, color: Colors.white54),
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
                    GestureDetector(
                      onTap: () {
                        show_cityPicker();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          enabled: false,
                          controller: citycontroller,
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50)
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
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            /*icon: const Icon(Icons.phone),*/
                            hintText: AppConstants.txt_cityse,
                            hintStyle: TextStyle(
                                fontSize: 20.0, color: Colors.white54),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppConstants.txt_website,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: websitecontroller,
                        keyboardType: TextInputType.url,
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
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          /*icon: const Icon(Icons.phone),*/
                          hintText: AppConstants.txt_websitee,
                          hintStyle:
                              TextStyle(fontSize: 20.0, color: Colors.white54),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppConstants.txt_role,
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
                        keyboardType: TextInputType.name,
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
                          hintText: AppConstants.txt_rolee,
                          hintStyle:
                              TextStyle(fontSize: 20.0, color: Colors.white54),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppConstants.txt_fullname,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: fullnamecontroller,
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
                          hintText: AppConstants.txt_fullnamee,
                          hintStyle:
                              TextStyle(fontSize: 20.0, color: Colors.white54),
                        ),
                      ),
                    ),
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
                          hintText: AppConstants.txt_idcardse,
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
                          //check_val();
                          check_val_2();
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
            /*Align(
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
            ),*/
          ],
        ),
      ),
    );
  }

  void show_countryPicker() async {
    if (countrylist.isEmpty)
      countrylist = await SQLiteDbProvider.db.getCountryList();
    //print(countrylist);

    alert_country_pick();
    /*setState(() {

    });*/
  }

  void show_cityPicker() async {
    if (sel_countryreg != null)
      citylist =
          await SQLiteDbProvider.db.getCityListInstiSearch(sel_countryreg.id);
    //print(countrylist);

    alert_city_pick();
    /*setState(() {

    });*/
  }

  alert_country_pick() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Search Country'),
            content: setupAlertDialoadContainerCountry(),
            actions: [
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text('Cancel'),
              ),
            ],
          );
        });
  }

  alert_city_pick() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Search City'),
            content: setupAlertDialoadContainerCity(),
            actions: [
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text('Cancel'),
              ),
            ],
          );
        });
  }

  Widget setupAlertDialoadContainerCountry() {
    return MyDialogCountry(countrylist, refresh_screen);
  }

  Widget setupAlertDialoadContainerCity() {
    return MyDialogCity(citylist, refresh_screen);
  }

  void refresh_screen() {
    setState(() {});
  }

  Future<void> check_val() async {
    if (instcontroller.text.toString().trim().isEmpty) {
      EasyLoading.showToast(AppConstants.instnameerror,
          toastPosition: EasyLoadingToastPosition.bottom);
    } else if (emailcontroller.text.toString().trim().isEmpty) {
      EasyLoading.showToast(AppConstants.emailerror,
          toastPosition: EasyLoadingToastPosition.bottom);
    } else if (countrycontroller.text.toString().trim().isEmpty) {
      EasyLoading.showToast(AppConstants.countryerror,
          toastPosition: EasyLoadingToastPosition.bottom);
    } else if (citycontroller.text.toString().trim().isEmpty) {
      EasyLoading.showToast(AppConstants.cityerror,
          toastPosition: EasyLoadingToastPosition.bottom);
    } else if (websitecontroller.text.toString().trim().isEmpty) {
      EasyLoading.showToast(AppConstants.websiteerror,
          toastPosition: EasyLoadingToastPosition.bottom);
    } else if (rolecontroller.text.toString().trim().isEmpty) {
      EasyLoading.showToast(AppConstants.roleerror,
          toastPosition: EasyLoadingToastPosition.bottom);
    } else if (fullnamecontroller.text.toString().trim().isEmpty) {
      EasyLoading.showToast(AppConstants.fullnameerror,
          toastPosition: EasyLoadingToastPosition.bottom);
    } else if (noofcardscontroller.text.toString().trim().isEmpty) {
      EasyLoading.showToast(AppConstants.noofcardserror,
          toastPosition: EasyLoadingToastPosition.bottom);
    } else {
      String token = '';
      try {
        token = await FirebaseMessaging.instance.getToken();
        print("Firebase Token Fetch");
      } catch (e) {
        print("Device Token Fetch Failed" + e.toString());
      }
      print("Device Token: " + token);
      EasyLoading.show(
        status: 'Please Wait!',
        maskType: EasyLoadingMaskType.black,
      );
      Response res = await ApiManager().addInstiApi(
          instcontroller.text.toString(),
          emailcontroller.text.toString(),
          sel_countryreg.id.toString(),
          sel_cityreg.id.toString(),
          websitecontroller.text.toString(),
          rolecontroller.text.toString(),
          fullnamecontroller.text.toString(),
          noofcardscontroller.text.toString(),
          token,false);
      if (res != null) {
        String temp = res.toString();
        Map<String, dynamic> map = json.decode(temp.replaceAll(r"\'", ""));
        if (map != null && map['api_status'] == 0) {
          EasyLoading.showToast(map['api_message'],
              toastPosition: EasyLoadingToastPosition.bottom);
        } else {
          //EasyLoading.showToast(AppConstants.reg_success,toastPosition: EasyLoadingToastPosition.bottom);
          //Navigator.of(context).pop();
          /*Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => RegisterOtpScreenCompany()));*/

          _setSession(map['data']['userid'], fullnamecontroller.text.toString(),
              emailcontroller.text.toString(), map['data']['otp']);


        }
      } else {
        EasyLoading.showToast(AppConstants.something_wrong,
            toastPosition: EasyLoadingToastPosition.bottom);
      }
      EasyLoading.dismiss(animation: true);
    }
  }


  Future<void> check_val_2() async {
      String token = '';
      try {
        token = await FirebaseMessaging.instance.getToken();
        print("Firebase Token Fetch");
      } catch (e) {
        print("Device Token Fetch Failed" + e.toString());
      }
      print("Device Token: " + token);

      EasyLoading.show(
        status: 'Please Wait!',
        maskType: EasyLoadingMaskType.black,
      );

      //EasyLoading.dismiss(animation: true);

      Response res = await ApiManager().addInstiApi(
          "testinst5",
          emailcontroller.text.toString(),
          "101",
          "2",
          "https://www.testinst5.com",
          "admin",
          fullnamecontroller.text.toString(),
          "2",
          token,false);

      if (res != null) {
        String temp = res.toString();
        Map<String, dynamic> map = json.decode(temp.replaceAll(r"\'", ""));
        if (map != null && map['api_status'] == 0) {
          EasyLoading.showToast(map['api_message'],
              toastPosition: EasyLoadingToastPosition.bottom);
        } else {
          //EasyLoading.showToast(AppConstants.reg_success,toastPosition: EasyLoadingToastPosition.bottom);
          //Navigator.of(context).pop();
          /*Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => RegisterOtpScreenCompany()));*/

          /*_setSession(map['data']['userid'], fullnamecontroller.text.toString(),
              emailcontroller.text.toString(), map['data']['otp']);*/

          _setSession(map['data']['userid'], fullnamecontroller.text.toString(),
              emailcontroller.text.toString(), map['authotp']);

        }
      } else {
        EasyLoading.showToast(AppConstants.something_wrong,
            toastPosition: EasyLoadingToastPosition.bottom);
      }

      EasyLoading.dismiss(animation: true);

  }




  void _setSession(int id, String name, String email, String otp) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(AppConstants.IS_LOGGEDIN)==null || !prefs.getBool(AppConstants.IS_LOGGEDIN)) {
      prefs.setInt(AppConstants.USER_ID, id);
      prefs.setString(AppConstants.USER_NAME, name);
      prefs.setString(AppConstants.USER_EMAIL, email);
      prefs.setBool(AppConstants.IS_LOGGEDIN, true);
      prefs.setString(AppConstants.USER_TYPE, "admin");

      print("user_name==> $prefs.getString(AppConstants.USER_NAME) ");
      print("user_name==> $prefs.getString(AppConstants.USER_EMAIL) ");


    } else {
      already_looged_in = true;
    }

    //prefs.setBool(AppConstants.IS_LOGGEDIN, true);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
            RegisterOtpScreenCompany(id.toString(), otp, already_looged_in, name.toString(), email.toString())));
  }



}

class MyDialogCountry extends StatefulWidget {
  MyDialogCountry(this.countrylist, this.itemSelected);
  VoidCallback itemSelected;
  List<Country> countrylist = [];

  @override
  _MyDialogCounreyState createState() =>
      new _MyDialogCounreyState(countrylist, itemSelected);
}

class _MyDialogCounreyState extends State<MyDialogCountry> {
  List<Country> countrylist = [];
  VoidCallback itemSelected;
  _MyDialogCounreyState(this.countrylist, this.itemSelected);

  List<Country> filteredlist = [];

  //int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    filteredlist = countrylist;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: Column(
        children: [
          TextField(
            onChanged: (value) {
              filterSearchResults(value);
            },
            //controller: editingController,
            decoration: InputDecoration(
                labelText: "Country",
                hintText: "Search Country",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)))),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: filteredlist.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {
                    sel_countryreg = filteredlist[index];
                    sel_cityreg = null;
                    Navigator.of(context).pop();
                    itemSelected();
                  },
                  title: Text(filteredlist[index].name),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void filterSearchResults(String query) {
    filteredlist = [];
    filteredlist.addAll(countrylist);
    if (query.isNotEmpty) {
      filteredlist = [];
      countrylist.forEach((item) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          filteredlist.add(item);
        }
      });
      setState(() {});
      return;
    } else {
      setState(() {});
    }
  }
}

class MyDialogCity extends StatefulWidget {
  MyDialogCity(this.citylist, this.itemSelected);

  List<City> citylist = [];
  VoidCallback itemSelected;

  @override
  _MyDialogCityState createState() =>
      new _MyDialogCityState(citylist, itemSelected);
}

class _MyDialogCityState extends State<MyDialogCity> {
  List<City> citylist = [];
  VoidCallback itemSelected;
  _MyDialogCityState(this.citylist, this.itemSelected);

  List<City> filteredlist = [];

  //int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    filteredlist = citylist;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: Column(
        children: [
          TextField(
            onChanged: (value) {
              filterSearchResults(value);
            },
            //controller: editingController,
            decoration: InputDecoration(
                labelText: "City",
                hintText: "Search City",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)))),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: filteredlist.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {
                    sel_cityreg = filteredlist[index];
                    Navigator.of(context).pop();
                    itemSelected();
                  },
                  title: Text(filteredlist[index].name),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void filterSearchResults(String query) {
    filteredlist = [];
    filteredlist.addAll(citylist);
    if (query.isNotEmpty) {
      filteredlist = [];
      citylist.forEach((item) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          filteredlist.add(item);
        }
      });
      setState(() {});
      return;
    } else {
      setState(() {});
    }
  }
}
