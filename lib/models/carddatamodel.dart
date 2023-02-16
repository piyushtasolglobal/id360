class CardDataModel {
  int apiStatus;
  String apiMessage;
  Data data;

  CardDataModel({this.apiStatus, this.apiMessage, this.data});

  CardDataModel.fromJson(Map<String, dynamic> json) {
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
  IcardsDetails icardsDetails;
  UserIcardMapping userIcardMapping;
  DateTimeModel dateTime;

  Data({this.icardsDetails, this.userIcardMapping, this.dateTime});

  Data.fromJson(Map<String, dynamic> json) {
    icardsDetails = json['IcardsDetails'] != null
        ? new IcardsDetails.fromJson(json['IcardsDetails'])
        : null;
    userIcardMapping = json['UserIcardMapping'] != null
        ? new UserIcardMapping.fromJson(json['UserIcardMapping'])
        : null;
    dateTime = DateTimeModel.fromJson(json['DateTime']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.icardsDetails != null) {
      data['IcardsDetails'] = this.icardsDetails.toJson();
    }
    if (this.userIcardMapping != null) {
      data['UserIcardMapping'] = this.userIcardMapping.toJson();
    }
    if (this.dateTime != null) {
      data['DateTime'] = this.dateTime.toJson();
    }
    return data;
  }
}

class IcardsDetails {
  String icardname;
  String fontColor;
  String backgroundColor;
  String borderColor;
  String foregroundColor;
  String templateFieldMapping;
  String selectedUsers;

  IcardsDetails(
      {this.icardname,
        this.fontColor,
        this.backgroundColor,
        this.borderColor,
        this.foregroundColor,
        this.templateFieldMapping,
        this.selectedUsers});

  IcardsDetails.fromJson(Map<String, dynamic> json) {
    icardname = json['icardname'];
    fontColor = json['font_color'];
    backgroundColor = json['background_color'];
    borderColor = json['border_color'];
    foregroundColor = json['foreground_color'];
    templateFieldMapping = json['template_field_mapping'];
    selectedUsers = json['selected_users'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icardname'] = this.icardname;
    data['font_color'] = this.fontColor;
    data['background_color'] = this.backgroundColor;
    data['border_color'] = this.borderColor;
    data['foreground_color'] = this.foregroundColor;
    data['template_field_mapping'] = this.templateFieldMapping;
    data['selected_users'] = this.selectedUsers;
    return data;
  }
}

class UserIcardMapping {
  int userId;
  int cmsUsersId;
  String icardImgName;
  int icardId;
  String pagesFieldMapping;
  String templateFieldMapping;
  String createAt;
  String qrurl;

  UserIcardMapping(
      {this.userId,
        this.cmsUsersId,
        this.icardImgName,
        this.icardId,
        this.pagesFieldMapping,
        this.templateFieldMapping,
        this.createAt,
        this.qrurl});

  UserIcardMapping.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    cmsUsersId = json['cms_users_id'];
    icardImgName = json['icard_img_name'];
    icardId = json['icard_id'];
    pagesFieldMapping = json['pages_field_mapping'];
    templateFieldMapping = json['template_field_mapping'];
    createAt = json['create_at'];
    qrurl = json['Qrurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['cms_users_id'] = this.cmsUsersId;
    data['icard_img_name'] = this.icardImgName;
    data['icard_id'] = this.icardId;
    data['pages_field_mapping'] = this.pagesFieldMapping;
    data['template_field_mapping'] = this.templateFieldMapping;
    data['create_at'] = this.createAt;
    data['Qrurl'] = this.qrurl;
    return data;
  }
}

class DateTimeModel {
  String date;
  String time;

  DateTimeModel({this.date, this.time});

  DateTimeModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }
}