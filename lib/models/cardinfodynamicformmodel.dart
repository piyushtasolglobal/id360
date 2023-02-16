class CardInfoDynamicFormModel {
  int apiStatus=0;
  String apiMessage='';
  List<Data> data=[];

  CardInfoDynamicFormModel(this.apiStatus, this.apiMessage, this.data);

  CardInfoDynamicFormModel.fromJson(Map<String, dynamic> json) {
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
  String label='';
  String name='';
  String type='';
  String validation='';
  String value='';
  String entered_value='';
  Data(this.label, this.name, this.type, this.validation, this.value, this.entered_value);

  Data.fromJson(Map<String, dynamic> json) {
    label = json['label']??'';
    name = json['name']??'';
    type = json['type']??'';
    validation = json['validation']??'';
    value = json['value']??'';
    entered_value = json['entered_value']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['name'] = this.name;
    data['type'] = this.type;
    data['validation'] = this.validation;
    data['value'] = this.value;
    data['entered_value'] = this.entered_value;
    return data;
  }
}