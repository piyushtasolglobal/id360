import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:id_360/database/dbprovider.dart';
import 'package:id_360/models/countrymodel.dart';
import 'package:id_360/others/constants.dart';
import 'package:id_360/screens/cardlayoutscreen.dart';
import 'package:id_360/screens/dashscreen.dart';
import 'package:id_360/screens/loginregisterscreen.dart';
import 'package:id_360/screens/managescreen.dart';
import 'package:id_360/screens/qrcodescanning.dart';
import 'package:id_360/screens/registercompany.dart';

import 'package:id_360/screens/registerselfid.dart';
import 'package:id_360/service/ApiManager.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'appinfoscreen.dart';

import 'loginemail.dart';
import 'notificationscreen.dart';

//GlobalKey<DashboardScreenState> myKey;
int selectedIndex = 0;

class DashboardScreen extends StatefulWidget {
  String name = '', email = '';
  static String user_type = '';
  String last_punch_type = '';
  DashboardScreenState _dashboardScreenState;
  static String card_id='';
  //_DashboardScreenState __dashboardScreenState;
  DashboardScreen(this.name, this.email);
  @override
  DashboardScreenState createState() {
    _dashboardScreenState =
        DashboardScreenState(name, email /*,_dashboardScreenState*/);
    return _dashboardScreenState;
  }
}

class DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  String name = '', email = '';
  //myKey = GlobalKey();
  DashboardScreenState _dashboardScreenState;

  DashboardScreenState(this.name,
      this.email /*, this._dashboardScreenState*/); //late BuildContext context;
  //late NavigatorState navigatorState;

  /*AnimationController _controller;
  Animation<double> _animation;*/

  @override
  void initState() {
    super.initState();
    _fetchLastPunch();
    _fetchUserType();
    //fetch_country();
    //print("Response: "+SQLiteDbProvider.db.getCountry(1).toString());
    //DashboardScreen.user_type= _fetchUserType() as String?;
  }

  void fetch_country() async
  {
    Country country=await SQLiteDbProvider.db.getCountry(2);
    print(country.name);
  }

  @override
  dispose() {
    //_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    //double height,widthorig,widthone;
    //double space=20.0;
    //MediaQueryData mediaQueryData=MediaQuery.of(context);
    //widthorig=mediaQueryData.size.width;
    //widthone=(widthorig-(3*space))/2;
    //height=widthone;
    List<Widget> _pages = <Widget>[
      DashScreen(name, email /*,_dashboardScreenState*/, onItemClick),
      CardLayoutScreen(),
      ManageScreen()
    ];
    return Scaffold(
      backgroundColor: AppColors.bg_reg,
      bottomNavigationBar: Container(
        height: 45,
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 0;
                  });
                },
                child: (selectedIndex == 0)
                    ? Text(
                        "HOME",
                        style: TextStyle(
                          shadows: [
                            Shadow(color: Colors.white, offset: Offset(0, -5))
                          ],
                          color: Colors.transparent,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                          decorationThickness: 2,
                          decorationStyle: TextDecorationStyle.solid,
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                        ),
                      )
                    : Text(
                        "HOME",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                        ),
                      ),
              ),
              GestureDetector(
                onTap: () {
                  /*Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CardLayoutScreen()));*/
                  setState(() {
                    selectedIndex = 1;
                  });
                },
                child: (selectedIndex == 1)
                    ? Text(
                        "ID CARDS",
                        style: TextStyle(
                          shadows: [
                            Shadow(color: Colors.white, offset: Offset(0, -5))
                          ],
                          color: Colors.transparent,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                          decorationThickness: 2,
                          decorationStyle: TextDecorationStyle.solid,
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                        ),
                      )
                    : Text(
                        "ID CARDS",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                        ),
                      ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 2;
                  });
                  /*Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ManageScreen()));*/
                },
                child: (selectedIndex == 2)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /*SizedBox(
                        height: 2,
                      ),*/
                          Icon(
                            Icons.view_headline_sharp,
                            color: Colors.white,
                            size: 25,
                          ),
                          Container(
                            height: 2,
                            width: 25,
                            color: Colors.white,
                          ),
                          /*Divider(
                        height: 2,
                        color: Colors.white,
                      ),
                      Container(),*/
                          /*Container(
                        decoration: BoxDecoration(
                          border: Border.
                        ),
                      ),*/
                        ],
                      )
                    : Icon(
                        Icons.view_headline_sharp,
                        color: Colors.white,
                        size: 25,
                      ),
              ),
              /*Container(
                        width: 5,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          color: const Color(0x7f9e9e9e),
                        ),
                      ),*/
            ],
          ),
        ),
      ),
      /*BottomNavigationBar(
        backgroundColor: AppColors.bg_reg,
        elevation: 0,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 30,
        selectedItemColor: AppColors.whiteColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'ID CARDS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_headline_sharp),
            label: 'MANAGE',
          ),
        ],
      ),*/
      /*appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 20.0,
          onPressed: () {
            //Navigator.pop(context);
            SystemNavigator.pop();
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
          AppConstants.txt_dash,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),*/
      body: SafeArea(child: _pages.elementAt(selectedIndex)),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void onItemClick() {
    onItemTapped(selectedIndex);
  }

  /*void _setSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(AppConstants.IS_LOGGEDIN, false);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginRegisterScreen()));
  }*/

  void _fetchLastPunch() async {
    EasyLoading.show(
      status: 'Please Wait!',
      maskType: EasyLoadingMaskType.black,
    );
    bool isnetwork=await AppConstants.hasNetwork();
    if(isnetwork)
      {
        DateTime datenow = DateTime.now();
        String formattedDate = DateFormat('yyyy-MM-dd').format(datenow);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Response res = await ApiManager()
            .fetchAttendanceApi(prefs.getInt(AppConstants.USER_ID), formattedDate,false);
        if (res != null && res.data != null) {
          String resf = res.data.toString().replaceAll(r"\'", "");
          Map<String, dynamic> map = json.decode(resf);
          if (map['api_status'] != 0) {
            //map['data'][0]['punch_type'];
            prefs.setString(AppConstants.LAST_PUNCH, map['data'][0]['punch_type']);
          } else {
            prefs.setString(AppConstants.LAST_PUNCH, "Check Out");
          }
        } else {
          EasyLoading.showToast(AppConstants.something_wrong,
              toastPosition: EasyLoadingToastPosition.bottom);
        }
      }
    /*if (res.data != null && res.data['api_status'] == 0) {
      EasyLoading.showToast(res.data['message'],
          toastPosition: EasyLoadingToastPosition.bottom);
    } else {
      EasyLoading.showToast(AppConstants.reg_success,
          toastPosition: EasyLoadingToastPosition.bottom);
      Navigator.of(context).pop();
    }*/
    EasyLoading.dismiss(animation: true);
  }

  void _fetchUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.setInt(AppConstants.USER_ID, user_id);
    DashboardScreen.user_type = prefs.getString(AppConstants.USER_TYPE);
    //prefs.setString(AppConstants.USER_EMAIL, email);
  }
}
