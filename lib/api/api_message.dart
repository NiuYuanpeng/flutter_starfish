
import 'package:dio/dio.dart';
import 'package:flutter_starfish/api/models/message_data.dart';
import 'package:flutter_starfish/http/dio_instance.dart';

import '../utils/string_utils.dart';

class ApiMessage {

  ApiMessage._();

  static ApiMessage api = ApiMessage._();

  ///获取消息列表
  Future<MessageListData> getMessages() async {
    Response response = await DioInstance.instance().post(path: "/message/getMessages");
    return MessageListData.fromJson(response.data);
  }

  ///单条消息已读
  Future<bool> setReadMessage(num? id) async {
    Response rsp = await DioInstance.instance().post(path: '/message/setAllMessageRead');
    return StringUtils.takeResp(rsp.data);
  }

  /// 全部已读
  Future<bool> setAllMessageRead() async {
    Response rsp = await DioInstance.instance().post(path: '/message/setAllMessageRead');
    return StringUtils.takeResp(rsp.data);
  }
  ///处理返回值为bool类型的数据
  // bool takeResp(dynamic data) {
  //   if (data != null && data is bool) {
  //     return data;
  //   }
  //   return false;
  // }
}