
import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:qq_music/page/zai_xian_music/video/mv_details_page.dart';
import 'package:qq_music/page/zai_xian_music/video/video_recommend.dart';
import 'package:qq_music/page/zai_xian_music/video/video_sort.dart';

class VideoHomePage extends StatefulWidget {
  const VideoHomePage({Key? key}) : super(key: key);

  @override
  _VideoHomePageState createState() => _VideoHomePageState();
}

class _VideoHomePageState extends State<VideoHomePage> with TickerProviderStateMixin{

  List<BadgeTab> tabs =[
    BadgeTab(text: "推荐"),
    BadgeTab(text: "排行榜"),
    BadgeTab(text: "视频"),
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
    return   Scaffold(
      backgroundColor:  const Color.fromRGBO(30, 30, 31, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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
          Expanded(child:
          PageView(
            controller: pageController,
            onPageChanged: (index){
              setState(() {
                tabController.index=index;
              });
            },
            children: const [
              //推荐
              VideoRecommend(),
              VideoSortPage(),
              MvDetailsPage()
            ],
          ))
        ],
      ),
    );
  }
}
