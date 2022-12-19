

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/page/my_music/download/download.dart';
import 'package:qq_music/page/my_music/my_love/my_love.dart';
import 'package:qq_music/page/my_music/rec_play/rec_play.dart';
import 'package:qq_music/page/my_music/try_lis/tryLis.dart';
import 'package:qq_music/page/zai_xian_music/dj/dj_main_page.dart';
import 'package:qq_music/page/zai_xian_music/music_hall/music_hall.dart';
import 'package:qq_music/page/zai_xian_music/recommend/recomed.dart';
import 'package:qq_music/page/zai_xian_music/video/video_home_page.dart';
import 'package:qq_music/utils/Global.dart';
import 'package:qq_music/utils/MyIcons.dart';
import 'package:window_manager/window_manager.dart';

class CeBian extends StatefulWidget {
  const CeBian({Key? key}) : super(key: key);

  @override
  State createState() => _CeBianState();
}

class _CeBianState extends State<CeBian> with AutomaticKeepAliveClientMixin{
  Color lableColor = Colors.transparent;
  int index = -1;
  int clickIndex =0;
  bool isExpanded = false;
  bool isCollect = false;


  @override
  Widget build(BuildContext context) {
    Global.logger.d("侧边栏构建了");
    super.build(context);

    return Container(
      width: 220,
      height: double.infinity,
      decoration:
      const BoxDecoration(color: Color.fromRGBO(23, 23, 24, 1)),
      child: Column(
        textDirection: TextDirection.ltr,
        children: [
          //logo标题
          GestureDetector(
            behavior:HitTestBehavior.opaque,
            onPanDown: (e){
              if(Get.isOverlaysOpen){
                Navigator.of(CacheGlobalData.context!).pop();
              }
              windowManager.startDragging();
            },
            child: Container(
              margin:
              const EdgeInsets.only(left: 35, right: 10, bottom: 20),
              width: double.infinity,
              height: 80,
              child: SizedBox(
                  width: 110,
                  child: Row(

                    textDirection: TextDirection.ltr,
                    children: [
//                      SizedBox(
//                        width: 50,
//                        height: 25,
//                        child: SvgPicture.asset(
//                          "images/qq_logo_svg.svg",
//                        ),
//                      ),
                      Text(
                        textDirection: TextDirection.ltr,
                        "XL音乐",
                        textScaleFactor: 1,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
            ),
          ),
//          菜单
          Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(left: 25, right: 20),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Column(
                    children: [
                      //在线音乐
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          textDirection: TextDirection.ltr,

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 10),

                              child: Text(
                                textDirection: TextDirection.ltr,
                                "在线音乐",
                                textScaleFactor: 1,
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 13),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            //推荐
                            StatefulBuilder(
                              builder: (BuildContext context, void Function(void Function()) setStates) {
                                return MouseRegion(
                                  onHover: (e) {
                                    index = 0;
                                    hover(e,setStates);
                                  },
                                  onExit: (e) {
                                    index = -1;
                                    exit(e,setStates);
                                  },
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: (){
                                        var path = Get.currentRoute;
                                        if(path!="/Recommend"){
                                          setState((){
                                            clickIndex =0;
                                          });
                                          Get.offAll(()=>const Recommend(),transition: Transition.rightToLeft);
                                        }
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.only(left: 10),
                                      margin: const EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      decoration:clickIndex==0?  const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(5)),
                                          gradient: LinearGradient(
                                              colors: [
                                                Color.fromRGBO(21, 212, 174, 1),
                                                Color.fromRGBO(31, 208, 163, 1),
                                                Color.fromRGBO(30, 205, 150, 1),
                                              ]
                                          )
                                      ):null,
                                      color: index == 0 && clickIndex!=0
                                          ? lableColor
                                          : null,
                                      height: 35,
                                      child: Row(
                                        textDirection: TextDirection.ltr,
                                        children: const [
                                          Icon(
                                            textDirection: TextDirection.ltr,
                                            Icons.stars_rounded,
                                            size: 23,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            textDirection: TextDirection.ltr,
                                            "推荐",
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 15),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
//                            //音乐馆
                            StatefulBuilder(
                              builder: (BuildContext context, void Function(void Function()) setStates) {
                                return MouseRegion(
                                  onHover: (e) {
                                    index = 1;
                                    hover(e,setStates);
                                  },
                                  onExit: (e) {
                                    index = -1;
                                    exit(e,setStates);
                                  },
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: (){
                                      setState((){
                                        clickIndex =1;
                                      });
                                        var path = Get.currentRoute;
                                        if(path!="/MusicHallPage"){
                                          Get.offAll(()=>const MusicHallPage(),transition: Transition.rightToLeft);
                                        }
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.only(left: 10),
                                      margin: const EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      decoration:clickIndex==1?  const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(5)),
                                          gradient: LinearGradient(
                                              colors: [
                                                Color.fromRGBO(21, 212, 174, 1),
                                                Color.fromRGBO(31, 208, 163, 1),
                                                Color.fromRGBO(30, 205, 150, 1),
                                              ]
                                          )
                                      ):null,

                                      color: index == 1&& clickIndex!=1
                                          ? lableColor
                                          : null,
                                      height: 35,
                                      child: Row(
                                        textDirection: TextDirection.ltr,
                                        children: const [
                                          Icon(
                                            textDirection: TextDirection.ltr,
                                            XlIcons.xl_yinle,
                                            size: 22,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            textDirection: TextDirection.ltr,
                                            "音乐馆",
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 15),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),


                            //视频
                            StatefulBuilder(
                              builder: (BuildContext context, void Function(void Function()) setStates) {
                                return MouseRegion(
                                  onHover: (e) {
                                    index = 2;
                                    hover(e,setStates);
                                  },
                                  onExit: (e) {
                                    index = -1;
                                    exit(e,setStates);
                                  },
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: (){
                                      var path = Get.currentRoute;
                                      if(path!="/VideoHomePage"){
                                        setState(() {
                                          clickIndex=2;
                                        });
                                        Get.offAll(()=>const VideoHomePage(),transition: Transition.rightToLeft);
                                      }
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      padding: const EdgeInsets.only(left: 10),
                                      decoration:
                                      clickIndex==2?
                                      const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(5)),
                                          gradient: LinearGradient(
                                              colors: [
                                                Color.fromRGBO(21, 212, 174, 1),
                                                Color.fromRGBO(31, 208, 163, 1),
                                                Color.fromRGBO(30, 205, 150, 1),
                                              ]
                                          )
                                      )
                                          :null,
                                      color: index == 2&& clickIndex!=2
                                          ? lableColor
                                          : null,
                                      height: 35,
                                      child: Row(
                                        textDirection: TextDirection.ltr,
                                        children: const [
                                          Icon(
                                            textDirection: TextDirection.ltr,
                                            XlIcons.xl_shipin,
                                            size: 23,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            textDirection: TextDirection.ltr,
                                            "视频",
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 15),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),

                            //电台
                            StatefulBuilder(
                              builder: (BuildContext context, void Function(void Function()) setStates) {
                                return MouseRegion(
                                  onHover: (e) {
                                    index = 3;
                                    hover(e,setStates);
                                  },
                                  onExit: (e) {
                                    index = -1;
                                    exit(e,setStates);
                                  },
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: (){

                                      var path = Get.currentRoute;
                                      if(path!="/DjMainPage"){
                                        setState(() {
                                          clickIndex=3;
                                        });
                                        Get.offAll(()=>const DjMainPage(),transition: Transition.rightToLeft);
                                      }
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      padding: const EdgeInsets.only(left: 10),
                                      decoration:
                                      clickIndex==3?
                                      const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(5)),
                                          gradient: LinearGradient(
                                              colors: [
                                                Color.fromRGBO(21, 212, 174, 1),
                                                Color.fromRGBO(31, 208, 163, 1),
                                                Color.fromRGBO(30, 205, 150, 1),
                                              ]
                                          )
                                      )
                                          :null,
                                      color: index == 3&& clickIndex!=3
                                          ? lableColor
                                          : null,
                                      height: 35,
                                      child: Row(
                                        textDirection: TextDirection.ltr,
                                        children: const [
                                          Icon(
                                            textDirection: TextDirection.ltr,
                                            XlIcons.xl_diantai,
                                            size: 23,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            textDirection: TextDirection.ltr,
                                            "电台",
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 15),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      //我的音乐
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 10),

                              child: Text(
                                textDirection: TextDirection.ltr,

                                "我的音乐",
                                textScaleFactor: 1,
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 13),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            //我喜欢
                            StatefulBuilder(

                              builder: (BuildContext context, void Function(void Function()) setStates) {
                                return MouseRegion(
                                  onHover: (e) {
                                    index = 4;
                                    hover(e,setStates);
                                  },
                                  onExit: (e) {
                                    index = -1;
                                    exit(e,setStates);
                                  },
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: (){
                                      setState((){
                                        clickIndex =4;
                                      });
                                      var path = Get.currentRoute;
                                      if(path!="/MyLovePage"){
                                        Get.offAll(()=>const MyLovePage(),transition: Transition.rightToLeft);
                                      }
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      padding: const EdgeInsets.only(left: 10),
                                      decoration:clickIndex==4?  const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(5)),
                                          gradient: LinearGradient(
                                              colors: [
                                                Color.fromRGBO(21, 212, 174, 1),
                                                Color.fromRGBO(31, 208, 163, 1),
                                                Color.fromRGBO(30, 205, 150, 1),
                                              ]
                                          )
                                      ):null,
                                      color: index == 4&& clickIndex!=4
                                          ? lableColor
                                          : null,
                                      height: 35,
                                      child: Row(
                                        children: const [
                                          FaIcon(
                                            textDirection: TextDirection.ltr,

                                            XlIcons.xl_aixin,
                                            color: Colors.white,
                                            size: 21,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            textDirection: TextDirection.ltr,

                                            "我喜欢",
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 15),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            //本地和下载
                            StatefulBuilder(

                              builder: (BuildContext context, void Function(void Function()) setStates) {
                                return  MouseRegion(
                                  onHover: (e) {
                                    index = 5;
                                    hover(e,setStates);
                                  },
                                  onExit: (e) {
                                    index = -1;
                                    exit(e,setStates);
                                  },
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: (){
                                      var path = Get.currentRoute;
                                      if(path!="/DownloadMusicPage"){
                                        setState((){
                                          clickIndex =5;
                                        });
                                        Get.offAll(()=>const DownloadMusicPage(),transition: Transition.rightToLeft);
                                      }

                                    },
                                    child: Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      padding: const EdgeInsets.only(left: 10),
                                      decoration:clickIndex==5?  const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(5)),
                                          gradient: LinearGradient(
                                              colors: [
                                                Color.fromRGBO(21, 212, 174, 1),
                                                Color.fromRGBO(31, 208, 163, 1),
                                                Color.fromRGBO(30, 205, 150, 1),
                                              ]
                                          )
                                      ):null,
                                      color: index == 5&& clickIndex!=5
                                          ? lableColor
                                          : null,
                                      height: 35,
                                      child: Row(
                                        textDirection: TextDirection.ltr,

                                        children: const [
                                          Icon(
                                            textDirection: TextDirection.ltr,

                                            Icons.desktop_windows,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            textDirection: TextDirection.ltr,

                                            "本地和下载",
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 15),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            //最近播放
                            StatefulBuilder(

                              builder: (BuildContext context, void Function(void Function()) setStates) {
                                return MouseRegion(
                                  onHover: (e) {
                                    index = 6;
                                    hover(e,setStates);
                                  },
                                  onExit: (e) {
                                    index = -1;
                                    exit(e,setStates);
                                  },
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: (){
                                      setState((){
                                        clickIndex =6;
                                      });
                                      var path = Get.currentRoute;
                                      if(path!="/RecPlayPage"){
                                        Get.offAll(()=>const RecPlayPage(),transition: Transition.rightToLeft);
                                      }
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      padding: const EdgeInsets.only(left: 10),
                                      decoration:clickIndex==6?  const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(5)),
                                          gradient: LinearGradient(
                                              colors: [
                                                Color.fromRGBO(21, 212, 174, 1),
                                                Color.fromRGBO(31, 208, 163, 1),
                                                Color.fromRGBO(30, 205, 150, 1),
                                              ]
                                          )
                                      ):null,
                                      color: index == 6&& clickIndex!=6
                                          ? lableColor
                                          : null,
                                      height: 35,
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.history_rounded,
                                            size: 23,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "最近播放",
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 15),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            //试听列表
                            StatefulBuilder(

                              builder: (BuildContext context, void Function(void Function()) setStates) {
                                return MouseRegion(
                                  onHover: (e) {
                                    index = 7;
                                    hover(e,setStates);
                                  },
                                  onExit: (e) {
                                    index = -1;
                                    exit(e,setStates);
                                  },
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: (){
                                      setState((){
                                        clickIndex =7;
                                      });
                                      var path = Get.currentRoute;
                                      if(path!="/TryLisPage"){
                                        Get.offAll(()=>const TryLisPage(),transition: Transition.rightToLeft);
                                      }
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      padding: const EdgeInsets.only(left: 10),
                                      decoration:clickIndex==7?  const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(5)),
                                          gradient: LinearGradient(
                                              colors: [
                                                Color.fromRGBO(21, 212, 174, 1),
                                                Color.fromRGBO(31, 208, 163, 1),
                                                Color.fromRGBO(30, 205, 150, 1),
                                              ]
                                          )
                                      ):null,
                                      color: index == 7&& clickIndex!=7
                                          ? lableColor
                                          : null,
                                      height: 35,
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.queue_music_rounded,
                                            size: 23,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "试听列表",
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 15),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      // 创建歌单
                      Container(
                        padding: const EdgeInsets.only(left: 10),

                        margin: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "创建的歌单",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      color: Colors.grey[400], fontSize: 13),
                                ),
                                Expanded(child: Container()),
//                                IconButton(
//                                  textDirection: TextDirection.ltr,
//                                  icon: const Icon(
//                                    Icons.add,
//                                    color: Colors.white,
//                                    size: 20,
//                                  ),
//                                  onPressed: () {},
//                                ),
//                                ExpandIcon(
//                                  isExpanded: isExpanded,
//                                  size: 20,
//                                  color: Colors.white,
//                                  expandedColor: Colors.white,
//                                  onPressed: (value) => setState(
//                                          () => isExpanded = !isExpanded),
//                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),

                      //收藏的歌单
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          textDirection: TextDirection.ltr,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              textDirection: TextDirection.ltr,
                              children: [
                                Text(
                                  textDirection: TextDirection.ltr,
                                  "收藏的歌单",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      color: Colors.grey[400], fontSize: 13),
                                ),
                                Expanded(child: Container()),
//                                ExpandIcon(
//
//                                  isExpanded: isCollect,
//                                  size: 20,
//                                  color: Colors.white,
//                                  expandedColor: Colors.white,
//                                  onPressed: (value) =>
//                                      setState(() => isCollect = !isCollect),
//                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
          )
        ],
      ),
    );
  }

  void exit(PointerExitEvent details,setState) {
    setState(() {
      lableColor = Colors.transparent;
    });
  }

  void hover(PointerHoverEvent details,setState) {
    setState(() {
      lableColor = const Color.fromRGBO(255, 255, 255, 0.1);
    });
  }

  @override
  bool get wantKeepAlive => true;

}
