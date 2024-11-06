import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_starfish/api/models/home_banner_data.dart';
import 'package:flutter_starfish/api/models/house_res_data.dart';
import 'package:flutter_starfish/app.dart';
import 'package:flutter_starfish/common_ui/app_bar/app_search_bar.dart';
import 'package:flutter_starfish/common_ui/banner/home_banner_widget.dart';
import 'package:flutter_starfish/common_ui/filter/filter_menu_widget.dart';
import 'package:flutter_starfish/common_ui/house_list/house_res_list_item.dart';
import 'package:flutter_starfish/common_ui/sliver/sliver_header.dart';
import 'package:flutter_starfish/common_ui/title/big_title.dart';
import 'package:flutter_starfish/pages/house_res/house_resource_vm.dart';
import 'package:provider/provider.dart';

import '../../route/route_utils.dart';
import 'detail/house_res_detail.dart';

class HouseResourcePage extends StatefulWidget {
  const HouseResourcePage({super.key});

  @override
  State<HouseResourcePage> createState() => _HouseResourcePageState();
}

class _HouseResourcePageState extends State<HouseResourcePage> {

  final HouseResViewModel _houseResViewModel = HouseResViewModel();

  @override
  void initState() {
    super.initState();
    // 获取房源列表数据
    _houseResViewModel.getHouseRes();
    // 获取banner
    _houseResViewModel.getBannerList();
  }

  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Container(),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HouseResViewModel>(create: (ctx) {
      return _houseResViewModel;
    }, child: Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: CustomScrollView(

          slivers: [
            // 不需要吸顶的部分
            SliverToBoxAdapter(child: Column(
              children: [
                //顶层输入框
                _buildAppBar(),
                // banner
                _buildBanner()
              ],
            ),),
            // 吸顶的部分
            SliverHeader(children: [

              BigTitle(bigTitle: '新房源',),
              _buildFilterArea(),
            ]),

            // 列表部分 写法1
            _buildSliverListView(),
            // 列表部分 写法2
            // SliverList(delegate: SliverChildBuilderDelegate((ctx, index) {
            //   return HouseListItem(
            //     data: _houseResViewModel.houseResList?[index],
            //     onTap: () {},
            //   );
            // }, childCount: _houseResViewModel.banner?.length ?? 0))
          ],
        ),
      )),
    ),);
  }

  Widget _buildAppBar() {

    return AppSearchBar(
      searchType: SearchType.square,
      hintText: '寻找附近房源',
      margin: EdgeInsets.zero,
      // rightIconPadding: EdgeInsets.only(left: 25.w, right: .20.w),
      showLeftMenu: false,
      // 消息阿牛
      showRightIcon: true,
      onRightIconTap: () {},
    );
  }

  Widget _buildBanner() {
    return Selector<HouseResViewModel, List<HomeBannerData>?>(builder: (ctx, blist, child) {
      return BannerWidget(bannerData: _houseResViewModel.generalBannerList(blist),
        dotType: BannerDotType.square,
        height: 152.h,
        bannerClick: (index) {

        },
      );
    }, selector: (ctx, houseResVM) {
      return houseResVM.banner;
    });
  }

  Widget _buildFilterArea() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FilterMenuWidget(name: "区域", selected: true,),
        FilterMenuWidget(name: "租金"),
        FilterMenuWidget(name: "户型"),
        FilterMenuWidget(name: "筛选")
      ],
    );
  }

  Widget _buildSliverListView() {
    return Selector<HouseResViewModel, List<HouseResData>?>(builder: (ctx, hlist, child) {
      return SliverList(delegate: SliverChildBuilderDelegate((ctx, index) {
        HouseResData? item = hlist?[index];
        return HouseListItem(data: hlist?[index],
            onTap: () {
              RouteUtils.push(context, HouseResDetailPage(id: item?.id));
            },
          );
        }, childCount: hlist?.length ?? 0),
      );
    }, selector: (ctx, houseResVM) {
      return houseResVM.houseResList;
    });
  }
}
