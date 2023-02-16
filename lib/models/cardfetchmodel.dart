class CardFetchModel {
  int apiStatus;
  String apiMessage;
  List<Data> data;

  CardFetchModel({this.apiStatus, this.apiMessage, this.data});

  CardFetchModel.fromJson(Map<String, dynamic> json) {
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
  String path;
  String icardId;
  int office_id;
  int user_id;

  Data({this.id, this.path, this.icardId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id']??'';
    path = json['path']??'';
    user_id = (json['user_id']!=null && !json['user_id'].toString().isEmpty)?int.parse(json['user_id'].toString()):-1;
    icardId = json['icard_id']??'';
    office_id = (json['office_id']!=null && !json['office_id'].toString().isEmpty)?int.parse(json['office_id'].toString()):-1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['path'] = this.path;
    data['icard_id'] = this.icardId;
    data['office_id'] = this.office_id;
    data['user_id'] = this.user_id;
    return data;
  }
}