
import 'package:dio/dio.dart';
import 'package:flutter_starfish/api/models/app_news_data.dart';
import 'package:flutter_starfish/http/dio_instance.dart';

class ApiNews {
  ApiNews._();

  static ApiNews api = ApiNews._();

  /// 获取app咨询
  ///[type] 1=最新咨询、2=热门资讯、3=雷区、4=行情、5=科普
  // Future<List<AppNewsItemData>> getAppNews(int type) async {
  //   Response response = await DioInstance.instance().post(path: '/news/getNewList', queryParameters: {'type' : type});
  //   return appNewsItemDataFromJson(response.data);
  // }

  Future<AppNewsData> getAppNews(int type) async {
    Response response = await DioInstance.instance().post(path: '/news/getNewList', queryParameters: {'type' : type});
    return AppNewsData.fromJson(response.data);
  }

}