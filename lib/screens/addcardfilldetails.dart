import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:id_360/database/dbprovider.dart';
import 'package:id_360/models/cardinfodynamicformmodel.dart';
import 'package:id_360/models/citymodel.dart';
import 'package:id_360/models/countrymodel.dart';
import 'package:id_360/models/dynamicformvaluemodel.dart';
import 'package:id_360/models/statemodel.dart' as m;
import 'package:id_360/others/constants.dart';
import 'package:id_360/screens/registerotp.dart';
import 'package:id_360/screens/registerotpuser.dart';
import 'package:id_360/service/ApiManager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboardscreen.dart';

DateTime selectedDatenew = DateTime.now();

Country sel_countryformnew;
City sel_cityformnew;
m.State sel_stateformnew;


class AddCardDynamicFormScreen extends StatefulWidget {
  String inst_id='';
  String file_path='';

  //{"api_status":0,"api_message":"Not Found","data":"Serach Result Not Found"}
  AddCardDynamicFormScreen(@required this.inst_id,this.file_path);

  @override
  _AddCardDynamicFormScreen createState() =>
      _AddCardDynamicFormScreen(this.inst_id);
}

Map<String, DynamicFormValueModel> mapvaluesnew = Map();

class _AddCardDynamicFormScreen
    extends State<AddCardDynamicFormScreen>
    with TickerProviderStateMixin {

  void set_session(int id,String name,String email,String otp) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(AppConstants.USER_ID, id);
    prefs.setBool(AppConstants.IS_LOGGEDIN, true);
    prefs.setString(AppConstants.USER_NAME, name);
    prefs.setString(AppConstants.USER_EMAIL, email);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => RegisterOtpScreenUser(id.toString(),otp)));
  }

  String inst_id;
  List<Country> countrylist = [];
  List<City> citylist = [];
  List<m.State> statelist = [];
  String inst_sel = "";
  bool is_form_loaded = false;
  List<Widget> widgetListglobal = [];

  _AddCardDynamicFormScreen(@required this.inst_id);
  /*AnimationController _controller;
  Animation<double> _animation;*/
  //final instcontroller = TextEditingController();
  //final emailcontroller = TextEditingController();
  //final countrycontroller = TextEditingController();
  //final websitecontroller = TextEditingController();
  //final rolecontroller = TextEditingController();
  //final fullnamecontroller = TextEditingController();
  //final noofcardscontroller = TextEditingController();

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
    print(inst_id);
    fetch_dynamic_form(inst_id);
  }

  @override
  dispose() {
    //_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Widget child;

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
          AppConstants.txt_card_det,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: widgetListglobal,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> fetch_dynamic_form(inst_id) async {
    EasyLoading.show(
      status: 'Please Wait!',
      maskType: EasyLoadingMaskType.black,
    );
    Response res =
    await ApiManager().dynamicFormFetchCardAddApi(inst_id,false);
    if (res!= null) {
      if (res.data != null) {
        //String temp=res.data.toString().replaceAll(r"\'", "");
        String temp = res.data.toString();
        Map<String, dynamic> map = json.decode(temp.replaceAll(r"\'", ""));
        log(temp);
        if (map['api_status'] == 0) {
          EasyLoading.showToast(map['message'],
              toastPosition: EasyLoadingToastPosition.bottom);
          build_form(Map());
        } else {
          build_form(map);
        }
      } else {
        //
        EasyLoading.showToast(AppConstants.something_wrong,
            toastPosition: EasyLoadingToastPosition.bottom);
      }
    }
    else
    {
      EasyLoading.showToast(AppConstants.something_wrong,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
    EasyLoading.dismiss(animation: true);
  }

  void build_form(Map<String, dynamic> map) {
    if (map.isEmpty) {
      widgetListglobal.clear();
      //widgetListglobal.add(Expanded(child: SizedBox()));
      widgetListglobal.add(Center(
        child: Text(
          AppConstants.txt_register_not_available,
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
      //widgetListglobal.add(Expanded(child: SizedBox()));
    } else {
      CardInfoDynamicFormModel dynamicFormModel = CardInfoDynamicFormModel.fromJson(map);
      List<Widget> widgetList = [];
      List<Data> datalist = dynamicFormModel.data;
      for (int i = 0; i < datalist.length; i++) {
        Data data = datalist[i];
        if (data.type == 'text' || data.type == 'textarea') {
          widgetList.add(build_name(i, data.label, data.type, data.validation));
        } else if (data.type == 'email') {
          widgetList
              .add(build_email(i, data.label, data.type, data.validation));
        } else if (data.type == 'number') {
          widgetList
              .add(build_number(i, data.label, data.type, data.validation));
        } else if (data.type == 'date') {
          widgetList.add(build_date(i, data.label, data.type, data.validation));
        } else if (data.type == 'password') {
          widgetList
              .add(build_password(i, data.label, data.type, data.validation));
        } else if (data.type == 'select') {
          //sel_item="Select ${data.label}";
          widgetList.add(build_dropdown(i, data.label,
              list_fromString(data.value), data.type, data.validation));
        } else if (data.type == 'radio') {
          widgetList.add(build_radio(i, data.label, list_fromString(data.value),
              data.type, data.validation));
        } else if (data.type == 'checkbox') {
          widgetList.add(build_checkbox(i, data.label,
              list_fromString(data.value), data.type, data.validation));
        }
        else if (data.type == 'countries') {
          widgetList
              .add(build_countrypicker(i, data.label, data.type, data.validation));
        }
        else if (data.type == 'states') {
          widgetList
              .add(build_statepicker(i, data.label, data.type, data.validation));
        }
        else if (data.type == 'cities') {
          widgetList
              .add(build_citypicker(i, data.label, data.type, data.validation));
        }
        else if (data.type == 'file') {
          widgetList
              .add(build_filepicker(i, data.label, data.type, data.validation));
        }

        if (i == datalist.length - 1) {
          widgetList.add(build_submit_button());
        }
      }
      widgetListglobal = widgetList;
    }
    setState(() {});
  }



  List<String> list_fromString(String s) {
    final splitNames = s.split(',');
    List splitList = [];
    for (int i = 0; i < splitNames.length; i++) {
      splitList.add(splitNames[i]);
    }
    return splitNames;
  }

  String list_toString(List<String> list) {
    String final_string = '';
    if (list.length == 0)
      return '';
    else if (list.length == 1)
      return list.elementAt(0);
    else
      for (int i = 0; i < list.length; i++) {
        if (i != 0) {
          final_string += ',' + list.elementAt(i);
        } else {
          final_string = list.elementAt(i);
        }
      }
    return final_string;
  }

  Widget build_name(int index, String label, String type, String validation) {
    //var hinttext = "Enter label";
    DynamicFormValueModel dynamicFormValueModel = DynamicFormValueModel();
    dynamicFormValueModel.label = label;
    dynamicFormValueModel.value = '';
    dynamicFormValueModel.type = type;
    dynamicFormValueModel.isVal =
    (validation != null && validation == 'Yes') ? true : false;
    mapvaluesnew[label] = dynamicFormValueModel;
    return Column(
      children: [
        if (index != 0)
          SizedBox(
            height: 20,
          ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 18,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: TextFormField(
            onChanged: (val) {
              //print(val);
              DynamicFormValueModel dynamicformvaluemodel = mapvaluesnew[label];
              dynamicformvaluemodel.value = val;
              mapvaluesnew[label] = dynamicformvaluemodel;
            },
            //controller: lnamecontroller,
            keyboardType: TextInputType.text,
            style: TextStyle(fontSize: 20.0, color: Colors.white),
            cursorColor: Colors.white,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              /*icon: const Icon(Icons.phone),*/
              hintText: "Enter $label",
              hintStyle: TextStyle(fontSize: 20.0, color: Colors.white54),
            ),
          ),
        ),
      ],
    );
  }

  Widget build_email(int index, String label, String type, String validation) {
    DynamicFormValueModel dynamicFormValueModel = DynamicFormValueModel();
    dynamicFormValueModel.label = label;
    dynamicFormValueModel.value = '';
    dynamicFormValueModel.type = type;
    dynamicFormValueModel.isVal =
    (validation != null && validation == 'Yes') ? true : false;
    mapvaluesnew[label] = dynamicFormValueModel;
    return Column(
      children: [
        if (index != 0)
          SizedBox(
            height: 20,
          ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 18,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: TextFormField(
            //controller: emailcontroller,
            onChanged: (val) {
              //print(val);
              DynamicFormValueModel dynamicformvaluemodel = mapvaluesnew[label];
              dynamicformvaluemodel.value = val;
              mapvaluesnew[label] = dynamicformvaluemodel;
            },
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(fontSize: 20.0, color: Colors.white),
            cursorColor: Colors.white,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              /*icon: const Icon(Icons.phone),*/
              hintText: "Enter $label",
              hintStyle: TextStyle(fontSize: 20.0, color: Colors.white54),
            ),
          ),
        ),
      ],
    );
  }

  Widget build_password(
      int index, String label, String type, String validation) {
    DynamicFormValueModel dynamicFormValueModel = DynamicFormValueModel();
    dynamicFormValueModel.label = label;
    dynamicFormValueModel.value = '';
    dynamicFormValueModel.type = type;
    dynamicFormValueModel.isVal =
    (validation != null && validation == 'Yes') ? true : false;
    mapvaluesnew[label] = dynamicFormValueModel;
    return Column(
      children: [
        if (index != 0)
          SizedBox(
            height: 20,
          ),
        Text(
          label,
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
            onChanged: (val) {
              //print(val);
              DynamicFormValueModel dynamicformvaluemodel = mapvaluesnew[label];
              dynamicformvaluemodel.value = val;
              mapvaluesnew[label] = dynamicformvaluemodel;
            },
            //controller: passwordcontroller,
            keyboardType: TextInputType.visiblePassword,
            inputFormatters: [
              LengthLimitingTextInputFormatter(60),
            ],
            style: TextStyle(fontSize: 20.0, color: Colors.white),
            cursorColor: Colors.white,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              /*icon: const Icon(Icons.phone),*/
              hintText: "Enter $label",
              hintStyle: TextStyle(fontSize: 20.0, color: Colors.white54),
            ),
          ),
        ),
      ],
    );
  }

  Widget build_date(int index, String label, String type, String validation) {
    //TextFormFieldWidget textFormFieldWidget=TextFormFieldWidget(label: label);
    DynamicFormValueModel dynamicFormValueModel = DynamicFormValueModel();
    dynamicFormValueModel.label = label;
    dynamicFormValueModel.value = '';
    dynamicFormValueModel.type = type;
    dynamicFormValueModel.isVal =
    (validation != null && validation == 'Yes') ? true : false;
    mapvaluesnew[label] = dynamicFormValueModel;
    return TextFormFieldWidget(label: label, type: type, index: index);
  }

  Widget build_filepicker(
      int index, String label, String type, String validation) {
    //TextFormFieldWidget textFormFieldWidget=TextFormFieldWidget(label: label);
    DynamicFormValueModel dynamicFormValueModel = DynamicFormValueModel();
    dynamicFormValueModel.label = label;
    dynamicFormValueModel.value = '';
    dynamicFormValueModel.type = type;
    dynamicFormValueModel.isVal =
    (validation != null && validation == 'Yes') ? true : false;
    mapvaluesnew[label] = dynamicFormValueModel;
    return TextFormFieldWidget(label: label, type: type, index: index);
  }

  Widget build_countrypicker(
      int index, String label, String type, String validation) {
    //TextFormFieldWidget textFormFieldWidget=TextFormFieldWidget(label: label);
    DynamicFormValueModel dynamicFormValueModel = DynamicFormValueModel();
    dynamicFormValueModel.label = label;
    dynamicFormValueModel.value = '';
    dynamicFormValueModel.type = type;
    dynamicFormValueModel.id = null;
    dynamicFormValueModel.isVal =
    (validation != null && validation == 'Yes') ? true : false;
    mapvaluesnew[label] = dynamicFormValueModel;
    return TextFormFieldWidget(label: label, type: type, index: index);
  }

  Widget build_citypicker(
      int index, String label, String type, String validation) {
    //TextFormFieldWidget textFormFieldWidget=TextFormFieldWidget(label: label);
    DynamicFormValueModel dynamicFormValueModel = DynamicFormValueModel();
    dynamicFormValueModel.label = label;
    dynamicFormValueModel.value = '';
    dynamicFormValueModel.type = type;
    dynamicFormValueModel.id = null;
    dynamicFormValueModel.isVal =
    (validation != null && validation == 'Yes') ? true : false;
    mapvaluesnew[label] = dynamicFormValueModel;
    return TextFormFieldWidget(label: label, type: type, index: index);
  }

  Widget build_statepicker(
      int index, String label, String type, String validation) {
    //TextFormFieldWidget textFormFieldWidget=TextFormFieldWidget(label: label);
    DynamicFormValueModel dynamicFormValueModel = DynamicFormValueModel();
    dynamicFormValueModel.label = label;
    dynamicFormValueModel.value = '';
    dynamicFormValueModel.type = type;
    dynamicFormValueModel.id = null;
    dynamicFormValueModel.isVal =
    (validation != null && validation == 'Yes') ? true : false;
    mapvaluesnew[label] = dynamicFormValueModel;
    return TextFormFieldWidget(label: label, type: type, index: index);
  }





  Widget build_number(int index, String label, String type, String validation) {
    DynamicFormValueModel dynamicFormValueModel = DynamicFormValueModel();
    dynamicFormValueModel.label = label;
    dynamicFormValueModel.value = '';
    dynamicFormValueModel.type = type;
    dynamicFormValueModel.isVal =
    (validation != null && validation == 'Yes') ? true : false;
    mapvaluesnew[label] = dynamicFormValueModel;
    return Column(
      children: [
        if (index != 0)
          SizedBox(
            height: 20,
          ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 18,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: TextFormField(
            //controller: passwordcontroller,
            onChanged: (val) {
              //print(val);
              DynamicFormValueModel dynamicformvaluemodel = mapvaluesnew[label];
              dynamicformvaluemodel.value = val;
              mapvaluesnew[label] = dynamicformvaluemodel;
            },
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 20.0, color: Colors.white),
            cursorColor: Colors.white,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              /*icon: const Icon(Icons.phone),*/
              hintText: "Enter $label",
              hintStyle: TextStyle(fontSize: 20.0, color: Colors.white54),
            ),
          ),
        ),
      ],
    );
  }

  Widget build_submit_button() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 25,
        ),
        Padding(
          padding: EdgeInsets.only(left: 40, right: 40, bottom: 20),
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(AppColors.whiteColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.all(15))),
            child: Text(
              AppConstants.txt_submit,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 20),
            ),
            onPressed: () {
              check_val();
            },
          ),
        ),
      ],
    );
  }

  Widget build_checkbox(int index, String label, List<String> list, String type,
      String validation) {
    DynamicFormValueModel dynamicFormValueModel = DynamicFormValueModel();
    dynamicFormValueModel.label = label;
    dynamicFormValueModel.value = '';
    dynamicFormValueModel.type = type;
    dynamicFormValueModel.isVal =
    (validation != null && validation == 'Yes') ? true : false;
    mapvaluesnew[label] = dynamicFormValueModel;
    return Column(
      children: [
        if (index != 0)
          SizedBox(
            height: 20,
          ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 18,
          ),
        ),
        CheckboxGroup(
          labels: list,
          onSelected: (List<String> checked) {
            DynamicFormValueModel dynamicformvaluemodel = mapvaluesnew[label];
            dynamicformvaluemodel.value = list_toString(checked);
            mapvaluesnew[label] = dynamicformvaluemodel;
          },
          checkColor: Colors.white,
          activeColor: Colors.blueGrey,
          itemBuilder: (Checkbox cb, Text text, int i) {
            return Padding(
              padding: EdgeInsets.only(left: 15, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      text.data.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  cb,
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget build_radio(int index, String label, List<String> list, String type,
      String validation) {
    DynamicFormValueModel dynamicFormValueModel = DynamicFormValueModel();
    dynamicFormValueModel.label = label;
    dynamicFormValueModel.value = '';
    dynamicFormValueModel.type = type;
    dynamicFormValueModel.isVal =
    (validation != null && validation == 'Yes') ? true : false;
    mapvaluesnew[label] = dynamicFormValueModel;
    return Column(
      children: [
        if (index != 0)
          SizedBox(
            height: 20,
          ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 18,
          ),
        ),
        Center(
          child: RadioButtonGroup(
            labels: list,
            onSelected: (String checked) {
              DynamicFormValueModel dynamicformvaluemodel = mapvaluesnew[label];
              dynamicformvaluemodel.value = checked;
              mapvaluesnew[label] = dynamicformvaluemodel;
            },
            activeColor: Colors.white,
            itemBuilder: (Radio rb, Text text, int i) {
              return Padding(
                padding: EdgeInsets.only(left: 15, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        text.data.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    rb,
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget build_dropdown(int index, String label, List<String> list, String type,
      String validation) {
    DynamicFormValueModel dynamicFormValueModel = DynamicFormValueModel();
    dynamicFormValueModel.label = label;
    dynamicFormValueModel.value = '';
    dynamicFormValueModel.type = type;
    dynamicFormValueModel.isVal =
    (validation != null && validation == 'Yes') ? true : false;
    mapvaluesnew[label] = dynamicFormValueModel;
    return Column(
      children: [
        if (index != 0)
          SizedBox(
            height: 20,
          ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 10),
          child: Container(
            padding: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                color: AppColors.bg_reg_options,
                borderRadius: BorderRadius.circular(10)),
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButtonWidget(
                list: list,
                label: label,
              ),
            ),
          ),
        )
      ],
    );
  }

  /*Widget file_picker(String label)
  {

  }

  Widget drop_down(String label,List<>)
  {

  }*/
  Future<void> check_val() async {
    //int size=mapvaluesnew.length;
    int count = 0;
    String token='';
    try{
      token=await FirebaseMessaging.instance.getToken();
      print("Firebase Token Fetch");
    }
    catch(e){print("Device Token Fetch Failed"+e.toString());}
    print("Device Token: "+token);
    //Map<String,String> map=Map();
    var formData = FormData();
    bool loop_stop = false;
    mapvaluesnew.forEach((key, value) {
      DynamicFormValueModel dynamicFormValueModel = mapvaluesnew[key];
      count++;
      if (!loop_stop) {
        if (count != mapvaluesnew.length+1) {
          if (dynamicFormValueModel.isVal &&
              dynamicFormValueModel.value.isEmpty) {
            loop_stop = true;
            if (dynamicFormValueModel.type == 'select' ||
                dynamicFormValueModel.type == 'radio' ||
                dynamicFormValueModel.type == 'checkbox' ||
                dynamicFormValueModel.type == 'file' ||
                dynamicFormValueModel.type == 'date' ||
                dynamicFormValueModel.type == 'cities' ||
                dynamicFormValueModel.type == 'states' ||
                dynamicFormValueModel.type == 'countries') {
              EasyLoading.showToast("Select ${dynamicFormValueModel.label}",
                  toastPosition: EasyLoadingToastPosition.bottom);
            } else {
              EasyLoading.showToast("Enter ${dynamicFormValueModel.label}",
                  toastPosition: EasyLoadingToastPosition.bottom);
            }
          } else if (dynamicFormValueModel.isVal &&
              !dynamicFormValueModel.value.isEmpty) {
            /*if (dynamicFormValueModel.type == 'file' &&
                !dynamicFormValueModel.value.isEmpty) {
              formData.files.add(MapEntry(
                key,
                MultipartFile.fromFileSync(dynamicFormValueModel.value),
              ));
            }
            else */if(dynamicFormValueModel.type == 'cities' ||
                dynamicFormValueModel.type == 'states' ||
                dynamicFormValueModel.type == 'countries')
            {
              formData.fields.add(MapEntry(key.toLowerCase(), dynamicFormValueModel.id!=null?dynamicFormValueModel.id.toString():''));
            }
            else {
              formData.fields.add(MapEntry(key.toLowerCase(), dynamicFormValueModel.value));
            }
          } else if (!dynamicFormValueModel.isVal &&
              !dynamicFormValueModel.value.isEmpty) {
            /*if (dynamicFormValueModel.type == 'file' &&
                !dynamicFormValueModel.value.isEmpty) {
              formData.files.add(MapEntry(
                key,
                MultipartFile.fromFileSync(dynamicFormValueModel.value),
              ));
            }
            else */if(dynamicFormValueModel.type == 'cities' ||
                dynamicFormValueModel.type == 'states' ||
                dynamicFormValueModel.type == 'countries')
            {
              formData.fields.add(MapEntry(key.toLowerCase(), dynamicFormValueModel.id!=null?dynamicFormValueModel.id.toString():''));
            }
            else {
              formData.fields.add(MapEntry(key.toLowerCase(), dynamicFormValueModel.value));
            }
          } else {
            formData.fields.add(MapEntry(key.toLowerCase(), ''));
            ;
          }
        }
      }
    });
    if (!loop_stop) {
      formData.fields.add(MapEntry('institution_id', widget.inst_id));
      formData.fields.add(MapEntry('token', token));
      formData.files.add(MapEntry(
        'photo',
        MultipartFile.fromFileSync(widget.file_path),
      ));
      submit_data(formData);
      //print(formData);
      //generate json
      /*map['inst_id']=inst_id;
            print(jsonEncode(map));*/
    }
    //mapvaluesnew.forEach((k, v) => print("Key : $k, Value : $v"));
  }

  Future<void> submit_data(FormData formData) async {
    EasyLoading.show(
      status: 'Please Wait!',
      maskType: EasyLoadingMaskType.black,
    );
    print(formData);
    //{"api_status":1,"api_message":"success save you Request","data":{"user_registrationoid":75,"data":{"name":"test","email":"test@g
    Response res = await ApiManager().dynamicCardFormUpload(formData,false);
    String temp = res.data.toString();
    Map<String, dynamic> map = json.decode(temp);
    print("map");
    print(map);
    if (map['api_status'] == 0) {
      print(map['api_message']);
      EasyLoading.showToast(map['api_message'],
          toastPosition: EasyLoadingToastPosition.bottom);
    } else {
      EasyLoading.showToast(AppConstants.add_card_success,
          toastPosition: EasyLoadingToastPosition.bottom);
      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DashboardScreen(sharedPreferences.getString(AppConstants.USER_NAME).toString(),
              sharedPreferences.getString(AppConstants.USER_EMAIL).toString())));
      //Navigator.of(context).pop();
      //set_session(map['data']['user_registrationoid'],map['data']['data']['name'] ,map['data']['data']['email'],map['data']['data']['otp']);
    }
    EasyLoading.dismiss(animation: true);
  }
}

class DropdownButtonWidget extends StatefulWidget {
  String label;
  List<String> list;
  DropdownButtonWidget({Key key, this.label,  this.list})
      : super(key: key);

  @override
  DropdownButtonWidgetState createState() =>
      DropdownButtonWidgetState(this.label, this.list);
}

class DropdownButtonWidgetState extends State<DropdownButtonWidget> {
  String label;
  List<String> list;
  DropdownButtonWidgetState(this.label, this.list);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Center(
        child: Text(
          mapvaluesnew[label].value.isEmpty
              ? "Select ${label}"
              : mapvaluesnew[label].value,
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      iconEnabledColor: Colors.white,
      iconDisabledColor: Colors.white,
      underline: SizedBox(),
      dropdownColor: AppColors.bg_reg_options,
      style: TextStyle(color: Colors.white),
      isExpanded: true,
      items: list.map((String value) {
        return DropdownMenuItem<String>(
            alignment: Alignment.center,
            value: value,
            child: Center(child: Text(value)));
      }).toList(),
      onChanged: (val) {
        //sel_item=val.toString();
        DynamicFormValueModel dynamicformvaluemodel = mapvaluesnew[label];
        dynamicformvaluemodel.value = val.toString();
        mapvaluesnew[label] = dynamicformvaluemodel;
        this.setState(() {});
      },
    );
  }
}

class TextFormFieldWidget extends StatefulWidget {
  String label;
  String type;
  int index;
  //List<String> list;
  TextFormFieldWidget(
      {Key key,  this.label,  this.type,  this.index})
      : super(key: key);

  @override
  TextFormFieldWidgetState createState() =>
      TextFormFieldWidgetState(this.label, this.type, this.index);
}

class TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  String label;
  int index;
  String type;
  List<Country> countrylist = [];
  List<City> citylist = [];
  List<m.State> statelist = [];
  //List<String> list;
  TextFormFieldWidgetState(this.label, this.type, this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (index != 0)
          SizedBox(
            height: 20,
          ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 18,
          ),
        ),
        GestureDetector(
          onTap: () {
            if (type == 'file')
              pick_file(label, this);
            else if (type == 'countries')
              show_countryPicker(label,this);
            else if (type == 'states')
              show_statePicker(label,this);
            else if (type == 'cities')
              show_cityPicker(label,this);
            else
              _selectDate(context, label, this);
          },
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              controller: TextEditingController(
                text: mapvaluesnew[label].value.isEmpty
                    ? ''
                    : mapvaluesnew[label].value,
              ),
              //controller: dobcontroller,
              onChanged: (val) {
                //print(val);
                DynamicFormValueModel dynamicformvaluemodel = mapvaluesnew[label];
                dynamicformvaluemodel.value = val;
                mapvaluesnew[label] = dynamicformvaluemodel;
              },
              enabled: false,
              keyboardType: TextInputType.datetime,
              inputFormatters: [
                LengthLimitingTextInputFormatter(100),
              ],
              style: TextStyle(fontSize: 20.0, color: Colors.white),
              cursorColor: Colors.white,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                /*icon: const Icon(Icons.phone),*/
                hintText: "Select ${label}",
                hintStyle: TextStyle(fontSize: 20.0, color: Colors.white54),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void show_countryPicker(String label,
      TextFormFieldWidgetState textFormFieldWidgetState) async {
    if (countrylist.isEmpty)
      countrylist = await SQLiteDbProvider.db.getCountryList();
    //print(countrylist);

    alert_country_pick(label,textFormFieldWidgetState);
    /*setState(() {

    });*/
  }

  void show_statePicker(String label,
      TextFormFieldWidgetState textFormFieldWidgetState) async {
    if (sel_countryformnew != null){
      //if(statelist.isEmpty)
      statelist = await SQLiteDbProvider.db.getStateListonCountry(sel_countryformnew.id);

      alert_state_pick(label,textFormFieldWidgetState);
    }
    else
      EasyLoading.showToast(AppConstants.countryerror,
          toastPosition: EasyLoadingToastPosition.bottom);
    /*setState(() {

    });*/
  }

  void show_cityPicker(String label,
      TextFormFieldWidgetState textFormFieldWidgetState) async {
    if (sel_stateformnew != null){
      //if(citylist.isEmpty)
      citylist = await SQLiteDbProvider.db.getCityListonState(sel_stateformnew.id);

      alert_city_pick(label,textFormFieldWidgetState);
    }
    else
      EasyLoading.showToast(AppConstants.stateerror,
          toastPosition: EasyLoadingToastPosition.bottom);
  }

  alert_country_pick(String label,
      TextFormFieldWidgetState textFormFieldWidgetState) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Search Country'),
            content: setupAlertDialoadContainerCountry(label,textFormFieldWidgetState),
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

  alert_city_pick(String label,
      TextFormFieldWidgetState textFormFieldWidgetState) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Search City'),
            content: setupAlertDialoadContainerCity(label,textFormFieldWidgetState),
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

  alert_state_pick(String label,
      TextFormFieldWidgetState textFormFieldWidgetState) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Search State'),
            content: setupAlertDialoadContainerState(label,textFormFieldWidgetState),
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

  void refresh_screen() {
    setState(() {});
  }

  Widget setupAlertDialoadContainerCountry(String label,
      TextFormFieldWidgetState textFormFieldWidgetState) {
    return MyDialogCountry(countrylist, refresh_screen,label,textFormFieldWidgetState);
  }

  Widget setupAlertDialoadContainerCity(String label,
      TextFormFieldWidgetState textFormFieldWidgetState) {
    return MyDialogCity(citylist, refresh_screen,label,textFormFieldWidgetState);
  }

  Widget setupAlertDialoadContainerState(String label,
      TextFormFieldWidgetState textFormFieldWidgetState) {
    return MyDialogState(statelist, refresh_screen,label,textFormFieldWidgetState);
  }
}

Future pick_file(
    String label, TextFormFieldWidgetState textFormFieldWidgetState) async {
  FilePickerResult result =
  await FilePicker.platform.pickFiles(type: FileType.image);

  if (result != null) {
    File file = File(result.files.single.path.toString());
    _cropImage(label, textFormFieldWidgetState, file);
    //textFormFieldWidget.createState();
    //print(file.absolute.path);
  } else {
    // User canceled the picker
  }
}

Future<Null> _cropImage(String label,
    TextFormFieldWidgetState textFormFieldWidgetState, File file) async {
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
    ],
  );

  // File croppedFile = await ImageCropper().cropImage(
  //     maxHeight: 200,
  //     maxWidth: 200,
  //     sourcePath: file.path,
  //     aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
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
  //         initAspectRatio: CropAspectRatioPreset.square,
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
    print(croppedFile.path);
    DynamicFormValueModel dynamicformvaluemodel = mapvaluesnew[label];
    dynamicformvaluemodel.value = croppedFile.path;
    mapvaluesnew[label] = dynamicformvaluemodel;
    textFormFieldWidgetState.setState(() {});
  }
}

_selectDate(BuildContext context, String label,
    TextFormFieldWidgetState textFormFieldWidgetState) async {
  final DateTime picked = await showDatePicker(
    context: context,
    initialDate: selectedDatenew, // Refer step 1
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
  if (picked != null) {
    /*setState(() {
      final f =  DateFormat('yyyy-MM-dd');
      DateTime s=f.parse("${picked.year}-${picked.month}-${picked.day}").toLocal();
      selectedDate=s;
    });*/
    textFormFieldWidgetState.setState(() {
      final f = DateFormat('yyyy-MM-dd');
      DateTime s =
      f.parse("${picked.year}-${picked.month}-${picked.day}").toLocal();
      selectedDatenew = s;
      DynamicFormValueModel dynamicformvaluemodel = mapvaluesnew[label];
      dynamicformvaluemodel.value = f.format(s);
      mapvaluesnew[label] = dynamicformvaluemodel;
    });
  }
}

class MyDialogCountry extends StatefulWidget {
  MyDialogCountry(this.countrylist, this.itemSelected,this.label,this.textFormFieldWidgetState);
  VoidCallback itemSelected;
  List<Country> countrylist = [];
  String label;
  TextFormFieldWidgetState textFormFieldWidgetState;

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
                    Navigator.of(context).pop();
                    widget.textFormFieldWidgetState.setState(() {
                      sel_countryformnew = filteredlist[index];
                      sel_cityformnew = null;
                      sel_stateformnew = null;
                      DynamicFormValueModel dynamicformvaluemodel = mapvaluesnew[widget.label];
                      dynamicformvaluemodel.value = sel_countryformnew.name.toString();
                      dynamicformvaluemodel.id = sel_countryformnew.id.toString();
                      mapvaluesnew[widget.label] = dynamicformvaluemodel;
                    });
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
  MyDialogCity(this.citylist, this.itemSelected,this.label,this.textFormFieldWidgetState);
  String label;
  TextFormFieldWidgetState textFormFieldWidgetState;
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
                    Navigator.of(context).pop();
                    //itemSelected();
                    widget.textFormFieldWidgetState.setState(() {
                      sel_cityformnew = filteredlist[index];
                      DynamicFormValueModel dynamicformvaluemodel = mapvaluesnew[widget.label];
                      dynamicformvaluemodel.value = sel_cityformnew.name.toString();
                      dynamicformvaluemodel.id = sel_cityformnew.id.toString();
                      mapvaluesnew[widget.label] = dynamicformvaluemodel;
                    });
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

class MyDialogState extends StatefulWidget {
  MyDialogState(this.statelist, this.itemSelected,this.label,this.textFormFieldWidgetState);

  List<m.State> statelist = [];
  VoidCallback itemSelected;
  String label;
  TextFormFieldWidgetState textFormFieldWidgetState;

  @override
  _MyDialogStateState createState() =>
      new _MyDialogStateState(statelist, itemSelected);
}

class _MyDialogStateState extends State<MyDialogState> {
  List<m.State> statelist = [];
  VoidCallback itemSelected;
  _MyDialogStateState(this.statelist, this.itemSelected);

  List<m.State> filteredlist = [];

  //int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    filteredlist = statelist;
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
                labelText: "State",
                hintText: "Search State",
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
                    Navigator.of(context).pop();
                    widget.textFormFieldWidgetState.setState(() {
                      sel_stateformnew = filteredlist[index];
                      sel_cityformnew=null;
                      DynamicFormValueModel dynamicformvaluemodel = mapvaluesnew[widget.label];
                      dynamicformvaluemodel.value = sel_stateformnew.name.toString();
                      dynamicformvaluemodel.id = sel_stateformnew.id.toString();
                      mapvaluesnew[widget.label] = dynamicformvaluemodel;
                    });
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
    filteredlist.addAll(statelist);
    if (query.isNotEmpty) {
      filteredlist = [];
      statelist.forEach((item) {
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
