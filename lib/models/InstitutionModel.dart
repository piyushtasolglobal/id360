
class InstitutionModel {
  int apiStatus=0;
  String apiMessage='';
  List<Data> data=[];

  InstitutionModel(this.apiStatus, this.apiMessage, this.data);

  InstitutionModel.fromJson(Map<String, dynamic> json) {
    apiStatus = json['api_status'];
    apiMessage = json['api_message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_status'] = this.apiStatus;
    data['api_message'] = this.apiMessage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String company_name='';
  String full_name='';
  String company_title='';
  String company_description='';
  String status='';
  String send_notification='';
  int cms_users_id;
  String country='';
  String website='';
  String role='';
  int no_id_cards;
  String email='';

  Data(
      this.id,
        this.company_name,
        this.full_name,
        this.company_title,
        this.company_description,
        this.status,
        this.send_notification,
        this.cms_users_id,
        this.country,
        this.website,
        this.role,
        this.no_id_cards,
        this.email);


  Data.fromJson(Map<String, dynamic> json) {
    id = json['id']??'';
    company_name = json['company_name']??'';
    full_name = json['full_name']??'';
    company_title = json['company_title']??'';
    company_description = json['company_description']??'';
    status = json['status']??'';
    send_notification = json['send_notification']??'';
    cms_users_id = json['cms_users_id']??'';
    country = json['country']??'';
    website = json['website']??'';
    role = json['role']??'';
    no_id_cards = json['no_id_cards']??'';
    email = json['email']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_name'] = this.company_name;
    data['full_name'] = this.full_name;
    data['company_title'] = this.company_title;
    data['company_description'] = this.company_description;
    data['status'] = this.status;
    data['send_notification'] = this.send_notification;
    data['cms_users_id'] = this.cms_users_id;
    data['country'] = this.country;
    data['website'] = this.website;
    data['role'] = this.role;
    data['no_id_cards'] = this.no_id_cards;
    data['email'] = this.email;
    return data;
  }
}