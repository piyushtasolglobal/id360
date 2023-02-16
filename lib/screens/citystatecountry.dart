import 'dart:async';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:id_360/database/dbprovider.dart';
import 'package:id_360/models/countrymodel.dart';
import 'package:id_360/others/constants.dart';
import 'package:id_360/others/user_controller.dart';
import 'package:id_360/screens/registerotp.dart';
import 'package:id_360/service/ApiManager.dart';
import 'package:intl/intl.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:sqflite/sqflite.dart';
import 'package:dropdown_search/dropdown_search.dart';

class CityStateCountry extends StatefulWidget {
  @override
  _CityStateCountryState createState() => _CityStateCountryState();
}



class _CityStateCountryState extends State<CityStateCountry>
    with TickerProviderStateMixin {

  List<Country> countrylist=[];
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
    fetchCountry();
    //configLoading();
  }

  @override
  dispose() {
    //_controller.dispose();
    super.dispose();
  }

  void fetchCountry() async
  {
    countrylist=await SQLiteDbProvider.db.getCountryList();
    setState(() {

    });
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
          AppConstants.txt_appinfo,
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
              DropdownSearch<Country>(
                //showSearchBox: true,
                //labelText: "Name",
                //selectedItem: true,
                items: countrylist,
                filterFn: (country, filter) => country.name.contains(filter),
                itemAsString: (Country u) => u.name,
                onChanged: (Country data) => print(data.name),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*Future<List> fetchComplexData() async {
    await Future.delayed(Duration(milliseconds: 1000));
    //List _list = new List();
    List _jsonList = [
      {'vips12343'},
      {'vips1234'},
      {'test'},
      {'vips123'},
    ];
    // create a list from the text input of three items
    // to mock a list of items from an http call where
    // the label is what is seen in the textfield and something like an
    // ID is the selected value

    return _jsonList;
  }*/



  bool isValidEmail(String email)
  {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
}
