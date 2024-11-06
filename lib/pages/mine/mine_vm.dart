import 'package:flutter/material.dart';
import 'package:flutter_starfish/api/models/app_info_data.dart';

import '../../api/api_mine.dart';

class MineViewModel with ChangeNotifier {

  AppInfoData? infoData;

  // 获取当前用户相关的app信息

  Future getAppInfo() async {
    try {
      infoData = await ApiMine.api.getAppInfo();
      notifyListeners();
    } catch(e) {
      print("MineViewModel getAppInfo $e 当前未登录");
    }

    // 是否开启消息
    Future setOpenMsg(bool openFlag) async {
      infoData?.openMsg = openFlag;
      // 调用接口修改状态
      ApiMine.api.setOpenMsg(openFlag);
      notifyListeners();
    }
  }
}