import 'package:auto_size_text/auto_size_text.dart';
import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/const/global.dart';
import 'package:qq_music/controller/audio_list_controller.dart';
import 'package:qq_music/controller/page_controller.dart';
import 'package:qq_music/model/event/event_model.dart';
import 'package:qq_music/model/song/song_list_details.dart';
import 'package:qq_music/page/song_user/song_list.dart';
import 'package:qq_music/page/song_user/song_user.dart';
import 'package:qq_music/utils/Global.dart';
import 'package:qq_music/utils/my_widget/CusBehavior.dart';

class AlbumDetailsPage extends StatefulWidget {
  final int id; //专辑id
  final int uid; //用户id
  final String name;
  final String username;
  final String picUrl;
  final int createTime;
  final int ? type;

  const AlbumDetailsPage(
      {Key? key, required this.id, required this.username, required this.createTime,
        required this.name, required this.picUrl, required this.uid,this.type})
      : super(key: key);

  @override
  _AlbumDetailsPageState createState() => _AlbumDetailsPageState();
}

class _AlbumDetailsPageState extends State<AlbumDetailsPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  List<Song> songList = [];
  List<BadgeTab> tabs = [
    BadgeTab(text: "专辑歌曲"),
    BadgeTab(text: "专辑信息"),
  ];
  int selectIndex = 0;
  late TabController tabController;

  late PageController pageController;
  JustTheController justTheController = JustTheController();
  int colorIndex = -1;
  late StateSetter bSetter;

  String desc = "暂无介绍";

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
    pageController = PageController(initialPage: 0);


  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(30, 30, 31, 1),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ScrollConfiguration(
          behavior: CusBehavior(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      image: DecorationImage(
                        image: NetworkImage(widget.picUrl,),
                        fit: BoxFit.fill, // 完全填充
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 15),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    border: Border.all(color: Colors.grey)
                                ),
                                padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                                child: const Text("专辑",style: TextStyle(color: Colors.white,fontSize: 15),),
                              ),
                              Expanded(child:
                              AutoSizeText(widget.name,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30,overflow: TextOverflow.ellipsis)
                                ,maxLines: 1,minFontSize: 20,),
                              ),
                            ],
                          ),


                          const SizedBox(height: 10,),
                          InkWell(
                              onTap: () {
                                Get.to(SongUser(
                                    id: widget.uid, username: widget.username));
                              },
                              child: Text(
                                  widget.username,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14))),
                          const SizedBox(height: 10,),

                          Text("${DateTime.fromMillisecondsSinceEpoch(
                              int.parse(widget.createTime.toString()))
                              .toString()
                              .split(" ")[0]}  创建", style: const TextStyle(
                              color: Colors.white, fontSize: 14)),


                          const SizedBox(height: 10,),

                          Row(
                            children: [
                              InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  AudioListController.initMethod();
                                  Global.getInstance()!.fire(ChangePlayIndex(index:0,playAll: true));
                                },
                                child: Container(
                                  width: 110,
                                  height: 35,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(35)),
                                      gradient:LinearGradient(
                                          colors: [
                                            Color.fromRGBO(31, 210, 170, 1),
                                            Color.fromRGBO(31, 209, 163, 1),
                                            Color.fromRGBO(30, 205, 152, 1),
                                          ]
                                      )
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.play_arrow_outlined, size: 22,
                                        color: Colors.white,),
                                      Text("播放全部", textScaleFactor: 1,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),)
                                    ],
                                  ),
                                ),
                              ),

                              //收藏
                              const SizedBox(width: 10,),
                              InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  EasyLoading.showToast("请先登录");
                                },
                                child: Container(
                                  width: 110,
                                  height: 35,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(35)),
                                      color: Colors.red
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(FontAwesomeIcons.heartCirclePlus,
                                        size: 16, color: Colors.white,),
                                      SizedBox(width: 5,),
                                      Text("收藏", textScaleFactor: 1,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),)
                                    ],
                                  ),
                                ),
                              ),

                              //更多操作
                              const SizedBox(width: 10,),
                              JustTheTooltip(
                                controller: justTheController,
                                margin: const EdgeInsets.all(20.0),
                                isModal: true,
                                tailLength: 10.0,
                                barrierDismissible: true,
                                tailBaseWidth: 20,
                                preferredDirection: AxisDirection.down,
                                content: SizedBox(
                                  width: 120,
                                  height: 130,
                                  child: Material(
                                    color: const Color.fromRGBO(41, 41, 43, 1),
                                    child: Column(
                                      children: [
                                        ListTile(title: const Center(
                                            child: Text("下载", style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                              textScaleFactor: 1,)),
                                          dense: true,
                                          onTap: () {
                                            justTheController.hideTooltip();
                                            Global.getInstance()!.fire(ChangePlayIndex(delType: 1,delMore: true));

                                          },),
                                        const Divider(height: 1,),
                                        ListTile(title: const Center(
                                            child: Text("批量操作",
                                              style: TextStyle(fontSize: 14,
                                                  color: Colors.white),
                                              textScaleFactor: 1,)),
                                          dense: true,
                                          onTap: () {
                                            justTheController.hideTooltip();
                                            Global.getInstance()!.fire(ChangePlayIndex(delType: 0,delMore: true));

                                          },),
                                        const Divider(height: 1,),
                                        ListTile(title: const Center(
                                            child: Text("复制链接", style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                              textScaleFactor: 1,)),
                                          dense: true,
                                          onTap: () {
                                            justTheController.hideTooltip();

                                            var s = cloudShareMusicAlbum+widget.id.toString();
                                            Clipboard.setData(ClipboardData(text: s));
                                            EasyLoading.showToast("链接复制成功");
                                          },),
                                        Expanded(child: Container()),
                                      ],
                                    ),
                                  ),
                                ),
                                child: Material(
                                  color: Colors.grey.shade800,
                                  shape: const CircleBorder(),
                                  elevation: 4.0,
                                  child: Container(
                                      width: 35,
                                      height: 35,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(35)),
                                          color: Color.fromRGBO(48, 48, 49, 1)
                                      ),
                                      child: const Icon(
                                        Icons.more_horiz_outlined,
                                        color: Colors.white, size: 14,)
                                  ),
                                ),

                              )

                            ],
                          ),
                        ],
                      ),
                    ),
                  )

                ],
              ),
              const SizedBox(height: 20,),
              BrnTabBar(
                backgroundcolor: Colors.transparent,
                unselectedLabelColor: Colors.grey,
                tabWidth: 150,
                unselectedLabelStyle: const TextStyle(fontSize: 15),
                indicatorColor: Colors.white,
                indicatorWeight: 2,
                controller: tabController,
                labelColor: Colors.white,
                labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16),
                tabs: tabs,
                onTap: (state, index) {
                  pageController.jumpToPage(index);
                  if (index == 1 && desc != "暂无介绍") {
                    var indexWhere = CacheGlobalData.cacheAlbumDetailsList
                        .indexWhere((element) => element['id'] == widget.id);
                    if (indexWhere > -1) {
                      var cacheAlbumDetailsList = CacheGlobalData
                          .cacheAlbumDetailsList[indexWhere]['des'];
                      setState(() {
                        desc = cacheAlbumDetailsList.description;
                      });
                    }
                  }
                },
              ),

              const SizedBox(height: 10,),
              //下面的表格
              Expanded(child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                children: [
                  SongList(id: widget.id, type: widget.type==null? 2:widget.type!,),
                  const AlbumDesc()
                ],
                onPageChanged: (index) {
                  tabController.index = index;
                },
              )
              )
//
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    tabController.dispose();
    justTheController.dispose();
  }
}


class AlbumDesc extends StatelessWidget {
  const AlbumDesc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MusicPageController put = Get.put(MusicPageController());

    return Obx(() {
      return ListView(
        children: [
          Text(
            put.albumDesc.toString(), style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      );
    });
  }
}

