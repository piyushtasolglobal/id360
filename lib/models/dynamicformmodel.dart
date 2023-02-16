class DynamicFormModel {
  int apiStatus=0;
  String apiMessage='';
  List<Data> data=[];

  DynamicFormModel(this.apiStatus, this.apiMessage, this.data);

  DynamicFormModel.fromJson(Map<String, dynamic> json) {
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

  Data(this.label, this.name, this.type, this.validation);

  Data.fromJson(Map<String, dynamic> json) {
    label = json['label']??'';
    name = json['name']??'';
    type = json['type']??'';
    validation = json['validation']??'';
    value = json['value']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['name'] = this.name;
    data['type'] = this.type;
    data['validation'] = this.validation;
    data['value'] = this.value;
    return data;
  }
}