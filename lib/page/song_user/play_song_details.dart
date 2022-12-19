
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
import 'package:qq_music/model/event/event_model.dart';
import 'package:qq_music/model/song/song_list_details.dart';
import 'package:qq_music/page/user/user_details_page.dart';
import 'package:qq_music/page/zai_xian_music/recommend/song_list/collect_user.dart';
import 'package:qq_music/service/song/song_service.dart';
import 'package:qq_music/utils/Global.dart';
import 'song_list.dart';
import 'package:qq_music/utils/my_widget/CusBehavior.dart';

///歌单页面
class PlaySongDetailsPage extends StatefulWidget {
  final int id;
  final int ? uid;
  final String picUrl;
  final String name;
  final String ? avatarUrl;
  final String ? nickname;
  final int ? createTime;
  const PlaySongDetailsPage({Key? key,required this.id,required this.picUrl,required this.name, this.avatarUrl, this.createTime, this.nickname,  this.uid}) : super(key: key);

  @override
  _RecommendDetailsState createState() => _RecommendDetailsState();
}

class _RecommendDetailsState extends State<PlaySongDetailsPage> with TickerProviderStateMixin ,AutomaticKeepAliveClientMixin{

  List<Song> songList =[];
  List<BadgeTab> tabs =[
    BadgeTab(text: "歌曲"),
    BadgeTab(text: "收藏者"),
  ];
  int selectIndex =0;
  late TabController tabController ;
  late PageController pageController;
  JustTheController justTheController =JustTheController();
  int colorIndex =-1;
  late  StateSetter bSetter ;
  ///2秒内,不会重复执行
  int seconds =-1;
  String nickname ="未知";
  int uid =-1;
  int createTime =0;
  String  avatarUrl =CacheGlobalData.errorImg;
  @override
  void initState() {
    super.initState();
    tabController =TabController(length: tabs.length, vsync: this);
    pageController =PageController(initialPage: 0);

    getSongPlayDetailsInfo(widget.id);
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
                  bSetter =setState;
                  return    Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          image: DecorationImage(
                            image: NetworkImage( widget.picUrl,),
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
                                    child: const Text("歌单",style: TextStyle(color: Colors.white,fontSize: 15),),
                                  ),
                                  Expanded(child:
                                  AutoSizeText(widget.name,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30,overflow: TextOverflow.ellipsis)
                                    ,maxLines: 1,minFontSize: 20,),
                                  ),

                                ],
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:  NetworkImage(widget.avatarUrl ?? avatarUrl),
                                  ),
                                  const SizedBox(width: 15,),
                                  InkWell(
                                      onTap: (){
                                        if(widget.uid==null && uid==-1){
                                          EasyLoading.showToast("用户信息获取失败");
                                          return;
                                        }
                                        Get.to(()=>UserDetailsPage(uid: widget.uid ?? uid, username: widget.nickname ?? nickname));
                                      },
                                      child: Text(widget.nickname ?? nickname,
                                          style: const TextStyle(
                                              color: Colors.white, fontSize: 14))),
                                  const SizedBox(width: 15,),
                                  Text("${DateTime.fromMillisecondsSinceEpoch(int.parse(widget.createTime==null? createTime .toString():widget.createTime.toString())).toString().split(" ")[0]}  创建",style: const TextStyle(color: Colors.white,fontSize: 14)),


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
                                      AudioListController.initMethod();
                                      Global.getInstance()!.fire(ChangePlayIndex(index:0,playAll: true));

                                    },
                                    child: Container(
                                      width: 110,
                                      height: 35,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(35)),
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
                                          Icon(Icons.play_arrow_outlined,size: 22,color: Colors.white,),
                                          Text("播放全部",textScaleFactor: 1,style: TextStyle(color: Colors.white,fontSize: 16),)
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
                                      EasyLoading.showToast("需要登录后使用");
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

                                  //更多操作
                                  const SizedBox(width: 10,),
                                  JustTheTooltip(
                                    controller: justTheController,
//                                    margin: const EdgeInsets.all(20.0),
                                    isModal: true,
                                    tailLength: 10.0,
                                    barrierDismissible: true,
                                    tailBaseWidth: 20,
//                                    preferredDirection: AxisDirection.down,
                                    content: SizedBox(
                                      width: 120,
                                      height: 130,
                                      child:  Column(
                                        children: [
                                          ListTile(title:const Center(child:  Text("下载",style: TextStyle(fontSize: 14,color: Colors.white),textScaleFactor: 1,)),dense: true,onTap: (){
                                            justTheController.hideTooltip();
                                            Global.getInstance()!.fire(ChangePlayIndex(delType: 1,delMore: true));

                                          },),
                                          const Divider(height: 1,),
                                          ListTile(title:const Center(child:  Text("批量操作",style: TextStyle(fontSize: 14,color: Colors.white),textScaleFactor: 1,)),dense: true,onTap: (){
                                            justTheController.hideTooltip();
                                            Global.getInstance()!.fire(ChangePlayIndex(delType: 0,delMore: true));

                                          },),
                                          const Divider(height: 1,),
                                          ListTile(title:const Center(child:  Text("复制链接",style: TextStyle(fontSize: 14,color: Colors.white),textScaleFactor: 1,)),dense: true,onTap: (){
                                            justTheController.hideTooltip();

                                            var s = cloudShareMusicSong+widget.id.toString();
                                            Clipboard.setData(ClipboardData(text: s));
                                            EasyLoading.showToast("链接复制成功");
                                          },),
                                          Expanded(child: Container()),
                                        ],
                                      ),
                                    ),
                                    child:    Material(
                                      color: Colors.grey.shade800,
                                      shape: const CircleBorder(),
                                      elevation: 4.0,
                                      child: Container(
                                          width: 35,
                                          height: 35,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(35)),
                                              color: Color.fromRGBO(48, 48, 49, 1)
                                          ),
                                          child: const Icon(Icons.more_horiz_outlined,color: Colors.white,size: 14,)
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
                },
              ),

              const SizedBox(height: 10,),
              //下面的表格
              Expanded(child:
                  PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    children: [
                            SongList(id: widget.id,type: 0,),
                            CollectUserPage(id:  widget.id)
                    ],
                    onPageChanged: (index){
                        tabController.index =index;
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

  ///获取用户的信息
  getSongPlayDetailsInfo(int id) async{
    if (uid == -1 && widget.uid == null) {
      //先获取缓存
      var indexWhere = CacheGlobalData.cacheSongDetailsInfo
          .indexWhere((element) => element['id'] == id);
      if (indexWhere > -1) {
        var details = CacheGlobalData.cacheSongDetailsInfo[indexWhere]['song'];
        uid = details.creator.userId;
        createTime = details.createTime;
        nickname = details.creator.nickname;
        avatarUrl = details.creator.avatarUrl;
        return;
      }
      var details = await SongService.getSongPlayDetailsInfo(id);
      if (details != null) {
        uid = details.creator.userId;
        createTime = details.createTime;
        nickname = details.creator.nickname;
        avatarUrl = details.creator.avatarUrl;

        CacheGlobalData.cacheSongDetailsInfo
            .add({"id": details.id, "song": details});
        bSetter(() {});
      }
    }
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
