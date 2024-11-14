// ignore_for_file: unnecessary_null_comparison

import 'package:newsapp/base/base_setting_response.dart';

class BaseResponse<T> {
  BaseSettingResponse? settings;
  T data;

  BaseResponse({required this.settings, required this.data});

  factory BaseResponse.fromJson(Map<String, dynamic> json, T recordList) => BaseResponse(
        settings: json != null ? BaseSettingResponse.fromJson(json) : null,
        data: recordList,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['settings'] = settings;
    data['data'] = data;
    return data;
  }
}
