import 'package:flutter/cupertino.dart';

import '../../../api/api_mine.dart';
import '../../../api/models/app_news_data.dart';
import '../../../api/models/house_res_data.dart';

class MyCollectViewModel with ChangeNotifier {
  List<HouseResData>? houseResList;
  List<AppNewsItemData>? newsList;

  Future getCollectList(int type) async {
    try {
      var data = await ApiMine.api.getCollectList(type: type);
      if (type == 1) {
        houseResList = (data as HouseResListData).houseResList ?? [];
      } else if (type == 2) {
        newsList = (data as AppNewsData).newList ?? [];
      }
    } finally {
      notifyListeners();
    }
  }
}
