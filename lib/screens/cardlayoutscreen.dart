import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:id_360/database/dbprovider.dart';
import 'package:id_360/models/carddatamodel.dart';
import 'package:id_360/others/constants.dart';
import 'package:id_360/screens/cardinfoscreen.dart';
import 'package:id_360/screens/dashboardscreen.dart';
import 'package:id_360/screens/loginregisterscreen.dart';
import 'package:id_360/screens/qrcodescanning.dart';
import 'package:id_360/service/ApiManager.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
];

class CardLayoutScreen extends StatefulWidget {
  //String name = '', email = '';

  const CardLayoutScreen({Key key}) : super(key: key);

  @override
  _CardLayoutScreenState createState() => _CardLayoutScreenState();
}

class _CardLayoutScreenState extends State<CardLayoutScreen>
    with TickerProviderStateMixin {
  int _current = 0;
  int count = 0;
  String officeId = '', cardUserId = '', lastPunch = '';
  //String name = '', email = '';
  //bool net_image_available = false;
  //String image_url = '';
  /*AnimationController _controller;
  Animation<double> _animation;*/
  CardDataModel cardDataModel;
  _CardLayoutScreenState();
  bool isDataLoaded = false;
  Map<String, dynamic> mapUserdetails, mapuserinfopages;
  DateTimeModel dateTime;
  IcardsDetails icardsDetails;
  UserIcardMapping userIcardMapping;
  double height, width;
  List<Widget> imageSliders = [];
  String _timeString;
  Timer timer;

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    timer=Timer.periodic(Duration(milliseconds: 1000), (Timer t) => _getTime());
    super.initState();
    //_fetchIdCard();
    _fetchIdCarddetails();
  }

  @override
  dispose() {
    //_controller.dispose();
    try{
      timer.cancel();
    }
    catch(e){}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    count = 0;
    Size size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    double widthorg = 0.0,
        heightorig = 0.0,
        stableHeight = 803.1372699202233,
        stableWidth = 423.5294196844927;
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    heightorig = mediaQueryData.size.height; //803
    widthorg = mediaQueryData.size.width; //423

    if (kDebugMode) {
      print("$widthorg -- $heightorig");
    }
    return WillPopScope(
      onWillPop: () {
        /*SystemNavigator.pop();
        return Future.value(true);*/
        //Navigator.pop(context);
        if (selectedIndex != 0) {
          selectedIndex == 0;
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.bg_reg,
        body: (isDataLoaded)
            ? SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: fromHex(icardsDetails.borderColor ??
                            AppColors.color_card_border1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: fromHex(icardsDetails.backgroundColor ??
                              AppColors.color_card_background1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: (heightorig * 10) / stableHeight,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Image(
                                    width: (widthorg * 175) / stableWidth,
                                    height: (heightorig * 88) / stableHeight,
                                    fit: BoxFit.contain,
                                    image: (mapUserdetails['logo'] != null &&
                                            mapUserdetails['logo'] != '' &&
                                            !mapUserdetails['logo']
                                                .contains('com.indolytics.id360'))
                                        ? NetworkImage(mapUserdetails['logo'])
                                        : (mapUserdetails['logo'] != null &&
                                                mapUserdetails['logo'] != '')
                                            ? FileImage(File(
                                                mapUserdetails['logo']
                                                    .replaceAll("--", "/")))
                                            : const AssetImage(AppImages
                                                .icn_logo_card_top), //AssetImage(AppImages.icn_logo_card_top),
                                  ),
                                ),
                                /*Expanded(
                                  child: SizedBox(),
                              ),*/
                                /*ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(AppColors.bg_reg_options),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25.0),
                                      ),
                                    ),
                                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.only(left: 15,right: 15,top: 20,bottom: 20)),
                                ),
                                child: Text(
                                  AppConstants.txt_info,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 20),
                                ),
                                onPressed: () {

                                },
                              ),*/
                                GestureDetector(
                                  onTap: () {
                                    //print('Card Id : ${DashboardScreen.card_id}');
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>

                                                CardInfoScreen(
                                                    DashboardScreen.card_id,
                                                    height,
                                                    width,
                                                    mapUserdetails[
                                                        'department'])));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 25,
                                          right: 25,
                                          top: 8,
                                          bottom: 8),
                                      decoration: BoxDecoration(
                                          color: fromHex(icardsDetails
                                                  .foregroundColor ??
                                              AppColors.color_card_foreground1),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Text(
                                        AppConstants.txt_info,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: fromHex(
                                              icardsDetails.fontColor ??
                                                  AppColors.color_card_font1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                /*SizedBox(
                                height: 10,
                              ),*/
                              ],
                            ),
                            SizedBox(
                              height: (heightorig * 10) / stableHeight,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                SizedBox(
                                  height: (widthorg * 10) / stableWidth,
                                ),
                                RotatedBox(
                                  quarterTurns: 3,
                                  child: Text(
                                    dateTime.date /*'10 DEC 2021'*/,
                                    style: TextStyle(
                                        fontSize:
                                            20 * (heightorig / stableHeight),
                                        color: fromHex(
                                            icardsDetails.fontColor ??
                                                AppColors.color_card_font1),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                /*Expanded(
                                child: SizedBox(),
                              ),*/
                                SizedBox(
                                  width: (widthorg * 20) / stableWidth,
                                ),

                                    /*Image.network(mapUserdetails['image'],width: widthorg * 100,
                                      height: heightorig * 150,fit: BoxFit.fill,errorBuilder:(BuildContext context, Object exception,
                    StackTrace? stackTrace){
                  return Image.asset(AppImages.icn_placeholder,width: widthorg * 100,
                      height: heightorig * 150,fit: BoxFit.fill));
                }
                                if(!(mapUserdetails['image'] != null &&
        mapUserdetails['image'] != '' &&
        mapUserdetails['image'] != 'null' &&
        mapUserdetails['image'] != ' '))
                                  Image.asset(AppImages.icn_placeholder,width: widthorg * 100,
                                  height: heightorig * 150,fit: BoxFit.fill),*/
                                /*Image(
                                  height: (heightorig * 150) / stableHeight,
                                  width: (widthorg * 100) / stableWidth,
                                  alignment: Alignment.topCenter,
                                  image: (mapUserdetails['image'] != null &&
                                          mapUserdetails['image'] != '' &&
                                          mapUserdetails['image'] != 'null' &&
                                          mapUserdetails['image'] != ' ')
                                      ? NetworkImage(mapUserdetails['image'],err)
                                      : const AssetImage(
                                          AppImages.icn_placeholder),
                                ),*/
                                if(mapUserdetails['image'] != null &&
                                    mapUserdetails['image'] != '' &&
                                    mapUserdetails['image'] != 'null' &&
                                    mapUserdetails['image'] != ' ')
                                Image.network(mapUserdetails['image'],width: (widthorg * 100) / stableWidth,
                                  height: (heightorig * 150) / stableHeight,/*fit: BoxFit.fill*/errorBuilder: (BuildContext context, Object exception,
                                      StackTrace stackTrace) {
                                    return Image.asset(AppImages.icn_placeholder,width: (widthorg * 100) / stableWidth,
                                        height: (heightorig * 150) / stableHeight,/*fit: BoxFit.fill*/);
                                  } ,),
                                if(!(mapUserdetails['image'] != null &&
                                    mapUserdetails['image'] != '' &&
                                    mapUserdetails['image'] != 'null' &&
                                    mapUserdetails['image'] != ' '))
                                Image.asset(AppImages.icn_placeholder,width: (widthorg * 100) / stableWidth,
                                    height: (heightorig * 150) / stableHeight,/*fit: BoxFit.fill*/),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 5, 15, 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        mapUserdetails['name'] ?? '',
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                            color: fromHex(icardsDetails
                                                    .fontColor ??
                                                AppColors.color_card_font1)),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        mapUserdetails['department'] ??
                                            '' /*"Employee"*/,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.normal,
                                            color: fromHex(icardsDetails
                                                    .fontColor ??
                                                AppColors.color_card_font1)),
                                      ),
                                    ],
                                  ),
                                ),
                                const Expanded(
                                  child: SizedBox(),
                                ),
                                RotatedBox(
                                  quarterTurns: 3,
                                  child: Text(
                                    _timeString/*dateTime.time*/ /*'09:49:00'*/,
                                    style: TextStyle(
                                        fontSize:
                                            20 * (heightorig / stableHeight),
                                        color: fromHex(
                                            icardsDetails.fontColor ??
                                                AppColors.color_card_font1),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: (widthorg * 8) / stableWidth,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                    width: widthorg * 0.88,
                                    child: CarouselSlider(
                                      options: CarouselOptions(
                                        aspectRatio: 1.9,
                                        enlargeCenterPage: false,
                                        scrollDirection: Axis.vertical,
                                        autoPlay: true,
                                        viewportFraction: 1.0,
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            _current = index;
                                          });
                                        },
                                      ),
                                      items: imageSliders,
                                    )),
                                /*if(mapuserinfopages.==null || mapuserinfopages.entries==null)*/
                                if (mapuserinfopages != null &&
                                    mapuserinfopages.entries != null && mapuserinfopages.entries.length>0)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 2),
                                    child: Column(
                                        children: mapuserinfopages.entries.map((emtry){
                                          count++;
                                          return GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              width: 6.0,
                                              height: 6.0,
                                              margin: const EdgeInsets.symmetric(
                                                  vertical: 4.0, horizontal: 2.0),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  color: (_current == (count - 1)
                                                      ? fromHex(
                                                      icardsDetails.fontColor ??
                                                          AppColors
                                                              .color_card_font1)
                                                      : fromHex(icardsDetails
                                                      .foregroundColor ??
                                                      AppColors
                                                          .color_card_foreground1))),
                                            ),
                                          );
                                        }).toList(),
                                    ),
                                  ),
                                /*Column(
                                  children: [

                                  ],
                                )*/
                                if (mapuserinfopages == null ||
                                    mapuserinfopages.entries == null)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 2),
                                    child: Column(
                                      children:
                                      [
                                        GestureDetector(
                                        onTap: () {},
                                    child: Container(
                                        width: 6.0,
                                        height: 6.0,
                                        margin:
                                        const EdgeInsets.symmetric(
                                            vertical: 4.0,
                                            horizontal: 2.0),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color: fromHex(icardsDetails
                                                .foregroundColor ??
                                                AppColors
                                                    .color_card_foreground1))),
                                  ),
                                      ]
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(
                              height: (heightorig * 15) / stableHeight,
                            ),
                            Image(
                              height: (heightorig * 130) / stableHeight,
                              width: (widthorg * 130) / stableWidth,
                              fit: BoxFit.fill,
                              image: NetworkImage(userIcardMapping.qrurl),
                            ),
                            SizedBox(
                              height: (heightorig * 15) / stableHeight,
                            ),
                            GestureDetector(
                              onTap: () {
                               Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => QrScanningScreen(
                                        officeId, cardUserId, lastPunch)));
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 25, right: 25, top: 8, bottom: 8),
                                decoration: BoxDecoration(
                                    color: fromHex(
                                        icardsDetails.foregroundColor ??
                                            AppColors.color_card_foreground1),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20))),
                                child: Text(
                                  AppConstants.txt_checkin,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: fromHex(icardsDetails.fontColor ??
                                          AppColors.color_card_font1)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: (heightorig * 15) / stableHeight,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : const SafeArea(
                child: Center(
                  child: Text(
                    AppConstants.txt_nocards,
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
        /*body: SafeArea(
          child:
        ),*/
      ),
    );
  }

  void _setSession(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(AppConstants.IS_LOGGEDIN, false);
    Navigator.pop(context, true);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginRegisterScreen()));
  }

  void _fetchIdCarddetails() async {
    EasyLoading.show(
      status: 'Please Wait!',
      maskType: EasyLoadingMaskType.black,
    );
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isNetwork = await AppConstants.hasNetwork();
    if (isNetwork) {
      Response res = await ApiManager().fetchIdCardDetailsApi(
          /*prefs.getInt(AppConstants.USER_ID)*/ DashboardScreen.card_id /*'46'*/,
          false);
      if (res != null && res.data != null) {
        String resf = res.data.toString().replaceAll(r"\'", "");
        if (kDebugMode) {
          print(resf);
        }
        //Map<String,Map<String,String>> map=Map();
        Map<String, dynamic> map = json.decode(resf);
        if (map['api_status'] != 0) {
          officeId = (map['data']['office_id']).toString();
          lastPunch = (map['data']['punch_type']).toString();
          cardUserId = (map['data']['icard_id']).toString();
          cardDataModel = CardDataModel.fromJson(map);
          dateTime = cardDataModel.data.dateTime;
          icardsDetails = cardDataModel.data.icardsDetails;
          userIcardMapping = cardDataModel.data.userIcardMapping;
          mapUserdetails = json
              .decode(cardDataModel.data.userIcardMapping.templateFieldMapping);
          mapuserinfopages =
              cardDataModel.data.userIcardMapping.pagesFieldMapping == null
                  ? null
                  : json.decode(
                      cardDataModel.data.userIcardMapping.pagesFieldMapping);
          bool checkcardinfodata = await SQLiteDbProvider.db
              .checkCardInfoData(DashboardScreen.card_id);
          if (!checkcardinfodata) {
            try {
              String logoPath = null, userPath = null;
              var image = await ImageDownloader.downloadImage(
                  cardDataModel.data.userIcardMapping.qrurl,
                  destination: AndroidDestinationType.custom(directory: '')
                    ..inExternalFilesDir());
              var qrPath = await ImageDownloader.findPath(image);
              if (mapUserdetails['logo'] != null &&
                  mapUserdetails['logo'] != '' &&
                  mapUserdetails['logo'] != 'null' &&
                  mapUserdetails['logo'] != ' ') {
                var imageLogo = await ImageDownloader.downloadImage(
                    mapUserdetails['logo'],
                    destination: AndroidDestinationType.custom(directory: '')
                      ..inExternalFilesDir());
                logoPath = await ImageDownloader.findPath(imageLogo);
              }
              if (mapUserdetails['image'] != null &&
                  mapUserdetails['image'] != '' &&
                  mapUserdetails['image'] != 'null' &&
                  mapUserdetails['image'] != ' ') {
                var imageUser = await ImageDownloader.downloadImage(
                    mapUserdetails['image'],
                    destination: AndroidDestinationType.custom(directory: '')
                      ..inExternalFilesDir());
                userPath = await ImageDownloader.findPath(imageUser);
              }

              SQLiteDbProvider.db.storeCardInfoData(DashboardScreen.card_id,
                  res.data.toString(), logoPath, userPath, qrPath);
            } catch (error) {
              error.toString();
            }
          }
          if (mapuserinfopages != null) {
            mapuserinfopages.forEach((key, value) {
              List<dynamic> list = value;
              Map map1 = list[0];
              String label1 = ' ', value1 = ' ', label2 = ' ', value2 = ' ';
              if (map1 != null) {
                map1.forEach((key, value) {
                  if (key != null && key != 'null') label1 = key;
                  if (value != null && value != 'null') value1 = value;
                });
              }
              if (list.length > 1) {
                Map map2 = list[1];
                if (map2 != null) {
                  map2.forEach((key, value) {
                    if (key != null && key != 'null') label2 = key;
                    if (value != null && value != 'null') value2 = value;
                  });
                }
              }
              //Map<String,String> map1=json.decode(value[0]);
              //Map<String,String> map2=json.decode(value[1]);
              imageSliders.add(Container(
                margin: const EdgeInsets.only(
                    left: 10, right: 10, top: 8, bottom: 8),
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 8, bottom: 8),
                  decoration: BoxDecoration(
                      color: fromHex(icardsDetails.foregroundColor ??
                          AppColors.color_card_foreground1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label1,
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: fromHex(icardsDetails.fontColor ??
                              AppColors.color_card_font1),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        value1,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          color: fromHex(icardsDetails.fontColor ??
                              AppColors.color_card_font1),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        label2,
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: fromHex(icardsDetails.fontColor ??
                              AppColors.color_card_font1),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        value2,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          color: fromHex(icardsDetails.fontColor ??
                              AppColors.color_card_font1),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
            });
          } else {
            imageSliders.add(Container(
              margin:
                  const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
              child: Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 8, bottom: 8),
                decoration: BoxDecoration(
                    color: (icardsDetails.foregroundColor == null)
                        ? AppColors.color_card_foreground
                        : fromHex(icardsDetails.foregroundColor),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " ",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: (icardsDetails.fontColor == null)
                            ? AppColors.color_card_font
                            : fromHex(icardsDetails.fontColor),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      " ",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: (icardsDetails.fontColor == null)
                            ? AppColors.color_card_font
                            : fromHex(icardsDetails.fontColor),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      " ",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: (icardsDetails.fontColor == null)
                            ? AppColors.color_card_font
                            : fromHex(icardsDetails.fontColor),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      " ",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: (icardsDetails.fontColor == null)
                            ? AppColors.color_card_font
                            : fromHex(icardsDetails.fontColor),
                      ),
                    ),
                  ],
                ),
              ),
            ));
          }

          //Map map=json.decode(cardDataModel.data.userIcardMapping.templateFieldMapping);
          isDataLoaded = true;
          //map['data'][0]['punch_type'];
          //prefs.setString(AppConstants.LAST_PUNCH,map['data'][0]['punch_type']);
          //image_url = map['data']['path'];
          //net_image_available = true;
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
    } else {
      if (DashboardScreen.card_id != null &&
          DashboardScreen.card_id.isNotEmpty) {
        var data = await SQLiteDbProvider.db
            .fetchCardInfoData(DashboardScreen.card_id);
        if (data != null && data.isNotEmpty) {
          var res = data[0].replaceAll('***', '');
          Map<String, dynamic> map = json.decode(res);
          officeId = (map['data']['office_id']).toString();
          lastPunch = (map['data']['punch_type']).toString();
          cardUserId = (map['data']['icard_id']).toString();
          cardDataModel = CardDataModel.fromJson(map);
          dateTime = cardDataModel.data.dateTime;
          icardsDetails = cardDataModel.data.icardsDetails;
          userIcardMapping = cardDataModel.data.userIcardMapping;
          mapUserdetails = json
              .decode(cardDataModel.data.userIcardMapping.templateFieldMapping);
          mapuserinfopages = json
              .decode(cardDataModel.data.userIcardMapping.pagesFieldMapping);

          mapuserinfopages.forEach((key, value) {
            List<dynamic> list = value;
            Map map1 = list[0];
            String label1 = ' ', value1 = ' ', label2 = ' ', value2 = ' ';
            if (map1 != null) {
              map1.forEach((key, value) {
                if (key != null && key != 'null') label1 = key;
                if (value != null && value != 'null') value1 = value;
              });
            }
            if (list.length > 1) {
              Map map2 = list[1];
              if (map2 != null) {
                map2.forEach((key, value) {
                  if (key != null && key != 'null') label2 = key;
                  if (value != null && value != 'null') value2 = value;
                });
              }
            }

            //Map<String,String> map1=json.decode(value[0]);
            //Map<String,String> map2=json.decode(value[1]);
            imageSliders.add(Container(
              margin:
                  const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
              child: Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 8, bottom: 8),
                decoration: BoxDecoration(
                    color: fromHex(icardsDetails.foregroundColor ??
                        AppColors.color_card_foreground),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label1,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: fromHex(icardsDetails.fontColor ??
                            AppColors.color_card_font),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      value1,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: fromHex(icardsDetails.fontColor ??
                            AppColors.color_card_font),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      label2,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: fromHex(icardsDetails.fontColor ??
                            AppColors.color_card_font),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      value2,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: fromHex(icardsDetails.fontColor ??
                            AppColors.color_card_font),
                      ),
                    ),
                  ],
                ),
              ),
            ));
          });
          isDataLoaded = true;
          setState(() {});
        } else {
          EasyLoading.showToast(AppConstants.something_wrong,
              toastPosition: EasyLoadingToastPosition.bottom);
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
  }

  void _getTime() {
    DateTime _now = DateTime.now();
    final String formattedDateTime = _formatDateTime(_now);
    /*if (this.mounted) {*/
      setState(() {
        _timeString = formattedDateTime;
      });
   /* }*/
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }
}
