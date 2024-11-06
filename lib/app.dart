import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_starfish/route/route_path.dart';
import 'package:flutter_starfish/route/route_utils.dart';
import 'package:flutter_starfish/route/routes.dart';
import 'package:oktoast/oktoast.dart';
// import 'package:starfish_route/route/route_path.dart';
// import 'package:starfish_tenement_app/pages/debug/debug_page.dart';
// import 'package:starfish_route/route/route_utils.dart';
// import 'package:starfish_tenement_app/route/routes.dart';

/// 设计尺寸
Size get designSize {
  final firstView = WidgetsBinding.instance.platformDispatcher.views.first;
  // 逻辑短边
  final logicalShortestSide = firstView.physicalSize.shortestSide / firstView.devicePixelRatio;
  // 逻辑长边
  final logicalLongestSide = firstView.physicalSize.longestSide / firstView.devicePixelRatio;
  // 缩放比例 designSize越小，元素越大
  const scaleFactor = 1;
  // 缩放后的逻辑短边和长边
  return Size(logicalShortestSide * scaleFactor, logicalLongestSide * scaleFactor);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //toast提示必须为APP的顶层组件
    return OKToast(
      //屏幕适配父组件组件
        child: ScreenUtilInit(
          designSize: designSize,
          builder: (context, child) {
            return MaterialApp(
              theme: ThemeData(
                tabBarTheme: TabBarTheme(dividerColor: Colors.transparent),
                useMaterial3: true,
              ),
              navigatorKey: RouteUtils.navigatorKey,
              onGenerateRoute: Routes.generateRoute,
              initialRoute: RoutePath.tab,
            );
          },
        ));
  }
}

// ///调试App
// class DebugMyApp extends StatelessWidget {
//   const DebugMyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     //toast提示必须为APP的顶层组件
//     return OKToast(
//       //屏幕适配父组件组件
//         child: ScreenUtilInit(
//           designSize: designSize,
//           builder: (context, child) {
//             return MaterialApp(
//               theme: ThemeData(
//                 useMaterial3: true,
//               ),
//               navigatorKey: RouteUtils.navigatorKey,
//               onGenerateRoute: Routes.generateRoute,
//               // initialRoute: RoutePath.tab,
//               home: DebugPage(),
//             );
//           },
//         ));
//   }
// }