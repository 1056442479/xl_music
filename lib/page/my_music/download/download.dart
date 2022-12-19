

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:qq_music/page/my_music/download/down_error_page.dart';
import 'package:qq_music/page/my_music/download/down_over_page.dart';

import 'downloading.dart';

class DownloadMusicPage extends StatefulWidget {
  const DownloadMusicPage({Key? key}) : super(key: key);

  @override
  _DownloadMusicPageState createState() => _DownloadMusicPageState();
}

class _DownloadMusicPageState extends State<DownloadMusicPage> with TickerProviderStateMixin{


  List<BadgeTab> tabs =[
    BadgeTab(text: "正在下载"),
    BadgeTab(text: "本地歌曲"),
//    BadgeTab(text: "下载视频"),
    BadgeTab(text: "下载出错"),
  ];
  late TabController tabController ;
  PageController pageController =PageController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromRGBO(30, 30, 30, 1),
      child: Container(
        margin: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration:  const BoxDecoration(
                color: Color.fromRGBO(30, 30, 31, 1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Container(
                    alignment: Alignment.center,
                    child: BrnTabBar(
                      onTap: (state,index){
                        pageController.jumpToPage(index);
                      },
                      backgroundcolor: Colors.transparent,
                      unselectedLabelColor: Colors.grey[100],
                      tabWidth:80,
                      unselectedLabelStyle: const TextStyle(fontSize: 15),
                      indicatorColor: const Color.fromRGBO(30, 204, 148, 1),
                      indicatorWeight:3,
                      controller: tabController,
                      labelColor:const Color.fromRGBO(30, 204, 148, 1),
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                      tabs: tabs,
                    ),
                  ),
                  Expanded(child: Container()),

                ],
              ),
            ),

            Expanded(child: PageView(
              controller: pageController,
              children:  const [
                DownLoadingPage(),
                DownOverPage(),
//                Container(),
                DownErrorPage(),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
