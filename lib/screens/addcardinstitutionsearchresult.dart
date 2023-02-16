import 'dart:async';
import 'dart:convert';
import 'package:country_picker/country_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:id_360/models/InstitutionModel.dart';
import 'package:id_360/others/constants.dart';
import 'package:id_360/others/user_controller.dart';
import 'package:id_360/screens/registercompany.dart';
import 'package:id_360/screens/registerotp.dart';
import 'package:id_360/service/ApiManager.dart';
import 'package:intl/intl.dart';
import 'package:select_dialog/select_dialog.dart';

import 'addcardinstitutiondetailscreen.dart';
import 'institutiondetailsscreen.dart';

class AddCardInstitutionSearchResult extends StatefulWidget {

  String country='',city='',name='';


  AddCardInstitutionSearchResult(this.name,this.country, this.city);

  @override
  _AddCardInstitutionSearchResultState createState() => _AddCardInstitutionSearchResultState();


}



class _AddCardInstitutionSearchResultState extends State<AddCardInstitutionSearchResult>
    with TickerProviderStateMixin {

  bool isfromAPiCall = false;
  List<Data> listinst = [];
  final _biggerFont = const TextStyle(
    color: Colors.white,
    fontSize: 20.0,
  );
  //UserController _userController=new UserController();
  /*AnimationController _controller;
  Animation<double> _animation;*/




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
    //configLoading();
    search_inst(widget.name,widget.country,widget.city);
  }

  @override
  dispose() {
    //_controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print("Value: 2 $inst_sel");
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
          AppConstants.txt_sel_inst,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              if (isfromAPiCall)
                Expanded(
                  child: FutureBuilder<List>(
                    initialData: [],
                    builder: (context, snapshot) {
                      return listinst.length > 0
                          ? new ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.all(10.0),
                        itemCount: listinst.length,
                        itemBuilder: (context, i) {
                          if (i == listinst.length - 1) {
                            return _buildRowLast(listinst.elementAt(i));
                          } else {
                            return _buildRow(listinst.elementAt(i));
                          }
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 10,
                          );
                        },
                      )
                          : Center(
                        child: Text(
                          AppConstants.txt_nocompany,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(Data datamodel) {
    return GestureDetector(
      onTap: () {
        //print(datamodel.company_name);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddCardInstitutionDetailsScreen(datamodel)));
      },
      child: new Container(
        decoration: BoxDecoration(
            color: AppColors.bg_reg_options,
            borderRadius: BorderRadius.all(Radius.circular(20))
          /*image: DecorationImage(
            image: AssetImage(AppImages.dash_back),
            fit: BoxFit.fill,
          ),*/
        ),
        child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(datamodel.company_name, style: _biggerFont),
                Expanded(child: SizedBox()),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 18,
                ),
              ],
            )),
      ),
    );
  }

  Widget _buildRowLast(Data datamodel) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            //print(datamodel.company_name);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddCardInstitutionDetailsScreen(datamodel)));
          },
          child: new Container(
            decoration: BoxDecoration(
                color: AppColors.bg_reg_options,
                borderRadius: BorderRadius.all(Radius.circular(20))
              /*image: DecorationImage(
                image: AssetImage(AppImages.dash_back),
                fit: BoxFit.fill,
              ),*/
            ),
            child: Padding(
                padding:
                EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(datamodel.company_name, style: _biggerFont),
                    Expanded(child: SizedBox(),),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                )),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Text(
          "Can't find your Institution?",
          style: TextStyle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RegisterCompanyScreen()));
          },
          child: Text(
            "Add Here",
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  void search_inst(name,country,city) async {
    EasyLoading.show(
      status: 'Please Wait!',
      maskType: EasyLoadingMaskType.black,
    );
    Response res = await ApiManager().institutesearchApi(
        name,
        country,
        city,false);
    //listinst
    if (res != null) {
      if (res.data != null) {
        //String temp="{\n    \"api_status\": 1,\n    \"api_message\": \"success\",\n    \"data\": [\n        {\n            \"id\": 7,\n            \"company_name\": \"IIM\",\n            \"full_name\": \"Yash Kalariya\",\n            \"company_title\": \"IIM\",\n            \"company_description\": null,\n            \"status\": \"Active\",\n            \"send_notification\": null,\n            \"cms_users_id\": 73,\n            \"country\": \"India\",\n            \"website\": \"http://www.google.com\",\n            \"role\": \"It Manager\",\n            \"no_id_cards\": 5,\n            \"email\": \"iim@gmail.com\"\n        },\n        {\n            \"id\": 6,\n            \"company_name\": \"indolytics\",\n            \"full_name\": null,\n            \"company_title\": \"indolytics\",\n            \"company_description\": \"indolytics data\",\n            \"status\": null,\n            \"send_notification\": \"Yes\",\n            \"cms_users_id\": 1,\n            \"country\": null,\n            \"website\": null,\n            \"role\": null,\n            \"no_id_cards\": null,\n            \"email\": null\n        },\n        {\n            \"id\": 5,\n            \"company_name\": \"Tailored Solaution\",\n            \"full_name\": \"Ankit Dave\",\n            \"company_title\": \"Tailored Solaution\",\n            \"company_description\": null,\n            \"status\": \"Active\",\n            \"send_notification\": null,\n            \"cms_users_id\": 69,\n            \"country\": \"india\",\n            \"website\": \"vip,com\",\n            \"role\": \"IT Manager\",\n            \"no_id_cards\": 234342,\n            \"email\": \"dave@tasolglobal.com\"\n        }\n    ]\n}";
        String resf = res.data.toString().replaceAll(r"\'", "");
        Map<String, dynamic> map = json.decode(resf);
        isfromAPiCall = true;
        if (map['api_status'] == 0) {
          EasyLoading.showToast(map['api_message'],
              toastPosition: EasyLoadingToastPosition.bottom);
          setState(() {});
        } else if (map['api_status'] == 1) {
          ///textbox,passwordtextbox,checkbox,radiobutton,
          //Map mapdata=json.decode(map['data']);
          //EasyLoading.showToast(AppConstants.reg_success,toastPosition: EasyLoadingToastPosition.bottom);
          InstitutionModel institutionModel = InstitutionModel.fromJson(map);
          listinst = institutionModel.data;
          setState(() {});
          EasyLoading.dismiss(animation: true);
          print('List: ${map}');
        } else {
          EasyLoading.showToast(AppConstants.something_wrong,
              toastPosition: EasyLoadingToastPosition.bottom);
        }
      } else {
        EasyLoading.showToast(AppConstants.something_wrong,
            toastPosition: EasyLoadingToastPosition.bottom);
      }
    } else {
      EasyLoading.showToast(AppConstants.something_wrong,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }
}
