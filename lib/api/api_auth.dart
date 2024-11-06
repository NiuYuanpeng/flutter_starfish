
import 'package:dio/dio.dart';
import 'package:flutter_starfish/api/models/user_info.dart';
import 'package:flutter_starfish/http/dio_instance.dart';

class ApiAuth {
  ApiAuth._();

  static ApiAuth api = ApiAuth._();

  // 登录
  Future<UserInfo?>login({required String name, required String password}) async {
    try {
      Response response = await DioInstance.instance().post(path: '/auth/user/login', data: {'name': name, 'password': password});
      return UserInfo.fromJson(response.data);
    } catch(e) {
      return null;
    }

  }
  // 注册
  Future<bool> register(
      {required String name, required String password, required String rePassword}) async {
    Response response = await DioInstance.instance().post(
        path: "auth/user/register",
        data: {"name": name, "password": password, "rePassword": rePassword});
    if (response.data is bool) {
      return response.data;
    }
    return false;
  }
  // 友盟相关
  Future bindPushToken() async {
    // PushUtils.getDeviceToken((token) {
    //   DioInstance.instance()
    //       .post(path: "auth/user/bindToken", queryParameters: {"umToken": token, "tag": ""});
    // });
  }
}