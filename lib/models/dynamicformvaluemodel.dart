
class DynamicFormValueModel{
  String _value='',_label='',_type='',_id;
  bool _isVal=false;

  String get value => _value;

  set value(String value) {
    _value = value;
  }

  String get id => _id;

  set id(String id) {
    _id = id;
  }

  get label => _label;

  bool get isVal => _isVal;

  set isVal(bool value) {
    _isVal = value;
  }

  set label(value) {
    _label = value;
  }

  get type => _type;

  set type(value) {
    _type = value;
  }
}