class Api {
  static var baseUrl = "https://tasolglobal.com/dev/ID360/public/api/";
  static var instidreg=baseUrl + "institutionregistration";
  static var selfidreg=baseUrl + "self_user_register";
  static var fetch_insti=baseUrl + "listcompany";
  static var user_login=baseUrl + "user_login";
  static var add_insti=baseUrl + "add_institution";
  static var get_token=baseUrl + "get-token";
  static var get_institution=baseUrl + "get_institute";
  static var search_institute=baseUrl + "search_institute";
  static var fetch_attendance=baseUrl + "check_user_attendance";//user_Id,date
  static var mark_attendance=baseUrl + "add_user_attendance";//checkdate,checkIntime,note
  static var upload_user_dynamic_form=baseUrl + "adddynamicformsubmission";
  static var get_dynamicformbyinstitute=baseUrl + "dynamicformbyinstitute";
  static var fetch_idcard=baseUrl + "get_user_icard";//user_Id
  static var fetch_idcarddetails=baseUrl + "get_user_icard_mapping_details";
  static var fetch_user_profile=baseUrl + "user_profile";
  static var resend_otp=baseUrl + "resend_otp";
  static var fetch_notifications=baseUrl + "notification_list";
  static var fetch_form_by_institute=baseUrl + "dynamicformbyinstitute";//institution_id
  static var add_card=baseUrl + "add_user_cards"; //form response
  static var edit_card=baseUrl + "edit_user_icards_request"; //form response
  static var get_card=baseUrl + "get_user_icards_info"; //id
  static var delete_card=baseUrl + "delete_user_icards_details"; //id
  static var get_cardformbyinstitute=baseUrl + "dynamic_cardsby_institute";
  static var delete_noti=baseUrl + "delete_notification";
  static var edit_profile=baseUrl + "update_user_profile";
}
