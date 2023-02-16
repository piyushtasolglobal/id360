import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:id_360/database/dbprovider.dart';
import 'package:id_360/models/InstitutionModel.dart';
import 'package:id_360/models/citymodel.dart';
import 'package:id_360/models/countrymodel.dart';
import 'package:id_360/others/constants.dart';
import 'package:id_360/screens/institutiondetailsscreen.dart';
import 'package:id_360/screens/registercompany.dart';
import 'package:id_360/screens/registerotp.dart';
import 'package:id_360/service/ApiManager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboardscreen.dart';

class InstitutionSearchScreen extends StatefulWidget {
  @override
  _InstitutionSearchScreenState createState() =>
      _InstitutionSearchScreenState();
}
Country sel_country_add;
City sel_city_add;

class _InstitutionSearchScreenState extends State<InstitutionSearchScreen>
    with TickerProviderStateMixin {
  /*Future<void> _fetch_pref() async {
    final SharedPreferences prefs = SharedPreferences.getInstance();
  }*/
  List<Country> countrylist = [];
  List<City> citylist = [];
  /*AnimationController _controller;
  Animation<double> _animation;*/
  bool isfromAPiCall = false;
  List<Data> listinst = [];
  final _biggerFont = const TextStyle(
    color: Colors.white,
    fontSize: 20.0,
  );

  final nametextcontroller = TextEditingController();
  final countrytextcontroller = TextEditingController();
  final citytextcontroller = TextEditingController();

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
    //loadCounter();
  }

  @override
  dispose() {
    //_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (sel_country_add != null)
      countrytextcontroller.text = sel_country_add.name;
    if (sel_city_add != null) citytextcontroller.text = sel_city_add.name;
    if (sel_city_add == null) citytextcontroller.text = '';

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
          AppConstants.txt_inst_search,
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
              /*image: DecorationImage(
              image: AssetImage(AppImages.dash_back),
              fit: BoxFit.fill,
            ),*/
              ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 30,
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
                  keyboardType: TextInputType.text,
                  controller: nametextcontroller,
                  cursorColor: Colors.white,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    /*icon: const Icon(Icons.phone),*/
                    hintText: AppConstants.txt_insnamee,
                    hintStyle: TextStyle(fontSize: 20.0, color: Colors.white54),
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
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: GestureDetector(
                  onTap: () {
                    /*showCountryPicker(
                      context: context,
                      showPhoneCode: false, // optional. Shows phone code before the country name.
                      onSelect: (Country country) {
                        countrytextcontroller.text= country.name;
                        //print('Select country: ${country.displayName}');
                      },
                    );*/
                    show_countryPicker();
                  },
                  child: TextFormField(
                    enabled: false,
                    keyboardType: TextInputType.text,
                    controller: countrytextcontroller,
                    cursorColor: Colors.white,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
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
                      hintText: AppConstants.txt_countrye,
                      hintStyle:
                          TextStyle(fontSize: 20.0, color: Colors.white54),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                AppConstants.txt_cityname,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 18,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: GestureDetector(
                  onTap: () {
                    /*showCountryPicker(
                      context: context,
                      showPhoneCode: false, // optional. Shows phone code before the country name.
                      onSelect: (Country country) {
                        countrytextcontroller.text= country.name;
                        //print('Select country: ${country.displayName}');
                      },
                    );*/
                    show_cityPicker();
                  },
                  child: TextFormField(
                    enabled: false,
                    keyboardType: TextInputType.text,
                    controller: citytextcontroller,
                    cursorColor: Colors.white,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
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
                      hintText: AppConstants.txt_citynameenter,
                      hintStyle:
                          TextStyle(fontSize: 20.0, color: Colors.white54),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.only(left: 40, right: 40),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppColors.bg_reg_options),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.all(15))),
                  child: Text(
                    AppConstants.txt_search,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 20),
                  ),
                  onPressed: () {
                    check_val();
                  },
                ),
              ),
              if (isfromAPiCall)
                Padding(
                  padding:
                      EdgeInsets.only(left: 20, bottom: 10, top: 30, right: 20),
                  child: Text(
                    "INSTITUTIONS",
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
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

  void show_countryPicker() async {
    if (countrylist.isEmpty)
      countrylist = await SQLiteDbProvider.db.getCountryList();
    //print(countrylist);

    alert_country_pick();
    /*setState(() {

    });*/
  }

  void show_cityPicker() async {
    if (sel_country_add != null)
      citylist =
          await SQLiteDbProvider.db.getCityListInstiSearch(sel_country_add.id);
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

  Widget _buildRow(Data datamodel) {
    return GestureDetector(
      onTap: () {
        //print(datamodel.company_name);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => InstitutionDetailsScreen(datamodel)));
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
                builder: (context) => InstitutionDetailsScreen(datamodel)));
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
                    Expanded(child: SizedBox()),
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

  void check_val() {
    if (nametextcontroller.text.toString().trim().isEmpty) {
      EasyLoading.showToast(AppConstants.instnameerror,
          toastPosition: EasyLoadingToastPosition.bottom);
    } else if (!isValidName(nametextcontroller.text.toString().trim())) {
      EasyLoading.showToast(AppConstants.namelengtherror,
          toastPosition: EasyLoadingToastPosition.bottom);
    } else if (countrytextcontroller.text.toString().trim().isEmpty) {
      EasyLoading.showToast(AppConstants.countryerror,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
    else if (citytextcontroller.text.toString().trim().isEmpty) {
      EasyLoading.showToast(AppConstants.cityerror,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
    else {
      search_inst();
    }
  }

  void search_inst() async {
    EasyLoading.show(
      status: 'Please Wait!',
      maskType: EasyLoadingMaskType.black,
    );
    Response res = await ApiManager().institutesearchApi(
        nametextcontroller.text.toString(),
        sel_country_add.id.toString(),
        sel_city_add.id.toString(),false);
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

  bool isValidName(String name) {
    return name.length >= 3;
  }

  bool isValidCity(String city) {
    return city.length >= 2;
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
                    sel_country_add = filteredlist[index];
                    sel_city_add = null;
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
                    sel_city_add = filteredlist[index];
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
