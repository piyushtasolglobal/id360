import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:id_360/database/dbprovider.dart';
import 'package:id_360/others/constants.dart';
import 'package:id_360/screens/loginemail.dart';
import 'package:id_360/screens/loginregisterscreen.dart';
import 'package:id_360/screens/registercompany.dart';

import 'package:id_360/screens/registerselfid.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'appinfoscreen.dart';
import 'notificationscreen.dart';

class ManageScreen extends StatefulWidget {
  @override
  _ManageScreenState createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen>
    with TickerProviderStateMixin {
  /*AnimationController _controller;
  Animation<double> _animation;*/

  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    //_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height,widthorig,widthone;
    double space=20.0;
    MediaQueryData mediaQueryData=MediaQuery.of(context);
    widthorig=mediaQueryData.size.width;
    widthone=(widthorig-(3*space))/2;
    height=widthone;

    return WillPopScope(
      onWillPop: (){
        SystemNavigator.pop();
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: AppColors.bg_reg,
        body: SafeArea(
          child: Container(
            /*decoration: BoxDecoration(
                color: AppColors.bg_reg
              ),*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AppInfoScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            Text(
                              "App Info",
                              style: TextStyle(
                                color: AppColors.blackColor,
                                fontSize: 16,
                              ),
                            ),
                            Expanded(child: Container(),),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => RegisterCompanyScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            Text(
                              AppConstants.txt_instadd,
                              style: TextStyle(
                                color: AppColors.blackColor,
                                fontSize: 16,
                              ),
                            ),
                            Expanded(child: Container(),),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NotificationScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            Text(
                              "Notifications",
                              style: TextStyle(
                                color: AppColors.blackColor,
                                fontSize: 16,
                              ),
                            ),
                            Expanded(child: Container(),),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    showAlertDialogdelete(context);
                    /*Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => RegisterCompanyScreen()));*/
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            Text(
                              AppConstants.txt_clr_data,
                              style: TextStyle(
                                color: AppColors.blackColor,
                                fontSize: 16,
                              ),
                            ),
                            Expanded(child: Container(),),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    /*Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginEmailScreen()));*/
                    //_setSession();
                    showAlertDialog(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            Text(
                              "Logout",
                              style: TextStyle(
                                color: AppColors.blackColor,
                                fontSize: 16,
                              ),
                            ),
                            Expanded(child: Container(),),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        /*body: SafeArea(
          child:
        ),*/
      ),
    );
  }
  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Logout"),
      onPressed:  () {
        _setSession(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(AppConstants.txt_logout),
      content: Text(AppConstants.txt_logout_message),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _setSession(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(AppConstants.IS_LOGGEDIN, false);
    prefs.setString(AppConstants.USER_TYPE, '');
    Navigator.pop(context,true);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginRegisterScreen()));
  }

  showAlertDialogdelete(BuildContext context) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed:  () async {
        Navigator.of(context).pop();
        EasyLoading.show(
          status: 'Please Wait!',
          maskType: EasyLoadingMaskType.black,
        );
        void a=await SQLiteDbProvider.db.deleteOfflineData();
        EasyLoading.dismiss(animation: true);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Clear Cache"),
      content: Text("Are you sure to clear cache?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}

/*class AlertDialogWidget{
  String title,message;
  AlertDialogWidget(this.title,this.message);


  *//*@override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => _setSession(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }*//*




}*/
