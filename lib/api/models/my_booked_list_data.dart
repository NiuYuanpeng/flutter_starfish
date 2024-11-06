/// id : 3
/// bookedtime : 1720349604
/// houseName : "翻斗花园三期32幢三室一厅"
/// status : 1

class MyBookedListData {
  List<MyBookedData>? bookedList;

  MyBookedListData.fromJson(dynamic json) {
    bookedList = [];
    for (var child in json) {
      bookedList?.add(MyBookedData.fromJson(child));
    }
  }
}

class MyBookedData {
  MyBookedData({
      this.id, 
      this.bookedtime, 
      this.houseName, 
      this.status,});

  MyBookedData.fromJson(dynamic json) {
    id = json['id'];
    bookedtime = json['bookedtime'];
    houseName = json['houseName'];
    status = json['status'];
  }
  num? id;
  num? bookedtime;
  String? houseName;
  num? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['bookedtime'] = bookedtime;
    map['houseName'] = houseName;
    map['status'] = status;
    return map;
  }

}