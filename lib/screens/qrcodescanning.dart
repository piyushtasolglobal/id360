import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:id_360/others/constants.dart';
import 'package:id_360/service/ApiManager.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboardscreen.dart';

class QrScanningScreen extends StatefulWidget {

  String office_id='';
  String card_user_id='';
  String last_punch='';

  QrScanningScreen(this.office_id,this.card_user_id,this.last_punch);

  @override
  _QrScanningScreenState createState() => _QrScanningScreenState();
}

class _QrScanningScreenState extends State<QrScanningScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;

  QRViewController controller;



  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
        Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                  'Barcode Type: ${describeEnum(result.format)}   Data: ${result.code}')
                  : Text('Scan a code'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
       // controller.pauseCamera();
        //id=28,name=,
        //url=>https://tasolglobal.com/dev/ID360/public/view/office_qrcode/viewofficegenerateqrcode/elRuZkRtcXcrOXBUTjVBSFVMTGtDUT09
        //print();
        //result!.code!.substring(result!.code!.indexOf("="),result!.code!.indexOf(","));
        _mark_Attendance_Punch(result.code.substring(
            result.code.indexOf("=") + 1, result.code.indexOf(",")));
        //print(result!.code);
      });

    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _mark_Attendance_Punch(String inst_id) async {
    if(inst_id!=widget.office_id)
      {
        EasyLoading.showToast(AppConstants.attendance_office_diff,
            toastPosition: EasyLoadingToastPosition.bottom);
        Navigator.pop(context);
      }
    else{
      EasyLoading.show(
        status: 'Please Wait!',
        maskType: EasyLoadingMaskType.black,
      );

      DateTime datenow = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd').format(datenow);
      String formattedtime = DateFormat('kk:mm:ss').format(datenow);
      //SharedPreferences prefs = await SharedPreferences.getInstance();
      String punch_type = '';
      String last_punch=widget.last_punch;
      if (last_punch!=null) {
        if (last_punch.isEmpty) {
          punch_type = 'Check In';
        } else if (last_punch == 'Check In') {
          punch_type = 'Check Out';
        } else if (last_punch == 'Check Out') {
          punch_type = 'Check In';
        }
      } else {
        punch_type = 'Check In';
      }
      ///////////////////////////////

      //////////////////////////////

      Response res = await ApiManager().markAttendanceApi(
          formattedDate,
          formattedtime,
          '',
          inst_id,
          punch_type,
          widget.card_user_id,false);
      if (res != null && res.data != null) {
        String resf = res.toString().replaceAll(r"\'", "");
        Map<String, dynamic> map = json.decode(resf);
        if (map['api_status'] != 0) {
          //map['data'][0]['punch_type'];
          //prefs.setString(AppConstants.LAST_PUNCH,map['data'][0]['punch_type']);
          EasyLoading.showToast(AppConstants.txt_attendance_success,
              toastPosition: EasyLoadingToastPosition.bottom);
          if (punch_type == 'Check In') {
            //prefs.setString(AppConstants.LAST_PUNCH, "Check In");
            last_punch="Check In";
          } else {
            //prefs.setString(AppConstants.LAST_PUNCH, "Check Out");
            last_punch="Check Out";
          }
        } else {

          EasyLoading.showToast(map['api_message'],
              toastPosition: EasyLoadingToastPosition.bottom);
        }
      } else {
        EasyLoading.showToast(AppConstants.something_wrong,
            toastPosition: EasyLoadingToastPosition.bottom);
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
      /*Navigator.pop(context);*/
      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DashboardScreen(sharedPreferences.getString(AppConstants.USER_NAME).toString(),
              sharedPreferences.getString(AppConstants.USER_EMAIL).toString())));
    }
  }
}
