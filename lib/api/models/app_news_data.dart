/// id : 8
/// title : "北京市场行情1"
/// subtitle : "副标题：北京市场行情1北京市场行情1北京市场行情1北京市场行情1"
/// type : 3
/// tag : "房产新闻"
/// dianzan : 100
/// pinglun : 22
/// contenturl : "https://juejin.cn/post/7107608301017251876"
/// createtime : 1720349602
/// operationtime : 1720349602
/// createby : 1
/// editby : 1
/// status : 1
/// imageList : ["https://q7.itc.cn/images01/20240312/ae5f3266aeb6408db22ad354f1168883.jpeg","https://q7.itc.cn/images01/20240312/ae5f3266aeb6408db22ad354f1168883.jpeg","https://q7.itc.cn/images01/20240312/ae5f3266aeb6408db22ad354f1168883.jpeg"]
/// collected : false



// To parse this JSON data, do
//
//     final appNewsItemData = appNewsItemDataFromJson(jsonString);

import 'dart:convert';

List<AppNewsItemData> appNewsItemDataFromJson(String str) => List<AppNewsItemData>.from(json.decode(str).map((x) => AppNewsItemData.fromJson(x)));

String appNewsItemDataToJson(List<AppNewsItemData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AppNewsData {
  List<AppNewsItemData>? newList;

  AppNewsData.fromJson(dynamic json) {
    if (json != null && json is List) {
      newList = [];
      for (var item in json) {
        newList?.add(AppNewsItemData.fromJson(item));
      }
    }
  }
}

class AppNewsItemData {
  int? id;
  String? title;
  String? subtitle;
  int? type;
  String? tag;
  int? dianzan;
  int? pinglun;
  String? contenturl;
  int? createtime;
  int? operationtime;
  int? createby;
  int? editby;
  int? status;
  List<String>? imageList;
  bool? collected;

  AppNewsItemData({
    this.id,
    this.title,
    this.subtitle,
    this.type,
    this.tag,
    this.dianzan,
    this.pinglun,
    this.contenturl,
    this.createtime,
    this.operationtime,
    this.createby,
    this.editby,
    this.status,
    this.imageList,
    this.collected,
  });

  factory AppNewsItemData.fromJson(Map<String, dynamic> json) => AppNewsItemData(
    id: json["id"],
    title: json["title"],
    subtitle: json["subtitle"],
    type: json["type"],
    tag: json["tag"],
    dianzan: json["dianzan"],
    pinglun: json["pinglun"],
    contenturl: json["contenturl"],
    createtime: json["createtime"],
    operationtime: json["operationtime"],
    createby: json["createby"],
    editby: json["editby"],
    status: json["status"],
    imageList: List<String>.from(json["imageList"].map((x) => x)),
    collected: json["collected"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "subtitle": subtitle,
    "type": type,
    "tag": tag,
    "dianzan": dianzan,
    "pinglun": pinglun,
    "contenturl": contenturl,
    "createtime": createtime,
    "operationtime": operationtime,
    "createby": createby,
    "editby": editby,
    "status": status,
    "imageList": List<dynamic>.from(imageList!.map((x) => x)),
    "collected": collected,
  };
}
