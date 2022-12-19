import 'dart:async';

import 'package:bruno/bruno.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qq_music/const/global.dart';
import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/controller/search_controller.dart';
import 'package:qq_music/model/event/event_model.dart';
import 'package:qq_music/page/search/search_res/res_album.dart';
import 'package:qq_music/page/search/search_res/res_mv.dart';
import 'package:qq_music/page/search/search_res/res_song.dart';
import 'package:qq_music/page/search/search_res/res_song_list.dart';
import 'package:qq_music/page/search/search_res/res_song_user.dart';
import 'package:qq_music/page/search/search_res/res_user.dart';
import 'package:qq_music/utils/Global.dart';

class SearchHome extends StatefulWidget {
  final String keyword;

  const SearchHome({Key? key, required this.keyword}) : super(key: key);

  @override
  State createState() => _SearchHomeState();
}

class _SearchHomeState extends State<SearchHome> with TickerProviderStateMixin,AutomaticKeepAliveClientMixin {
  String keyword = "";
  List<BadgeTab> tabs = [
    BadgeTab(text: "歌曲"),
    BadgeTab(text: "视频"),
    BadgeTab(text: "专辑"),
    BadgeTab(text: "歌单"),
    BadgeTab(text: "歌手"),
    BadgeTab(text: "用户"),
  ];
  String text = "歌曲";


  late TabController tabController;

  PageController pageController = PageController();
  SearchController ? searchController;
  late StreamSubscription stream;
  var textSet;

  @override
  void initState() {
    super.initState();
    player.pause();

    keyword = widget.keyword;
    stream = Global.getInstance()!.on<StartSearch>().listen((event) {
      if(mounted && keyword!=event.keyword){
        textSet(() {
          keyword = event.keyword.trim();
        });
      }
    });
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    searchController = Get.put(SearchController());
    super.build(context);
    return Material(
      color: const Color.fromRGBO(30, 30, 30, 1),
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 30),
              color: const Color.fromRGBO(36, 36, 37, 1),
              height: 60,
              child: Row(
                children: [
                  const Text(
                    "搜索", style: TextStyle(color: Colors.grey, fontSize: 18),),
                  StatefulBuilder(
                    builder: (BuildContext context, void Function(void Function()) setState) {
                      textSet=setState;
                      return Text(' "$keyword" ', style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),);
                    },
                  )
                ],
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(30, 30, 31, 1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: BrnTabBar(
                      onTap: (state, index) {
                        if(index==0){
                          text ="首歌曲";
                          searchController?.total.value=CacheGlobalData.songTotal;
                        }
                        if(index==1){
                          text ="个视频";
                          searchController?.total.value=CacheGlobalData.mvTotal;
                        }
                        if(index==2){
                          text ="张专辑";
                          searchController?.total.value=CacheGlobalData.albumsTotal;
                        }
                        if(index==3){
                          text ="个歌单";
                          searchController?.total.value=CacheGlobalData.playlistCount;
                        }
                        if(index==4){
                          text ="位歌手";
                          searchController?.total.value=CacheGlobalData.artistCount;
                        }
                        if(index==5){
                          text ="位用户";
                          searchController?.total.value=CacheGlobalData.userCount;
                        }
                        pageController.jumpToPage(index);
                      },
                      backgroundcolor: Colors.transparent,
                      unselectedLabelColor: Colors.grey[100],
                      tabWidth: 80,
                      unselectedLabelStyle: const TextStyle(fontSize: 15),
                      indicatorColor: const Color.fromRGBO(30, 204, 148, 1),
                      indicatorWeight: 3,
                      controller: tabController,
                      labelColor: const Color.fromRGBO(30, 204, 148, 1),
                      labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                      tabs: tabs,
                    ),
                  ),
                  Expanded(child: Container()),
                  Obx(() {
                    return Container(
                      margin: const EdgeInsets.only(left: 30,right: 30),
                      child: Text("共找到${searchController?.total ?? 0}$text",style:const TextStyle(color: Colors.grey,fontSize: 14),),
                    );
                  })
                ],
              ),
            ),

            Expanded(child: PageView(
              controller: pageController,
              children: [
                ResSongPage(
                    keyword: keyword, searchController: searchController!),
                ResMvPage( searchController: searchController!),
                ResAlbumPage( searchController: searchController!),
                ResSongPlayPage( searchController: searchController!),
                ResSongUserPage(searchController: searchController!),
                ResUserPage( searchController: searchController!),
              ],
            ))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    stream.cancel();
  }

  @override
  bool get wantKeepAlive => true;
}
