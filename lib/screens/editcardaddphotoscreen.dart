/*
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:id_360/others/constants.dart';
import 'package:id_360/screens/addcardfilldetails.dart';
import 'package:id_360/screens/institutionsearchscreen.dart';
import 'package:id_360/screens/loginregisterscreen.dart';
import 'package:id_360/screens/registercompany.dart';
import 'package:id_360/screens/registerselfid.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'editcardinfoscreen.dart';

class EditCardPhotoScreen extends StatefulWidget {

  String inst_id='';
  EditCardPhotoScreen(this.inst_id);

  @override
  _EditCardPhotoScreenState createState() => _EditCardPhotoScreenState();
}

class _EditCardPhotoScreenState extends State<EditCardPhotoScreen>
    with TickerProviderStateMixin {
AnimationController _controller;
  Animation<double> _animation;

  File _image;
  bool has_image=false;
  ImagePicker _imagePicker;
  @override
  void initState() {
    super.initState();
    _imagePicker=ImagePicker();
  }

  @override
  dispose() {
    //_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height,width;
    MediaQueryData mediaQueryData=MediaQuery.of(context);
    height=mediaQueryData.size.height;
    width=mediaQueryData.size.width;
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
          AppConstants.add_photo,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
decoration: BoxDecoration(
            color: AppColors.bg_reg
          ),

          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: height*0.30,
                    width: width*0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.whiteColor,
                      border: Border.all(color: AppColors.blackColor,width: 2),
                    ),
                    child: (_image!=null)?ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.file(_image,fit: BoxFit.cover,)):SizedBox()
                ),
                SizedBox(
                  height: 30,
                ),
Column(
                  children: [

                  ],
                ),

                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(left: 40,right: 40),
                    child: Opacity(
                      opacity: (_image!=null)?0.5:1.0,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(AppColors.bg_reg_options),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.only(
                              left: 15,right: 15,top: 20,bottom: 20,
                            ))
                        ),
                        child: Text(
                          AppConstants.take_photo,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        onPressed: () {
Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (_) => LoginEmailScreen()));

                          if(_image==null)
                            getImageFromCamera();
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(left: 40,right: 40),
                    child: Opacity(
                      opacity: (_image!=null)?0.5:1.0,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(AppColors.bg_reg_options),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.only(
                              left: 15,right: 15,top: 20,bottom: 20,
                            ))
                        ),
                        child: Text(
                          AppConstants.uplaod_photo,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        onPressed: () {
Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (_) => LoginEmailScreen()));

                          if(_image==null)
                            getImageFromGallery();
                        },
                      ),
                    ),
                  ),
                ),
                if(_image!=null)
                  SizedBox(
                    height: 20,
                  ),
                if(_image!=null)
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(left: 40,right: 40),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(AppColors.bg_reg_options),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.only(
                              left: 15,right: 15,top: 20,bottom: 20,
                            ))
                        ),
                        child: Text(
                          AppConstants.conf_proceed,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        onPressed: () {
Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => EditCardInfoScreen(_image.path)));

Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => LoginEmailScreen()));


                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getImageFromCamera() async{
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
  }

  Future<Null> _cropImage(File file) async {
    File croppedFile = await ImageCropper.cropImage(
        maxHeight: 360,
        maxWidth: 280,
        sourcePath: file.path,
        aspectRatio: CropAspectRatio(ratioX: 0.7, ratioY: 0.9),
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
        ]
            : [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: AppColors.bg_reg_options,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.ratio5x4,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          title: 'Crop Image',
        ));
    if (croppedFile != null) {
      ///data/user/0/com.indolytics.id360/cache/image_cropper_1641452251642.jpg
      //final Directory directory = await getApplicationDocumentsDirectory();
      //String path=directory.path;
      //final File newImage = await croppedFile.copy('$path/image1.jpg');
      //print(newImage.length());
      setState(() {
        _image=croppedFile;
      });
    }
  }
}



*/
