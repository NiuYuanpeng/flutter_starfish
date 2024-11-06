import 'package:dio/dio.dart';
import 'package:flutter_starfish/api/models/house_res_detail.dart';
import 'package:flutter_starfish/api/models/my_booked_list_data.dart';
import 'package:flutter_starfish/http/dio_instance.dart';
import 'package:flutter_starfish/utils/string_utils.dart';

import '../global_info.dart';
import 'models/house_res_data.dart';

class ApiHouse {
  ApiHouse._();

  static ApiHouse api = ApiHouse._();

  ///首页房源
  Future<HouseResListData> getHouseRes() async {
    Response resp = await DioInstance.instance()
        .post(path: "/houseResource/houseResources");
    return HouseResListData.fromJson(resp.data);
  }

  // 获取房源明细
  Future<HouseResDetail> getHouseResDetail(num? id) async {
    Response rsp = await DioInstance.instance().post(
        path: '/houseResource/houseResourceDetail',
        queryParameters: {"id": id});
    return HouseResDetail.fromJson(rsp.data);
  }

  /// 获取我的房源预约记录
  Future<MyBookedListData> bookedHouseList() async {
    Response rsp =
        await DioInstance.instance().post(path: '/bookedHouse/bookedHouseList');
    return MyBookedListData.fromJson(rsp.data);
  }

  /// 房源预约
  Future<bool> submitBookedHouse(
      {num? houseresid,
      num? bookedtime,
      num? bookeduserid,
      String? userphone,
      String? username}) async {
    Response rsp = await DioInstance.instance().post(path: '/bookedHouse/saveBookedHouse', data: {
      "houseresid": houseresid, //房源id
      "bookedtime": bookedtime, //预约时间戳
      "bookeduserid": bookeduserid, //被预约人/中介
      "userphone": userphone, //预约人电话
      "username": username //预约人姓名
    });
    
    return StringUtils.takeResp(rsp.data);
  }
}
