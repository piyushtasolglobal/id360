import 'dart:async';
import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:id_360/others/constants.dart';
import 'package:id_360/others/user_controller.dart';
import 'package:id_360/screens/registerotp.dart';
import 'package:id_360/service/ApiManager.dart';
import 'package:intl/intl.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsandConditionsScreen extends StatefulWidget {
  @override
  _TermsandConditionsScreenState createState() => _TermsandConditionsScreenState();


}



class _TermsandConditionsScreenState extends State<TermsandConditionsScreen>
    with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  dispose() {
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
          AppConstants.txt_termsandconditions,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: 'https://www.indolytics.com/',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
    return WebView(
      initialUrl: 'https://flutter.dev',
    );
  }
}
