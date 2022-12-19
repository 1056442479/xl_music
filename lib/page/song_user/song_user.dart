
import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/model/user/song_user_details_info.dart';
import 'package:qq_music/page/song_user/album.dart';
import '../mv/mv_list_page.dart';
import 'package:qq_music/page/song_user/song_user_details_page.dart';
import 'package:qq_music/utils/Global.dart';
import 'song_list.dart';
import 'package:qq_music/service/user/user_service.dart';
import 'package:qq_music/utils/my_widget/CusBehavior.dart';

///[id] 歌手的id
///[username] 用户名
class SongUser extends StatefulWidget {
  final int id;
  final String username;
  const SongUser({Key? key,required this.id,required this.username}) : super(key: key);

  @override
  _SongUserState createState() => _SongUserState();
}

class _SongUserState extends State<SongUser> with TickerProviderStateMixin ,AutomaticKeepAliveClientMixin{

  List<BadgeTab> tabs =[
    BadgeTab(text: "歌曲"),
    BadgeTab(text: "专辑"),
    BadgeTab(text: "详情"),
    BadgeTab(text: "MV"),
  ];
  int selectIndex =0;
  int mvSize =0;
  late TabController tabController ;
  late PageController pageController;
  late  StateSetter mainSet;
  late  StateSetter textSet;

  SongUserDetailsModel ? userDetailsModel;

  @override
  void initState() {
    super.initState();
    tabController =TabController(length: tabs.length, vsync: this);
    pageController =PageController(initialPage: 0);

    getSongDetailsInfo(widget.id);


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
              StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) setState) {
                  mainSet =setState;
                  return  userDetailsModel==null?const SizedBox( height: 150,
                    width: 150,): Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          image: DecorationImage(
                            image: NetworkImage( userDetailsModel?.artist.cover ?? CacheGlobalData.errorImg,),
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
                              SelectableText(widget.username,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30)
                                  ,maxLines: 1),
                              const SizedBox(height: 10,),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:  NetworkImage(userDetailsModel?.user?.avatarUrl ?? CacheGlobalData.errorImg),
                                  ),

                                  const SizedBox(width: 15,),
                                  Text("单曲数：${userDetailsModel?.artist.musicSize}",style: const TextStyle(color: Colors.white,fontSize: 14)),

                                  const SizedBox(width: 15,),
                                  Text("专辑数：${userDetailsModel?.artist.albumSize}",style: const TextStyle(color: Colors.white,fontSize: 14)),


                                  const SizedBox(width: 15,),
                                  Text("MV数：${userDetailsModel?.artist.mvSize}",style: const TextStyle(color: Colors.white,fontSize: 14)),


                                ],
                              ),
                              const SizedBox(height: 10,),
                              const SizedBox(height: 10,),

                              Row(
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap:(){
                                      Global.logger.d(userDetailsModel?.user);

                                        Get.to(()=>SongUserDetailsPage(id: widget.id, userDetailsModel: userDetailsModel!),transition: Transition.zoom);
                                    },
                                    child: Container(
                                      width: 110,
                                      height: 35,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(35)),
                                          gradient:LinearGradient(
                                              colors: [
                                                Colors.greenAccent,
                                                Colors.lightGreenAccent,
                                                Colors.green,
                                              ]
                                          )
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.play_arrow_outlined,size: 22,color: Colors.white,),
                                          Text("个人主页",textScaleFactor: 1,style: TextStyle(color: Colors.white,fontSize: 16),)
                                        ],
                                      ),
                                    ),
                                  ),

                                  //收藏
                                  const SizedBox(width: 10,),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: (){
                                      EasyLoading.showToast("请先登录");
                                    },
                                    child: Container(
                                      width: 110,
                                      height: 35,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(35)),
                                          color: Colors.red
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Icon(FontAwesomeIcons.heartCirclePlus,size: 16,color: Colors.white,),
                                          SizedBox(width: 5,),
                                          Text("收藏",textScaleFactor: 1,style: TextStyle(color: Colors.white,fontSize: 16),)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )

                    ],
                  );
                },
              ),

              const SizedBox(height: 20,),

              BrnTabBar(
                backgroundcolor: Colors.transparent,
                unselectedLabelColor: Colors.grey,
                tabWidth:60,
                unselectedLabelStyle: const TextStyle(fontSize: 15),
                indicatorColor: Colors.white,
                indicatorWeight:2,
                controller: tabController,
                labelColor:Colors.white,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                tabs: tabs,
                onTap: (state, index) {
                  pageController.jumpToPage(index);
//                  if(index==2){
//                    textSet((){});
//                  }
                },
              ),

              const SizedBox(height: 10,),
              //下面的表格
              Expanded(child:
              PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                children: [
                  SongList(id: widget.id,type: 1,),
                  //专辑
                   AlbumListPage(id: widget.id,),
                  //介绍
                  StatefulBuilder(
                    builder: (BuildContext context, void Function(void Function()) setState) {
                      textSet =setState;
                      return          Text("\u3000\u3000${
                          (userDetailsModel?.artist.briefDesc ==null)?
                          userDetailsModel?.user?.signature ?? "暂无介绍": userDetailsModel?.artist.briefDesc?.replaceAll("\n"," \u3000")
                              ?? '暂无介绍'}",style: const TextStyle(color: Colors.white),);
                    },
                  ),


                  MvListPage(id: widget.id,mvSize: mvSize,)
                ],
                onPageChanged: (index){
                  tabController.index =index;
                },
              )
              )
            ],
          ),
        ),
      ),
    );
  }





  @override
  bool get wantKeepAlive => true;

  ///获取歌手的详情
  getSongDetailsInfo(int id) async{
    var songUserDetailsModel = await UserSerVice.getSongDetailsInfo(id: id);
    if(songUserDetailsModel!=null){
      userDetailsModel =songUserDetailsModel;
      mvSize =userDetailsModel?.artist.mvSize ?? 0;
      mainSet((){});
    }
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    tabController.dispose();
  }
}
