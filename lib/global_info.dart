
import 'package:flutter_starfish/utils/string_utils.dart';

import 'api/models/user_info.dart';

class GlobalInfo {
  GlobalInfo._();

  static GlobalInfo info = GlobalInfo._();

  UserInfo? _userInfo;

  UserInfo? getUserInfo() {
    return _userInfo;
  }

  void setUser(UserInfo? userInfo) {
    _userInfo = userInfo;
  }

  ///检查当前是否已登录
  bool checkLogin() {
    return _userInfo == null || StringUtils.isEmpty(_userInfo?.name);
  }

}
