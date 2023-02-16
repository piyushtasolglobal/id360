class NotificationModel {
  String status;
  String msg;
  List<NotificationData> data;

  NotificationModel({this.status, this.msg, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <NotificationData>[];
      json['data'].forEach((v) {
        data.add(new NotificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  int userId;
  int id;
  String statusType;
  String title;
  String message;
  String createdAt;

  NotificationData(
      {this.id,this.userId, this.statusType, this.title, this.message, this.createdAt});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id']??'';
    userId = (json['user_id']!=null && !json['user_id'].toString().isEmpty)?int.parse(json['user_id'].toString()):-1;
    statusType = json['status_type']??'';
    title = json['title']??'';
    message = json['message']??'';
    createdAt = json['created_at']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['status_type'] = this.statusType;
    data['title'] = this.title;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    return data;
  }
}