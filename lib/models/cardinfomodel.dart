import 'package:flutter/foundation.dart';

class CardInfoModel {
  int apiStatus;
  String apiMessage;
  Data data;

  CardInfoModel({this.apiStatus, this.apiMessage, this.data});

  CardInfoModel.fromJson(Map<String, dynamic> json) {
    apiStatus = json['api_status'];
    apiMessage = json['api_message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_status'] = this.apiStatus;
    data['api_message'] = this.apiMessage;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String name;
  String email;
  String status;
  String dob;
  String phoneNumber;
  String website;
  String country;
  String city;
  int noOfCards;
  String userAccountStatus;
  Deatils deatils;
  String imagepath;
  String role;

  Data(
      {this.id,
        this.name,
        this.email,
        this.status,
        this.dob,
        this.phoneNumber,
        this.website,
        this.country,
        this.city,
        this.noOfCards,
        this.userAccountStatus,
        this.deatils,
        this.imagepath,
        this.role});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name']??'';
    email = json['email']??'';
    status = json['status']??'';
    dob = json['dob']??'';
    phoneNumber = json['phone_number']??'';
    website = json['website']??'';
    country = json['country']??'';
    city = json['city']??'';
    noOfCards = json['no_of_cards']??0;
    userAccountStatus = json['user_account_status']??'';
    deatils = json['Deatils'] != null ? new Deatils.fromJson(json['Deatils']) : null;
    imagepath = json['imagepath']??'';
    role = json['role']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['status'] = this.status;
    data['dob'] = this.dob;
    data['phone_number'] = this.phoneNumber;
    data['website'] = this.website;
    data['country'] = this.country;
    data['city'] = this.city;
    data['no_of_cards'] = this.noOfCards;
    data['user_account_status'] = this.userAccountStatus;
    if (this.deatils != null) {
      data['Deatils'] = this.deatils.toJson();
    }
    data['imagepath'] = this.imagepath;
    data['role'] = this.role;
    return data;
  }
}

class Deatils {
  String sToken;
  String id;
  String name;
  String email;
  String mobile;
  String department;
  String gender;
  String countries;
  String states;
  String cities;
  String status;
  String reasonForRejection;

  Deatils(
      {this.sToken,
        this.id,
        this.name,
        this.email,
        this.mobile,
        this.department,
        this.gender,
        this.countries,
        this.states,
        this.cities,
        this.status,
        this.reasonForRejection});

  Deatils.fromJson(Map<String, dynamic> json) {
    sToken = json['_token']??'';
    id = json['id']??'';
    name = json['name']??'';
    email = json['email']??'';
    mobile = json['mobile']??'';
    department = json['department']??'';
    gender = json['gender']??'';
    countries = json['countries']??'';
    states = json['states']??'';
    cities = json['cities']??'';
    status = json['status']??'';
    reasonForRejection = json['reason_for_rejection']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_token'] = this.sToken;
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['department'] = this.department;
    data['gender'] = this.gender;
    data['countries'] = this.countries;
    data['states'] = this.states;
    data['cities'] = this.cities;
    data['status'] = this.status;
    data['reason_for_rejection'] = this.reasonForRejection;
    return data;
  }
}