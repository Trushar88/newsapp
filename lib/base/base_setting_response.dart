class BaseSettingResponse {
  String? statusCode;
  String? message;
  int? count;

  BaseSettingResponse({this.statusCode, this.message, this.count});

  BaseSettingResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status'];
    message = json['message'];
    count = json["totalResults"];
  }
}
