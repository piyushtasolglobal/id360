import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:id_360/database/dbprovider.dart';
import 'package:id_360/models/notificationmodel.dart';
import 'package:id_360/others/constants.dart';
import 'package:id_360/screens/loginregisterscreen.dart';
import 'package:id_360/screens/registercompany.dart';
import 'package:id_360/screens/registerselfid.dart';
import 'package:id_360/service/ApiManager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with TickerProviderStateMixin {
  /*AnimationController _controller;
  Animation<double> _animation;*/
  bool isDataFetched=false;
  List<NotificationData> listNotification = [];

  @override
  void initState() {
    super.initState();
    fetch_notifications();
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
    /*MediaQueryData mediaQueryData=MediaQuery.of(context);
    widthorig=mediaQueryData.size.width;
    widthone=(widthorig-(3*space))/2;
    height=widthone;*/

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
          AppConstants.txt_noti,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          /*decoration: BoxDecoration(
            color: AppColors.bg_reg
          ),*/
            child:(isDataFetched && listNotification.length==0)?Center(
              child: Text(
                AppConstants.txt_nonoti,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ):
            (isDataFetched && listNotification.length>0)?ListView.separated(
              shrinkWrap: true,
              itemCount: listNotification.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context,index){
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(
                            top: 5, bottom: 5, left: 10, right: 10),
                        decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              listNotification[index].title,
                              style: TextStyle(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8,),
                            Text(
                              listNotification[index].message,
                              style: TextStyle(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: (){
                          showNotificationDeleteAlertDialog(context,listNotification[index].id.toString());
                        },
                        child: Container(
                          height: 20,
                          width: 20,
                          margin: EdgeInsets.only(right: 2),
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.redColor,
                          ),
                          child: Icon(
                            Icons.clear,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context,index){
                return SizedBox(height: 10);
              },
            ):Container(),
        ),
      ),
    );
  }

  showNotificationDeleteAlertDialog(BuildContext context,String id) {
    // set up the buttonsz
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget deleteButton = TextButton(
      child: Text("Delete"),
      onPressed: () {
        //_setSession(context);
        Navigator.of(context).pop();
        delete_notifications(id);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(AppConstants.txt_delete_alert),
      content: Text(AppConstants.txt_delete_noti),
      actions: [
        cancelButton,
        deleteButton,
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

  void delete_notifications(id) async {
    EasyLoading.show(
      status: 'Please Wait!',
      maskType: EasyLoadingMaskType.black,
    );
    Response res = await ApiManager().deleteNotification(id,false);

    if (res != null && res.data != null) {
      String resf = res.toString().replaceAll(r"\'", "");
      print(resf);
      Map map = json.decode(resf);
      if (map['api_status'] == 0) {
        EasyLoading.showToast(map['msg'],
            toastPosition: EasyLoadingToastPosition.bottom);
        EasyLoading.dismiss(animation: true);
      } else if (map['api_status'] == 1) {
        EasyLoading.showToast(AppConstants.notiremove_success,
            toastPosition: EasyLoadingToastPosition.bottom);
        fetch_notifications();
        //_setSession(map['id'],map['name'],map['email']/*,map['type']*/,utf8.decode(base64.decode(map['otp'])));
      } else {
        EasyLoading.showToast(AppConstants.something_wrong,
            toastPosition: EasyLoadingToastPosition.bottom);
        EasyLoading.dismiss(animation: true);
      }
    } else {
      EasyLoading.showToast(AppConstants.something_wrong,
          toastPosition: EasyLoadingToastPosition.bottom);
      EasyLoading.dismiss(animation: true);
    }
    /*else
      {

      }*/

  }



  void fetch_notifications() async {

    bool isNetwork= await AppConstants.hasNetwork();
    EasyLoading.show(
      status: 'Please Wait!',
      maskType: EasyLoadingMaskType.black,
    );
    if(isNetwork)
      {

        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

        Response res = await ApiManager().fetchNotificationsApi(
          /*sharedPreferences.getInt(AppConstants.USER_ID).toString()*/sharedPreferences.getInt(AppConstants.USER_ID).toString(),false);
        if (res != null && res.data != null) {
          String resf=res.data.toString().replaceAll(r"\'", "");
          //res==res.replaceAll(r"\'", "");
          Map map = json.decode(resf);
          if (map['status'] == 'false') {
            EasyLoading.showToast(map['msg'],
                toastPosition: EasyLoadingToastPosition.bottom);
          } else if (map['status'] == 'true') {
            //notificationModel=NotificationModel.fromJson(map);
            //NotificationModel.fromJson(map).data.length>1?listNotification=NotificationModel.fromJson(map).data.take(2):listNotification=NotificationModel.fromJson(map).data;
            listNotification.clear();
            listNotification = NotificationModel.fromJson(map).data;
            SQLiteDbProvider.db.storeNotificationData(listNotification);

            //EasyLoading.showToast(AppConstants.resend_otp_success,toastPosition: EasyLoadingToastPosition.bottom);
          } else {
            EasyLoading.showToast(AppConstants.something_wrong,
                toastPosition: EasyLoadingToastPosition.bottom);
          }
        } else {
          EasyLoading.showToast(AppConstants.something_wrong,
              toastPosition: EasyLoadingToastPosition.bottom);
        }
        isDataFetched=true;
      }
    else{
      listNotification.clear();
      listNotification= await SQLiteDbProvider.db.fetchNotificationData();
      isDataFetched=true;
    }
    EasyLoading.dismiss(animation: true);
    setState(() {});
  }
}
