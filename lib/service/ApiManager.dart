import 'dart:convert';
import 'dart:io';


import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;
import 'package:id_360/others/constants.dart';
import 'package:id_360/service/CustomDio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Api.dart';

class ApiManager {
  Dio dio = CustomDio().client;

  Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('8.8.8.8');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on Exception {
      return false;
    }
  }

  loginApi(email,firebase_token,forced) async {
    try {
      var res=await refreshTokenApi(forced);
      if(res!=null)
      {
        //Map<String,dynamic> token=jsonDecode(res);
        //dio.options.headers['Authorization']=res;
        print("Token Fetch ==> $res");
      }
      Map<String , String> queryparam= Map();
      queryparam['username']=email;
      queryparam['token']=firebase_token;
      Response response = await dio.post(
        Api.user_login,
        queryParameters: queryparam,
        options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization':res}
        ),
      );

      return response;
    } on DioError catch (e) {
      //dismissLoader();

      if (e.response.statusCode == 500 || e.response.statusCode == 403) {
        loginApi(email,firebase_token,true);
      } else {
        //var user = e.response.data;
        // printError(info: user.toString());
        //showAlertMsg(title: user['status'].toString(), msg: user['message']);
        return;
      }
    }
  }

  /*institutefetchApi(name,country) async {
    try {
      var res=await refreshTokenApi();
      if(res!=null)
      {
        //Map<String,dynamic> token=jsonDecode(res);
        dio.options.headers['Authorization']=res;
        print("Token Fetch ==> $res");
      }
      Map<String , String> queryparam= Map();
      queryparam['company_name']=name;
      queryparam['country']=country;
      Response response = await dio.get(
          Api.get_institution,
          queryParameters: queryparam
      );

      return response;
    } on DioError catch (e) {
      //dismissLoader();

      if (e.response.statusCode == 500 || e.response.statusCode == 403) {
        institutesearchApi(name,country);
      } else {
        //var user = e.response.data;
        // printError(info: user.toString());
        //showAlertMsg(title: user['status'].toString(), msg: user['message']);
        return;
      }
    }
  }*/

  institutesearchApi(name,country,city,forced) async {
    try {
      var res=await refreshTokenApi(forced);
      if(res!=null)
      {
        //Map<String,dynamic> token=jsonDecode(res);
        //dio.options.headers['Authorization']=res;
        print("Token Fetch ==> $res");
      }
      Map<String , String> queryparam= Map();
      queryparam['company_name']=name;
      queryparam['country']=country;
      queryparam['city']=city;
      Response response = await dio.get(
          Api.search_institute,
          queryParameters: queryparam,
        options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization':res}
        ),
      );
      print(queryparam);

      return response;
    } on DioError catch (e) {
      //dismissLoader();

      if (e.response.statusCode == 500 || e.response.statusCode == 403) {
        institutesearchApi(name,country,city,true);
      } else {
        //var user = e.response.data;
        // printError(info: user.toString());
        //showAlertMsg(title: user['status'].toString(), msg: user['message']);
        return;
      }
    }
  }

  regselfidApi(fname,lname,dob,phone,email,password,website,role,country,city,insti,no_of_idcards,token,forced) async {
    try {
       var res=await refreshTokenApi(forced);
       print("Authorization token==> $res");
       print("Token send-> $token");

      if(res!=null)
      {
        //Map<String,dynamic> token=jsonDecode(res);
        //dio.options.headers['Authorization']=res;
      }
      Map<String , String> queryparam= Map();
      queryparam['fname']=fname;
      queryparam['lname']=lname;
      queryparam['dob']=dob.toString();
      queryparam['phone_number']=phone.toString();
      queryparam['email']=email;
      queryparam['password']=password;
      queryparam['website']=website;
      queryparam['role']=role;
      queryparam['country']=country;
      queryparam['city']=city;
      queryparam['status']="Pending";
      queryparam['token']=token;
      //queryparam['institution_id']=insti;
      queryparam['no_of_cards']=no_of_idcards.toString();

      Response response = await dio.post(
        Api.selfidreg,
        queryParameters: queryparam,
        options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization':res}
        ),
      );
      print("response->: " + response.toString());
      return response;

    } on DioError catch (e) {
      if (e.response.statusCode == 500 || e.response.statusCode == 403) {
        /*var res=await refreshTokenApi();
        refreshTokenApi();*/
        regselfidApi(fname,lname,dob,phone,email,password,website,role,country,city,insti,no_of_idcards,token,true);
      } else {
        //var user = e.response.data;
        // printError(info: user.toString());
        //showAlertMsg(title: user['status'].toString(), msg: user['message']);
        return null;
      }
    }
  }

  dynamicFormFetchUserRegistrationApi(inst_id,forced) async {
    try {
      var res=await refreshTokenApi(forced);
      if(res!=null)
      {
        //Map<String,dynamic> token=jsonDecode(res);
        //dio.options.headers['Authorization']=res;
        print("Token Fetch ==> $res");
      }
      Map<String , String> queryparam= Map();
      queryparam['institution_id']=inst_id;
      Response response = await dio.get(
        Api.get_dynamicformbyinstitute,
        queryParameters: queryparam,
        options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization':res}
        ),
      );
      return response;

    } on DioError catch (e) {
      if (e.response.statusCode == 500 || e.response.statusCode == 403) {
        /*var res=await refreshTokenApi();
        refreshTokenApi();*/
        dynamicFormFetchUserRegistrationApi(inst_id,true);
      } else {
        //var user = e.response.data;
        // printError(info: user.toString());
        //showAlertMsg(title: user['status'].toString(), msg: user['message']);
        return null;
      }
    }
  }


  dynamicFormFetchCardAddApi(inst_id,forced) async {
    try {
      var res=await refreshTokenApi(forced);
      if(res!=null)
      {
        //Map<String,dynamic> token=jsonDecode(res);
        //dio.options.headers['Authorization']=res;
        print("Token Fetch ==> $res");
      }
      Map<String , String> queryparam= Map();
      queryparam['institution_id']=inst_id;
      Response response = await dio.get(
        Api.get_cardformbyinstitute,
        queryParameters: queryparam,
        options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization':res}
        ),
      );
      return response;

    } on DioError catch (e) {
      if (e.response.statusCode == 500 || e.response.statusCode == 403) {
        /*var res=await refreshTokenApi();
        refreshTokenApi();*/
        dynamicFormFetchCardAddApi(inst_id,true);
      } else {
        //var user = e.response.data;
        // printError(info: user.toString());
        //showAlertMsg(title: user['status'].toString(), msg: user['message']);
        return null;
      }
    }
  }

  fetchCardInfoApi(id,forced) async {
    try {
      var res=await refreshTokenApi(forced);
      if(res!=null)
      {
        //Map<String,dynamic> token=jsonDecode(res);
        //dio.options.headers['Authorization']=res;
        print("Token Fetch ==> $res");
      }
      Map<String , String> queryparam= Map();
      queryparam['id']=id;
      Response response = await dio.post(
        Api.get_card,
        queryParameters: queryparam,
        options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization':res}
        ),
      );
      return response;

    } on DioError catch (e) {
      if (e.response.statusCode == 500 || e.response.statusCode == 403) {
        /*var res=await refreshTokenApi();
        refreshTokenApi();*/
        fetchCardInfoApi(id,true);
      } else {
        //var user = e.response.data;
        // printError(info: user.toString());
        //showAlertMsg(title: user['status'].toString(), msg: user['message']);
        return null;
      }
    }
  }

  deleteCard(id,forced) async {
    try {
      var res=await refreshTokenApi(forced);
      if(res!=null)
      {
        //Map<String,dynamic> token=jsonDecode(res);
        //dio.options.headers['Authorization']=res;
        print("Token Fetch ==> $res");
      }
      Map<String , String> queryparam= Map();
      queryparam['id']=id;
      Response response = await dio.post(
        Api.delete_card,
        queryParameters: queryparam,
        options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization':res}
        ),
      );
      return response;

    } on DioError catch (e) {
      if (e.response.statusCode == 500 || e.response.statusCode == 403) {
        /*var res=await refreshTokenApi();
        refreshTokenApi();*/
        deleteCard(id,true);
      } else {
        //var user = e.response.data;
        // printError(info: user.toString());
        //showAlertMsg(title: user['status'].toString(), msg: user['message']);
        return null;
      }
    }
  }

  deleteNotification(id,forced) async {
    try {
      var res=await refreshTokenApi(forced);
      if(res!=null)
      {
        //Map<String,dynamic> token=jsonDecode(res);
        //dio.options.headers['Authorization']=res;
        print("Token Fetch ==> $res");
      }
      Map<String , String> queryparam= Map();
      queryparam['id']=id;
      Response response = await dio.post(
        Api.delete_noti,
        queryParameters: queryparam,
        options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization':res}
        ),
      );
      return response;

    } on DioError catch (e) {
      if (e.response.statusCode == 500 || e.response.statusCode == 403) {
        /*var res=await refreshTokenApi();
        refreshTokenApi();*/
        deleteCard(id,true);
      } else {
        //var user = e.response.data;
        // printError(info: user.toString());
        //showAlertMsg(title: user['status'].toString(), msg: user['message']);
        return null;
      }
    }
  }

  dynamicCardForm(inst_id,forced) async {
    try {
      var res=await refreshTokenApi(forced);
      if(res!=null)
      {
        //Map<String,dynamic> token=jsonDecode(res);
        //dio.options.headers['Authorization']=res;
        print("Token Fetch ==> $res");
      }
      Map<String , String> queryparam= Map();
      queryparam['institution_id']=inst_id;
      Response response = await dio.get(
        Api.get_cardformbyinstitute,
        queryParameters: queryparam,
        options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization':res}
        ),
      );
      return response;

    } on DioError catch (e) {
      if (e.response.statusCode == 500 || e.response.statusCode == 403) {
        /*var res=await refreshTokenApi();
        refreshTokenApi();*/
        dynamicCardForm(inst_id,true);
      } else {
        //var user = e.response.data;
        // printError(info: user.toString());
        //showAlertMsg(title: user['status'].toString(), msg: user['message']);
        return null;
      }
    }
  }

  /*reginstiidApi({orgID, username, pass, token}) async {
    try {
      Response response = await dio.post(
        Api.selfidreg,
        data: {
          'organisation_id': orgID,
          'email': username,
          'password': pass,
          'fcm_token': token,
        },
      );

      return response;
    } on DioError catch (e) {
      //dismissLoader();

      if (e.response!.statusCode == 500 || e.response!.statusCode == 403) {
        //await refreshTokenApi();
        reginstiidApi();
      } else {
        //var user = e.response.data;
        // printError(info: user.toString());
        //showAlertMsg(title: user['status'].toString(), msg: user['message']);
        return;
      }
    }
  }*/

  fetchAttendanceApi(user_id,date,forced) async {
    try {
      var res=await refreshTokenApi(forced);
      if(res!=null)
      {
        //Map<String,dynamic> token=jsonDecode(res);
        //dio.options.headers['Authorization']=res;
        print("Token Fetch ==> $res");
      }
      Map<String , String> queryparam= Map();
      queryparam['user_Id']=user_id.toString();
      queryparam['date']=date;
      Response response = await dio.get(
        Api.fetch_attendance,
        queryParameters: queryparam,
        options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization':res}
        ),
      );
      return response;

    } on DioError catch (e) {
      if (e.response.statusCode == 500 || e.response.statusCode == 403) {
        //var res=await refreshTokenApi();
        fetchAttendanceApi(user_id,date,true);
      } else {
        //var user = e.response.data;
        // printError(info: user.toString());
        //showAlertMsg(title: user['status'].toString(), msg: user['message']);
        return null;
      }
    }
  }



  markAttendanceApi(checkdate,checkIntime,note,office_id,punch_type,user_id,forced) async {
    try {
      var res=await refreshTokenApi(forced);
      if(res!=null)
      {
        //Map<String,dynamic> token=jsonDecode(res);
        //dio.options.headers['Authorization']=res;
        print("Token Fetch ==> $res");
      }
      Map<String , String> queryparam= Map();
      queryparam['checkIntime']=checkIntime;
      queryparam['checkdate']=checkdate;
      queryparam['note']=note;
      queryparam['officeId']=office_id;
      queryparam['user_Id']=user_id.toString();
      queryparam['punch_type']=punch_type;
      print(queryparam);
      Response response = await dio.post(
        Api.mark_attendance,
        queryParameters: queryparam,
        options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization':res}
        ),
      );
      return response;

    } on DioError catch (e) {
      if (e.response.statusCode == 500 || e.response.statusCode == 403) {
        //var res=await refreshTokenApi();
        markAttendanceApi(checkdate,checkIntime,note,office_id,punch_type,user_id,true);
      } else {
        //var user = e.response.data;
        // printError(info: user.toString());
        //showAlertMsg(title: user['status'].toString(), msg: user['message']);
        return null;
      }
    }
  }

  fetchIdCardApi(user_id,forced) async {
    try {
      var res=await refreshTokenApi(forced);
      if(res!=null)
      {
        //Map<String,dynamic> token=jsonDecode(res);
        //dio.options.headers['Authorization']=res;
        print("Token Fetch ==> $res");
      }
      Map<String , String> queryparam= Map();
      queryparam['email']=user_id.toString();
      Response response = await dio.post(
        Api.fetch_idcard,
        queryParameters: queryparam,
        options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization':res}
        ),
      );
      return response;

    } on DioError catch (e) {
      if (e.response.statusCode == 500 || e.response.statusCode == 403) {
        //var res=await refreshTokenApi();
        fetchIdCardApi(user_id,true);
      } else {
        //var user = e.response.data;
        // printError(info: user.toString());
        //showAlertMsg(title: user['status'].toString(), msg: user['message']);
        return null;
      }
    }
  }

  fetchIdCardDetailsApi(user_id,forced) async {
    try {
      DateTime dateTime=DateTime.now();
      var res=await refreshTokenApi(forced);
      if(res!=null)
      {
        //Map<String,dynamic> token=jsonDecode(res);
        //dio.options.headers['Authorization']=res;
        print("Token Fetch ==> $res");
      }
      Map<String , String> queryparam= Map();
      //queryparam['cms_users_id']=user_id.toString();
      queryparam['user_id']=user_id.toString();
      Response response = await dio.post(
        Api.fetch_idcarddetails,
        queryParameters: queryparam,
        options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization':res}
        ),
      );
      return response;

    } on DioError catch (e) {
      if (e.response.statusCode == 500 || e.response.statusCode == 403) {
        //var res=await refreshTokenApi();
        fetchIdCardDetailsApi(user_id,true);
      } else {
        //var user = e.response.data;
        // printError(info: user.toString());
        //showAlertMsg(title: user['status'].toString(), msg: user['message']);
        return null;
      }
    }
  }

  fetchUserProfileApi(user_id,forced) async {
    try {
      var res=await refreshTokenApi(forced);
      if(res!=null)
      {
        //Map<String,dynamic> token=jsonDecode(res);
        //dio.options.headers['Authorization']=res;
        //dio.options.headers['']=res;
        print("Token Fetch ==> $res");
      }
      Map<String , String> queryparam= Map();
      queryparam['id']=user_id.toString();
      Response response = await dio.get(
        Api.fetch_user_profile,
        queryParameters: queryparam,
        options: Options(
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {'Authorization':res}
        ),
      );
      return response;

    } on DioError catch (e) {
      if (e.response.statusCode == 500 || e.response.statusCode == 403) {
        //var res=await refreshTokenApi();
        fetchUserProfileApi(user_id,true);
      } else {
        //var user = e.response.data;
        // printError(info: user.toString());
        //showAlertMsg(title: user['status'].toString(), msg: user['message']);
        return null;
      }
    }
  }

  dynamicUserFormUpload(FormData formData,forced) async {
    try {
      var res=await refreshTokenApi(forced);
      if(res!=null)
      {
        //Map<String,dynamic> token=jsonDecode(res);
        //dio.options.headers['Authorization']=res;
        //dio.options.headers["Content-Type"] = "multipart/form-data";
        print("Token Fetch ==> $res");
      }
      /*Map<String , String> queryparam= Map();
      queryparam['inst_id']=inst_id;
      queryparam['user_id']=user_id;*/
      Response response = await dio.post(
        Api.upload_user_dynamic_form,
        data: formData,
        options: Options(
            responseType: ResponseType.json,
            headers: {'Authorization':res,'Content-Type':'multipart/form-data'},
        ),
      );
      return response;

    } on DioError catch (e) {
      if (e.response.statusCode == 500 || e.response.statusCode == 403) {
        //var res=await refreshTokenApi();
        dynamicUserFormUpload(formData,true);
      } else {
        //var user = e.response.data;
        // printError(info: user.toString());
        //showAlertMsg(title: user['status'].toString(), msg: user['message']);
        return null;
      }
    }
  }

  profilePicUpdate(FormData formData,forced) async {
    try {
      var res=await refreshTokenApi(forced);
      if(res!=null)
      {
        //Map<String,dynamic> token=jsonDecode(res);
        //dio.options.headers['Authorization']=res;
        //dio.options.headers["Content-Type"] = "multipart/form-data";

        print("Token Fetch ==> $res");
      }
      /*Map<String , String> queryparam= Map();
      queryparam['inst_id']=inst_id;
      queryparam['user_id']=user_id;*/
      Response response = await dio.post(
        Api.edit_profile,
        data: formData,
        options: Options(
          responseType: ResponseType.json,
          headers: {'Authorization':res,'Content-Type':'multipart/form-data'},
        ),
      );
      return response;

    } on DioError catch (e) {
      if (e.response.statusCode == 500 || e.response.statusCode == 403) {
        //var res=await refreshTokenApi();
        dynamicUserFormUpload(formData,true);
      } else {
        //var user = e.response.data;
        // printError(info: user.toString());
        //showAlertMsg(title: user['status'].toString(), msg: user['message']);
        return null;
      }
    }
  }

  dynamicEditCardInfoUpload(FormData formData,forced) async {
    try {
      var res=await refreshTokenApi(forced);
      if(res!=null)
      {
        //Map<String,dynamic> token=jsonDecode(res);
        //dio.options.headers['Authorization']=res;
        //dio.options.headers["Content-Type"] = "multipart/form-data";

        print("Token Fetch ==> $res");
      }
      /*Map<String , String> queryparam= Map();
      queryparam['inst_id']=inst_id;
      queryparam['user_id']=user_id;*/
      Response response = await dio.post(
        Api.edit_card,
        data: formData,
        options: Options(
          responseType: ResponseType.json,
          headers: {'Authorization':res,'Content-Type':'multipart/form-data'},
        ),
      );
      return response;

    } on DioError catch (e) {
      if (e.response.statusCode == 500 || e.response.statusCode == 403) {
        //var res=await refreshTokenApi();
        dynamicEditCardInfoUpload(formData,true);
      } else {
        //var user = e.response.data;
        // printError(info: user.toString());
        //showAlertMsg(title: user['status'].toString(), msg: user['message']);
        return null;
      }
    }
  }

  dynamicCardFormUpload(FormData formData,forced) async {
    try {
      var res=await refreshTokenApi(forced);
      if(res!=null)
      {
        //Map<String,dynamic> token=jsonDecode(res);
        //dio.options.headers['Authorization']=res;
       // dio.options.headers["Content-Type"] = "multipart/form-data";

        print("Token Fetch ==> $res");
      }
      /*Map<String , String> queryparam= Map();
      queryparam['inst_id']=inst_id;
      queryparam['user_id']=user_id;*/
      Response response = await dio.post(
        Api.add_card,
        data: formData,
        options: Options(
          responseType: ResponseType.json,
          headers: {'Authorization':res,'Content-Type':'multipart/form-data'},
        ),
      );
      return response;

    } on DioError catch (e) {
      if (e.response.statusCode == 500 || e.response.statusCode == 403) {
        //var res=await refreshTokenApi();
        dynamicCardFormUpload(formData,true);
      } else {
        //var user = e.response.data;
        // printError(info: user.toString());
        //showAlertMsg(title: user['status'].toString(), msg: user['message']);
        return null;
      }
    }
  }

  addInstiApi(instname,email,country,city,website,role,fullname,noofcard,token,forced) async {
    print("country-> $country");
    print("city-> $city");
    try {
      var res=await refreshTokenApi(forced);
      if(res!=null)
      {
        //Map<String,dynamic> token=jsonDecode(res);
        //dio.options.headers['Authorization']=res;
        print("Token Fetch ==> $res");
      }
      Map<String , String> queryparam= Map();
      queryparam['company_name']=instname;
      queryparam['full_name']=fullname;
      queryparam['country']=country;
      queryparam['city']=city;
      queryparam['website']=website;
      queryparam['designation']=role;
      queryparam['no_id_cards']=noofcard.toString();
      queryparam['email']=email;
      queryparam['token']=token;
      Response response = await dio.post(
        Api.add_insti,
        queryParameters: queryparam,
        options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization':res}
        ),
      );
      return response;

    } on DioError catch (e) {
      if (e.response.statusCode == 500 || e.response.statusCode == 403) {
        //var res=await refreshTokenApi();
        addInstiApi(instname,email,country,city,website,role,fullname,noofcard,token,true);
      } else {
        //var user = e.response.data;
        // printError(info: user.toString());
        //showAlertMsg(title: user['status'].toString(), msg: user['message']);
        return null;
      }
    }
  }

  Future<String> check_token() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //bool should_fetch_token=true;
    String last_token_expiry_time=prefs.getString(AppConstants.TOKEN_EXPIRY);
    String last_token=prefs.getString(AppConstants.TOKEN_API);
    if(last_token!=null && !last_token.isEmpty && last_token_expiry_time!=null && !last_token_expiry_time.isEmpty)
      {
        int currentepoch=DateTime.now().millisecondsSinceEpoch;
        int previousepoch=int.parse(last_token_expiry_time);
        if(currentepoch-previousepoch<3480000)
          {
            return last_token;
          }
        else{
          return '';
        }
      }
    else
      {
        return '';
      }
  }

  refreshTokenApi(bool forced) async {
    String result=await check_token();
    if(result.isEmpty || forced)
      {
        Map<String, String> params = Map();
        params["secret"]="2d7b4ff84a009886f7e64f7bcd241b59";
        //print("Hello ${DateTime.now().millisecondsSinceEpoch}");
        var newToken;
        try {
          Response response = await dio.post(
            Api.get_token,
            queryParameters: params,
            options: Options(
                contentType: Headers.jsonContentType,
                responseType: ResponseType.json,
            ),
          );
          //response.data
          if(response.data['api_status']==1)
          {
            newToken=response.data['data']['access_token'];
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString(AppConstants.TOKEN_EXPIRY,DateTime.now().millisecondsSinceEpoch.toString());
            prefs.setString(AppConstants.TOKEN_API,newToken);
          }
          //storageManager.saveToken(token: newToken["token"]);
        } on DioError catch (e) {
          //dismissLoader();
          if (e.response.statusCode == 500 || e.response.statusCode == 403) {
            // await refreshTokenApi();
          } else {
            //var user = e.response.data;
            // printError(info: user.toString());
            //showAlertMsg(title: user['status'].toString(), msg: user['message']);
            return;
          }
          //var user = e.response.data;
          //print("user");
          //print(user);
          //print(user['success']);
          //showAlertMsg(title: user['success'], msg: user['message']);
        }
        return newToken;
      }
    else{
      return result;
    }
  }

  resendOtpApi(id,forced) async {
    try {
      var res=await refreshTokenApi(forced);
      if(res!=null)
      {
        //Map<String,dynamic> token=jsonDecode(res);
        //dio.options.headers['Authorization']=res;
        print("Token Fetch ==> $res");
      }
      Map<String , String> queryparam= Map();
      queryparam['id']=id;
      Response response = await dio.get(
          Api.resend_otp,
          queryParameters: queryparam,
        options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization':res}
        ),
      );

      return response;
    } on DioError catch (e) {
      //dismissLoader();

      if (e.response.statusCode == 500 || e.response.statusCode == 403) {
        resendOtpApi(id,true);
      } else {
        //var user = e.response.data;
        // printError(info: user.toString());
        //showAlertMsg(title: user['status'].toString(), msg: user['message']);
        return;
      }
    }
  }

  fetchNotificationsApi(id,forced) async {
    try {
      var res=await refreshTokenApi(forced);
      if(res!=null)
      {
        //Map<String,dynamic> token=jsonDecode(res);
        //dio.options.headers['Authorization']=res;
        print("Token Fetch ==> $res");
      }
      Map<String , String> queryparam= Map();
      queryparam['id']=id.toString();
      Response response = await dio.get(
          Api.fetch_notifications,
          queryParameters: queryparam,
        options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization':res}
        ),
      );

      return response;
    } on DioError catch (e) {
      //dismissLoader();

      if (e.response.statusCode == 500 || e.response.statusCode == 403) {
        fetchNotificationsApi(id,true);
      } else {
        //var user = e.response.data;
        // printError(info: user.toString());
        //showAlertMsg(title: user['status'].toString(), msg: user['message']);
        return;
      }
    }
  }
}
