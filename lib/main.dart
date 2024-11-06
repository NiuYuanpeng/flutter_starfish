import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app.dart';
import 'http/dio_instance.dart';

void main() async {
  DioInstance.instance().initDio(baseUrl: "http://172.20.8.45:9900/");
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}
