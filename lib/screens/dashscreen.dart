import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:id_360/database/dbprovider.dart';
import 'package:id_360/models/cardfetchmodel.dart';
import 'package:id_360/models/cardinfomodel.dart' as m;
import 'package:id_360/models/notificationmodel.dart';
import 'package:id_360/others/constants.dart';
import 'package:id_360/screens/addcardcategory.dart';
import 'package:id_360/screens/cardinfoscreen.dart';
import 'package:id_360/screens/cardlayoutscreen.dart';
import 'package:id_360/screens/dashboardscreen.dart';
import 'package:id_360/screens/loginemail.dart';
import 'package:id_360/screens/loginregisterscreen.dart';
import 'package:id_360/screens/profilescreen.dart';
import 'package:id_360/screens/registercompany.dart';

import 'package:id_360/screens/registerselfid.dart';
import 'package:id_360/service/ApiManager.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'addcardaddphotoscreen.dart';
import 'addcardinstitutionsearch.dart';
import 'appinfoscreen.dart';
import 'notificationscreen.dart';

class DashScreen extends StatefulWidget {
  String name = '', email = '';
  VoidCallback onTap;

  //DashboardScreenState dashboardScreenState;
  DashScreen(this.name, this.email /*,this.dashboardScreenState*/, this.onTap);

  @override
  _DashScreenState createState() =>
      _DashScreenState(name, email /*,dashboardScreenState*/, onTap);
}

class _DashScreenState extends State<DashScreen> with TickerProviderStateMixin {
  String name = '', email = '';
  bool net_image_available = false;
  String image_url = '';
  VoidCallback onTap;
  List<Data> listcard=[];
  //NotificationModel notificationModel;
  List<NotificationData> listNotification = [];
  /*AnimationController _controller;
  Animation<double> _animation;*/
  DashboardScreenState dashboardScreenState;
  String image_urluser='';
  bool isdataloaded = false;
  double height,width;

  _DashScreenState(
      this.name, this.email, this.onTap /*,this.dashboardScreenState*/);

  @override
  void initState() {
    super.initState();
    _fetchIdCard();
  }

  @override
  dispose() {
    //_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double heightorig, widthorig, widthone;
    double space = 20.0;
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    widthorig = mediaQueryData.size.width;
    widthone = (widthorig - (3 * space)) / 2;
    heightorig = mediaQueryData.size.height;
    height=heightorig;
    width=widthorig;
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: AppColors.bg_reg,
        body: SingleChildScrollView(
          child: Container(
            /*decoration: BoxDecoration(
            color: AppColors.bg_reg
          ),*/
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfileScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Container(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:(image_urluser!=null && !image_urluser.isEmpty && !image_urluser.contains('com.indolytics.id360'))?
                            NetworkImage(image_urluser):FileImage(new File(image_urluser.replaceAll("--","/"))),
                            child: (image_urluser==null || image_urluser.isEmpty)?ImageIcon(
                              AssetImage(AppImages.icon_user_logo),
                              size: 32,
                            ):null,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name /*AppConstants.txt_dash*/,
                                  style: TextStyle(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  email /*AppConstants.txt_dash*/,
                                  style: TextStyle(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      padding:
                          EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "NOTIFICATIONS",
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                if (listNotification.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 40, bottom: 40, left: 15, right: 15),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Text(
                              "No Notifications Available!",
                              style: TextStyle(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (listNotification != null && listNotification.length > 0)
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 5, bottom: 5, left: 5, right: 5),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
                        itemCount: listNotification.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context,index){
                          return GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => NotificationScreen()));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                          );
                        },
                        separatorBuilder: (context,index){
                          return Container(margin: EdgeInsets.only(top: 3,bottom: 3),height: 1,color: AppColors.info_background_line,);
                        },
                      ),
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "ID CARDS",
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                if (!net_image_available)
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddCardInstitutionSearch()/*AddCardCategory()*/));
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 40, bottom: 40, left: 15, right: 15),
                        decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.add,
                                size: 40,
                                color: AppColors.blackColor,
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Add cards to view here",
                                style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                if (net_image_available)
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: build_row(),
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

  Widget build_row()
  {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for(int i=0;i<listcard.length;i++)
              GestureDetector(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 15, bottom: 15, right: 10, left: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: (listcard[i].path!=null && listcard[i].path.isNotEmpty && !listcard[i].path.contains('com.indolytics.id360'))?Image.network(listcard[i].path,
                        height: 150, width: 100, fit: BoxFit.fill
                      //fit: BoxFit.cover,
                    ):Image.file(new File(listcard[i].path),height: 150, width: 100, fit: BoxFit.fill),
                  ),
                ),
                onTap: () {
                  selectedIndex = 1;
                  DashboardScreen.card_id=listcard[i].id.toString();
                  onTap();
                },
              ),

          Padding(
            padding: EdgeInsets.only(
                top: 15, bottom: 15, right: 10, left: 15),
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  border: Border.all(color: Colors.black),
                  borderRadius:
                  BorderRadius.all(Radius.circular(8))),
              child: Padding(
                padding: EdgeInsets.all(3),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddCardInstitutionSearch()/*AddCardCategory()*/));
                    },
                    child: Container(
                      //3/2
                      height: 130,
                      width: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 5),
                          Icon(
                            Icons.add,
                            size: 35,
                            color: AppColors.blackColor,
                          ),
                          SizedBox(height: 25),
                          Text(
                            "Add more Cards",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Logout"),
      onPressed: () {
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
    Navigator.pop(context, true);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginRegisterScreen()));
  }

  void _fetchIdCard() async {
    EasyLoading.show(
      status: 'Please Wait!',
      maskType: EasyLoadingMaskType.black,
    );
    bool isnetwork=await AppConstants.hasNetwork();
    if(isnetwork)
      {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Response res =
        await ApiManager().fetchIdCardApi(prefs.getString(AppConstants.USER_EMAIL),false);
        if (res != null && res.data != null) {
          String resf = res.data.toString().replaceAll(r"\'", "");
          print(resf);
          Map<String, dynamic> map = json.decode(resf);
          if (map['api_status'] != 0) {
            //map['data'][0]['punch_type'];
            //prefs.setString(AppConstants.LAST_PUNCH,map['data'][0]['punch_type']);
            //image_url = map['data']['path'];
            net_image_available = true;
            listcard=CardFetchModel.fromJson(map).data;
            if(listcard!=null && listcard.length>0)
            {
              DashboardScreen.card_id=listcard[0].id.toString();
              for(int i=0;i<listcard.length;i++)
              {
                try{
                  bool checkcarddata=await SQLiteDbProvider.db.checkCardData();
                  if(!checkcarddata)
                    {
                      if(listcard[i].path!=null && listcard[i].path.isNotEmpty)
                      {
                        var image=await ImageDownloader.downloadImage(listcard[i].path,destination: AndroidDestinationType.custom()..inExternalFilesDir());
                        var path =await ImageDownloader.findPath(image);
                        /*Data data=listcard[i];
                  data.path=path;*/
                        SQLiteDbProvider.db.storeCardData(listcard[i],path);
                      }
                      else
                      {
                        SQLiteDbProvider.db.storeCardData(listcard[i],"");
                      }
                    }

                }
                catch(error){error.toString();}
              }
            }
          } else {
            //prefs.setString(AppConstants.LAST_PUNCH,"Check Out");
            EasyLoading.showToast(map['api_message'],
                toastPosition: EasyLoadingToastPosition.bottom);
          }
        } else {
          EasyLoading.showToast(AppConstants.something_wrong,
              toastPosition: EasyLoadingToastPosition.bottom);
        }
      }
    else
      {
        List<Data> list=await SQLiteDbProvider.db.fetchCardData();
        listcard.clear();
        if(list!=null && list.length>0)
          {
            net_image_available = true;
            DashboardScreen.card_id=list[0].id.toString();
            for(int i=0;i<list.length;i++)
              {
                list[i].path=list[i].path.replaceAll('--', '/');
                listcard.add(list[i]);
              }
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
    fetch_notifications();
  }

  void fetch_notifications() async {
    EasyLoading.show(
      status: 'Please Wait!',
      maskType: EasyLoadingMaskType.black,
    );
    bool isNetwork=await AppConstants.hasNetwork();
    if(isNetwork)
      {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

        Response res = await ApiManager().fetchNotificationsApi(
            sharedPreferences.getInt(AppConstants.USER_ID).toString(),false);
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
            SQLiteDbProvider.db.storeNotificationData(NotificationModel.fromJson(map).data);
            listNotification = NotificationModel.fromJson(map).data.length > 2
                ? NotificationModel.fromJson(map).data.take(3).toList()
                : NotificationModel.fromJson(map).data;

            //EasyLoading.showToast(AppConstants.resend_otp_success,toastPosition: EasyLoadingToastPosition.bottom);
          } else {
            EasyLoading.showToast(AppConstants.something_wrong,
                toastPosition: EasyLoadingToastPosition.bottom);
          }
        } else {
          EasyLoading.showToast(AppConstants.something_wrong,
              toastPosition: EasyLoadingToastPosition.bottom);
        }
      }
    else
      {
        listNotification.clear();
        listNotification= await SQLiteDbProvider.db.fetchNotificationData();
        listNotification = listNotification.length > 2
            ? listNotification.take(3).toList()
            : listNotification;
      }
    EasyLoading.dismiss(animation: true);
    _fetchUserProfile();

  }

  void _fetchUserProfile() async {
    EasyLoading.show(
      status: 'Please Wait!',
      maskType: EasyLoadingMaskType.black,
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isNetwork=await AppConstants.hasNetwork();
    if(isNetwork)
      {
        Response res = await ApiManager().fetchUserProfileApi(prefs.getInt(AppConstants.USER_ID),false);
        if (res != null && res != null) {
          /*String resf = res.toString().replaceAll(r"\'", "");*/
          Map<String, dynamic> map = json.decode(res.toString());
          if (map['api_status'] != 0) {
            //map['data'][0]['punch_type'];
            //prefs.setString(AppConstants.LAST_PUNCH,map['data'][0]['punch_type']);
            //image_url=map['data']['path'];
            //net_image_available=true;
            m.CardInfoModel cardInfoModel = m.CardInfoModel.fromJson(map);
            String s = '';
            isdataloaded = true;
            image_urluser=cardInfoModel.data.imagepath;
            try{
              bool checkprofiledata=await SQLiteDbProvider.db.checkProfileData();
              if(!checkprofiledata)
                {
                  if(image_urluser!=null && image_urluser.isNotEmpty)
                  {
                    var image=await ImageDownloader.downloadImage(image_urluser,destination: AndroidDestinationType.custom()..inExternalFilesDir());
                    var path = await ImageDownloader.findPath(image);
                    SQLiteDbProvider.db.storeProfileData(prefs.getInt(AppConstants.USER_ID),"${res.toString()}",'"$path"');
                  }
                  else
                  {
                    SQLiteDbProvider.db.storeProfileData(prefs.getInt(AppConstants.USER_ID),"${res.toString()}","");
                  }
                }


              /*Data data=listcard[i];
                  data.path=path;*/
              //SQLiteDbProvider.db.storeCardData(listcard[i],path);
            } catch(error){error.toString();}

            setState(() {});
          } else {
            //prefs.setString(AppConstants.LAST_PUNCH,"Check Out");
            EasyLoading.showToast(map['api_message'],
                toastPosition: EasyLoadingToastPosition.bottom);
          }
        } else {
          EasyLoading.showToast(AppConstants.something_wrong,
              toastPosition: EasyLoadingToastPosition.bottom);
        }
      }
    else
      {
        var data=await SQLiteDbProvider.db.fetchProfileData(prefs.getInt(AppConstants.USER_ID));
        if(data!=null && data.isNotEmpty)
        {
          var res=data[0].replaceAll('***', '');
          Map<String, dynamic> map = json.decode(res);
          m.CardInfoModel cardInfoModel= m.CardInfoModel.fromJson(map);
          isdataloaded = true;
          image_urluser=data[1];
          setState(() {});
        }
        else
        {
          EasyLoading.showToast(AppConstants.profile_data_unavailable,
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
    setState(() {});
  }
}

/*class AlertDialogWidget{
  String title,message;
  AlertDialogWidget(this.title,this.message);


  */ /*@override
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
  }*/ /*




}*/
