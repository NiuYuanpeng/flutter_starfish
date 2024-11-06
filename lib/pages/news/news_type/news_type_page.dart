
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_starfish/common_ui/app_bar/app_title_bar.dart';
import 'package:flutter_starfish/common_ui/styles/app_colors.dart';
import 'package:flutter_starfish/pages/news/news_list_vm.dart';
import 'package:flutter_starfish/pages/news/news_type/news_type_vm.dart';
import 'package:provider/provider.dart';

import '../../../api/models/app_news_data.dart';
import '../../../common_ui/title/app_text.dart';
import '../../../utils/string_utils.dart';

class NewsTypePage extends StatefulWidget {
  const NewsTypePage({super.key});

  @override
  State<NewsTypePage> createState() => _NewsTypePageState();
}

class _NewsTypePageState extends State<NewsTypePage> with SingleTickerProviderStateMixin {
  final _vm = NewsTypeViewModel();
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    _vm.getNewsTypeList();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (ctx) {
      return _vm;
    }, child: Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Column(
        children: [
          // 标题
          AppTitleBar('资讯', onRightTap: () {},),
          // tab
          SizedBox(
            width: double.infinity,
            child: TabBar(tabs: [
              Tab(text: '雷区',),
              Tab(text: "行情"),
              Tab(text: "科普"),
            ],
              controller: tabController,
              isScrollable: true,
              labelColor: AppColors.textColor20,
              indicator:  BoxDecoration(),
              indicatorColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: TextStyle(
                fontSize: 24.sp,
                color: AppColors.textColor20,
                fontWeight: FontWeight.w600
              ),
              unselectedLabelStyle: TextStyle(fontSize: 17.sp, color: AppColors.textColor8B),
            ),
          ),
          Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 17.w, right: 14.w),
                child: TabBarView(children: [
                  _tabPageView(0),
                  _tabPageView(1),
                  _tabPageView(2),
                ],
                controller: tabController,),
              ))
        ],
        ),),
    )
    );
  }
  Widget _tabPageView(int tabIndex) {
    return Consumer<NewsTypeViewModel>(
      builder: (context, vm, child) {
        if (tabIndex == 0) {
          return _typeListView(tabIndex, listData: vm.mineFieldList);
        } else if (tabIndex == 1) {
          return _typeListView(tabIndex, listData: vm.marketList);
        } else {
          return _typeListView(tabIndex, listData: vm.scienceList);
        }
      },
    );
  }

  Widget _typeListView(
      int tabIndex, {
        List<AppNewsItemData>? listData,
      }) {
    return ListView.builder(
        itemBuilder: (context, index) {
          var item = listData?[index];
          return newsItemView(
              item: item,
              onCollectTap: () {
                _vm.setCollect(
                    tabIndex: tabIndex,
                    index: index,
                    collected: item?.collected ?? false,
                    newsId: item?.id,
                    name: item?.title);
              });
        },
        itemCount: listData?.length ?? 0);
  }
}

Widget newsItemView({AppNewsItemData? item, GestureTapCallback? onCollectTap}) {
  return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.lineColorFA, width: 1.r))),
      padding: EdgeInsets.only(top: 15.h, bottom: 14.h),
      child: Row(children: [
        Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              AppText(
                  text: item?.title ?? "",
                  fontSize: 20.sp,
                  textColor: AppColors.textColor20,
                  maxLines: 2),
              //三张图
              if (item?.imageList?.length == 3)
                Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 20.h),
                    height: 90.h,
                    child: Row(children: [
                      Expanded(
                          flex: 1,
                          child: Image.network(StringUtils.takeStrForList(item?.imageList),
                              fit: BoxFit.fill)),
                      7.horizontalSpace,
                      Expanded(
                          flex: 1,
                          child: Image.network(StringUtils.takeStrForList(item?.imageList, index: 1),
                              fit: BoxFit.fill)),
                      7.horizontalSpace,
                      Expanded(
                          flex: 1,
                          child: Image.network(StringUtils.takeStrForList(item?.imageList, index: 2),
                              fit: BoxFit.fill)),
                    ])),
              20.verticalSpace,
              Row(children: [
                AppText(text: "大谈房屋知识 2019.08.08", fontSize: 12.sp, textColor: AppColors.textColorB7),
                const Expanded(child: SizedBox()),
                Image.asset("assets/images/icon_news_type_zhuanfa.png", width: 13.r, height: 13.r),
                13.horizontalSpace,
                Image.asset("assets/images/icon_news_type_dianzan.png", width: 13.r, height: 13.r),
                13.horizontalSpace,
                GestureDetector(
                    onTap: onCollectTap,
                    child: Image.asset(
                      "assets/images/icon_news_type_collect.png",
                      width: 13.r,
                      height: 13.r,
                      color: item?.collected == true ? AppColors.collectColor : null,
                    ))
              ])
            ])),
        //单张图
        if (item?.imageList?.length == 1)
          Container(
              padding: EdgeInsets.only(left: 14.w, right: 3.w),
              child: Image.network(StringUtils.takeStrForList(item?.imageList),
                  width: 110.w, height: 86.h, fit: BoxFit.fill))
      ]));
}
