import 'dart:async';
import 'package:flutter/material.dart';
import 'package:id_360/database/dbprovider.dart';
import 'package:id_360/models/InstitutionModel.dart';
import 'package:id_360/others/constants.dart';
import 'package:id_360/screens/institutionsearchscreen.dart';
import 'package:id_360/screens/loginregisterscreen.dart';
import 'package:id_360/screens/registercompany.dart';
import 'package:id_360/screens/registerselfid.dart';

import 'addcardaddphotoscreen.dart';
import 'dynamicformuseraddscreen.dart';

class AddCardInstitutionDetailsScreen extends StatefulWidget {
  Data data;
  AddCardInstitutionDetailsScreen(@required this.data);
  String country='-';
  @override
  _AddCardInstitutionDetailsScreenState createState() => _AddCardInstitutionDetailsScreenState(this.data);
}

class _AddCardInstitutionDetailsScreenState extends State<AddCardInstitutionDetailsScreen>
    with TickerProviderStateMixin {
  Data data;
  _AddCardInstitutionDetailsScreenState(@required this.data);
  /*AnimationController _controller;
  Animation<double> _animation;*/

  @override
  void initState() {
    super.initState();
    fetchCountry(data.country?.toString());
  }

  @override
  dispose() {
    //_controller.dispose();
    super.dispose();
  }

  void fetchCountry(String country_id) async
  {
      String value = '-';

      if (value != null)
        value = await SQLiteDbProvider.db
          .getCountryFromId(int.parse(country_id));

      setState(() {
        widget.country=value;
      });
  }

  @override
  Widget build(BuildContext context) {
    double height,widthorig,widthone;
    double space=20.0;
    MediaQueryData mediaQueryData=MediaQuery.of(context);
    widthorig=mediaQueryData.size.width;
    widthone=(widthorig-(3*space))/2;
    height=widthone;
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
          AppConstants.txt_inst_details,
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
          child: Padding(
            padding: EdgeInsets.only(left: 15,right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 10,
                ),
                _buildContainer("Name : ",data.company_name),
                SizedBox(
                  height: 20,
                ),
                _buildContainer("Email : ",data.email),
                SizedBox(
                  height: 20,
                ),
                _buildContainer("Website : ",data.website),
                SizedBox(
                  height: 20,
                ),
                _buildContainer("Country : ",widget.country),
                SizedBox(
                  height: 20,
                ),
                _buildContainer("Status : ",data.status),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40,right: 40),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(AppColors.whiteColor),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(15))
                    ),
                    child: Text(
                      AppConstants.txt_proceed,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => AddCardPhotoScreen(data.id.toString())));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContainer(String text,String value) {
    return new Container(
      decoration: BoxDecoration(
          color: AppColors.bg_reg_options,
          borderRadius: BorderRadius.all(Radius.circular(20))
        /*image: DecorationImage(
          image: AssetImage(AppImages.dash_back),
          fit: BoxFit.fill,
        ),*/
      ),
      child: Padding(
          padding: EdgeInsets.only(left:20,right:20,top: 20,bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                  text, style: _biggerFont),
              Text(
                  value, style: _biggerboldFont),
            ],
          )
      ),
    );
  }

  final _biggerFont = const TextStyle(
    color: Colors.white,
    fontSize: 20.0,
  );

  final _biggerboldFont = const TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold
  );
}



