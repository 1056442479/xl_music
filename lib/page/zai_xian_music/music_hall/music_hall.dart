
import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:qq_music/page/zai_xian_music/music_hall/dj/dj_hall.dart';
import 'package:qq_music/page/zai_xian_music/music_hall/song_play/song_play_hall.dart';
import 'package:qq_music/page/zai_xian_music/music_hall/song_user_page/song_user_hall.dart';
import 'package:qq_music/page/zai_xian_music/music_hall/top/top_sort_page.dart';
import 'jing_xuan/select_page.dart';
import 'package:qq_music/utils/Global.dart';


///音乐馆页面
class MusicHallPage extends StatefulWidget {
  const MusicHallPage({Key? key}) : super(key: key);

  @override
  _MusicHallPageState createState() => _MusicHallPageState();
}

class _MusicHallPageState extends State<MusicHallPage> with AutomaticKeepAliveClientMixin,TickerProviderStateMixin{

  List<BadgeTab> tabs =[
    BadgeTab(text: "精选"),
    BadgeTab(text: "排行"),
    BadgeTab(text: "歌手"),
    BadgeTab(text: "分类歌单"),
    BadgeTab(text: "有声电台"),
  ];
  late TabController tabController ;
  PageController pageController =PageController();
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);

    Global.logger.d("音乐馆页面构建了");
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                  margin: EdgeInsets.only(top: Global.top),
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
                //精选
              SelectPage(),
              TopSortPage(),
              SongUserHall(),
              SongPlayHall(),
              DjHall()
            ],
          ))
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
