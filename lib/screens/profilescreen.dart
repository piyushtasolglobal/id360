import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:id_360/database/dbprovider.dart';
import 'package:id_360/models/InstitutionModel.dart';
import 'package:id_360/models/cardinfomodel.dart';
import 'package:id_360/others/constants.dart';
import 'package:id_360/screens/institutionsearchscreen.dart';
import 'package:id_360/screens/loginregisterscreen.dart';
import 'package:id_360/screens/registercompany.dart';
import 'package:id_360/screens/registerselfid.dart';
import 'package:id_360/service/ApiManager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dynamicformuseraddscreen.dart';

class ProfileScreen extends StatefulWidget {
  //Data data;
  ProfileScreen(/*@required this.data*/);


  @override
  _ProfileScreenState createState() => _ProfileScreenState(/*this.data*/);
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  //Data data;

  _ProfileScreenState();
  String image_url='';
  bool isdataloaded = false;
  CardInfoModel cardInfoModel;
  bool is_edit_aaplied=false;
  bool is_data_updated=false;
  ImagePicker _imagePicker;
  File _image;
  /*AnimationController _controller;
  Animation<double> _animation;*/

  @override
  void initState() {
    super.initState();
    _imagePicker=ImagePicker();
    _fetchIdCardInfo();
  }

  @override
  dispose() {
    //_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height, widthorig, widthone;
    double space = 20.0;
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    widthorig = mediaQueryData.size.width;
    widthone = (widthorig - (3 * space)) / 2;
    height = widthone;
    //
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
          AppConstants.txt_profile,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: <Widget>[
          !is_edit_aaplied?
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.white,
            ),
            onPressed: () {
              is_edit_aaplied=true;
              setState(() {

              });
            },
          ):GestureDetector(
            onTap: (){
              edit_data();
            },
            child: Container(
              margin: EdgeInsets.all(5),
              alignment: Alignment.center,
              child: Text(
                AppConstants.txt_save,
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: isdataloaded
          ? Container(
        decoration: BoxDecoration(color: AppColors.bg_reg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 55),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 45,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                /*Text(
                                 */ /*AppConstants.txt_dash*/ /*,
                                style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20,
                                ),
                              ),*/
                              SizedBox(
                                height: 15,
                              ),
                                Center(
                                  child: Text(
                                    cardInfoModel.data
                                        .name /*AppConstants.txt_dash*/,
                                    style: TextStyle(
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      padding: EdgeInsets.only(
                          top: 20, bottom: 20, left: 15, right: 15),
                      decoration: BoxDecoration(
                          color: AppColors.info_background,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: (){
                        if(is_edit_aaplied)
                          {
                            _showPhotoAlertDialog(context);
                          }
                      },
                      child: CircleAvatar(
                        radius: 65,
                        backgroundImage:(image_url!=null && !image_url.isEmpty && !image_url.contains('com.indolytics.id360'))?
                        NetworkImage(image_url):FileImage(new File(image_url.replaceAll("--","/"))),
                        child: (image_url==null || image_url.isEmpty)?ImageIcon(
                          AssetImage(AppImages.icon_user_logo),
                          size: 50,
                        ):null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "EMAIL",
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
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(
                padding: EdgeInsets.only(
                    top: 15, bottom: 15, left: 15, right: 15),
                decoration: BoxDecoration(
                    color: AppColors.info_background,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Text(
                  cardInfoModel.data.email,
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "DETAILS",
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
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(
                padding: EdgeInsets.only(
                    top: 15, bottom: 15, left: 15, right: 15),
                decoration: BoxDecoration(
                    color: AppColors.info_background,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  children: [
                    _buildContainer("Department : ",
                        (cardInfoModel.data.deatils!=null && cardInfoModel.data.deatils.department!=null &&
                            cardInfoModel.data.deatils.department!='null' &&
                            cardInfoModel.data.deatils.department!='')?cardInfoModel.data.deatils.department:
                        '-'),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      height: 1,
                      color: AppColors.info_background_line,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _buildContainer("Gender : ",
                        (cardInfoModel.data.deatils!=null && cardInfoModel.data.deatils.gender!=null &&
                            cardInfoModel.data.deatils.gender!='null' &&
                            cardInfoModel.data.deatils.gender!='')?cardInfoModel.data.deatils.gender:
                        '-'),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      height: 1,
                      color: AppColors.info_background_line,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _buildContainer("Status : ",
                        (cardInfoModel.data.deatils!=null && cardInfoModel.data.deatils.status!=null &&
                            cardInfoModel.data.deatils.status!='null' &&
                            cardInfoModel.data.deatils.status!='')?cardInfoModel.data.deatils.status:
                        '-'),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
          : Container(),
    );
  }

  void _showPhotoAlertDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select Photo'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                  getImageFromCamera();
                },
                child: const Text('Camera'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                  getImageFromGallery();
                },
                child: const Text('Gallery'),
              ),
            ],
          );
        });
  }

  void edit_data() async
  {
    is_edit_aaplied=false;
    setState(() {

    });
    if(is_data_updated)
      {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        var formData = FormData();
        print(_image.path);
        formData.fields.add(MapEntry('id', prefs.getInt(AppConstants.USER_ID).toString()));
        formData.files.add(MapEntry(
          'photo',
          MultipartFile.fromFileSync(_image.path),
        ));
        submit_data(formData);
      }
  }

  Future<void> submit_data(FormData formData) async {
    EasyLoading.show(
      status: 'Please Wait!',
      maskType: EasyLoadingMaskType.black,
    );
    print(formData.fields);
    //{"api_status":1,"api_message":"success save you Request","data":{"user_registrationoid":75,"data":{"name":"test","email":"test@g
    Response res = await ApiManager().profilePicUpdate(formData,false);
    String temp = res.data.toString();
    Map<String, dynamic> map = json.decode(temp.replaceAll(r"\'", ""));
    if (map['api_status'] == 0) {
      EasyLoading.showToast(map['api_message'],
          toastPosition: EasyLoadingToastPosition.bottom);
    } else {
      EasyLoading.showToast(AppConstants.proupdate_success,
          toastPosition: EasyLoadingToastPosition.bottom);
      //Navigator.of(context).pop();
      //set_session(map['data']['user_registrationoid'],map['data']['data']['name'] ,map['data']['data']['email'],map['data']['data']['otp']);
    }
    EasyLoading.dismiss(animation: true);
  }

  Future getImageFromCamera() async{
    var image = await _imagePicker.getImage(source: ImageSource.camera);
    //setState(() {
    //_image=image.
    if(image!=null)
      _image=File(image.path);
    //});
    _cropImage(_image);
  }

  Future getImageFromGallery() async{
    var image = await _imagePicker.getImage(source: ImageSource.gallery);
    //setState(() {
    //_image=image.
    if(image!=null)
      _image=File(image.path);
    //});
    _cropImage(_image);
  }

  Future<Null> _cropImage(File file) async
  {

    CroppedFile croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );

    // File croppedFile = await ImageCropper().cropImage(
    //     maxHeight: 360,
    //     maxWidth: 280,
    //     sourcePath: file.path,
    //     aspectRatio: CropAspectRatio(ratioX: 0.7,ratioY:  0.9),
    //     //aspectRatio: CropAspectRatio(0.7/ 0.9),
    //     aspectRatioPresets: Platform.isAndroid
    //         ? [
    //       CropAspectRatioPreset.square,
    //     ]
    //         : [
    //       CropAspectRatioPreset.square,
    //     ],
    //     androidUiSettings: AndroidUiSettings(
    //         toolbarTitle: 'Crop Image',
    //         toolbarColor: AppColors.bg_reg_options,
    //         toolbarWidgetColor: Colors.white,
    //         initAspectRatio: CropAspectRatioPreset.ratio5x4,
    //         lockAspectRatio: true),
    //     iosUiSettings: IOSUiSettings(
    //       title: 'Crop Image',
    //     ));
    if (croppedFile != null) {
      ///data/user/0/com.indolytics.id360/cache/image_cropper_1641452251642.jpg
      //final Directory directory = await getApplicationDocumentsDirectory();
      //String path=directory.path;
      //final File newImage = await croppedFile.copy('$path/image1.jpg');
      //print(newImage.length());
      setState(() {
        _image=croppedFile as File;
      });
      is_data_updated=true;
    }
  }

  Widget _buildContainer(String text, String value) {
    return new Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(text, style: _biggerFont),
          Text(value, style: _biggerFont),
        ],
      ),
    );
  }

  final _biggerFont = const TextStyle(
    color: Colors.black,
    fontSize: 20.0,
  );

  final _biggerboldFont = const TextStyle(
      color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold);

  void _fetchIdCardInfo() async {
    EasyLoading.show(
      status: 'Please Wait!',
      maskType: EasyLoadingMaskType.black,
    );
    bool isNetwork=await AppConstants.hasNetwork();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(isNetwork)
      {
        Response res = await ApiManager().fetchUserProfileApi(prefs.getInt(AppConstants.USER_ID),false);

        if (res != null && res.data != null) {
          //String resf = ;
          Map<String, dynamic> map = json.decode(res.toString());
          if (map['api_status'] != 0) {
            //map['data'][0]['punch_type'];
            //prefs.setString(AppConstants.LAST_PUNCH,map['data'][0]['punch_type']);
            //image_url=map['data']['path'];
            //net_image_available=true;
            cardInfoModel = CardInfoModel.fromJson(map);
            String s = '';
            isdataloaded = true;
            image_url=cardInfoModel.data.imagepath;
            var image=await ImageDownloader.downloadImage(image_url,destination: AndroidDestinationType.custom()..inExternalFilesDir());
            var path = await ImageDownloader.findPath(image);
            SQLiteDbProvider.db.storeProfileData(prefs.getInt(AppConstants.USER_ID),'${res.toString()}','"$path"');
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
    else{
      var data=await SQLiteDbProvider.db.fetchProfileData(prefs.getInt(AppConstants.USER_ID));
      if(data!=null && data.isNotEmpty)
        {
          var res=data[0].replaceAll('***', '');
          Map<String, dynamic> map = json.decode(res);
          cardInfoModel = CardInfoModel.fromJson(map);
          isdataloaded = true;
          image_url=data[1];
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
  }

  /*Future getImageFromCamera() async{
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    //setState(() {
    //_image=image.
    if(image!=null)
      _image=File(image.path);
    //});
    _cropImage(_image);
  }

  Future getImageFromGallery() async{
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    //setState(() {
    //_image=image.
    if(image!=null)
      _image=File(image.path);
    //});
    _cropImage(_image);
  }*/
}
