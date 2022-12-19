
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bruno/bruno.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/model/song/song_collect.dart';
import 'package:qq_music/model/song/song_fans_model.dart';
import 'package:qq_music/model/user/song_user_details_info.dart';
import 'play_song_details.dart';
import 'package:qq_music/service/user/user_service.dart';
import 'package:qq_music/utils/my_widget/CusBehavior.dart';

///[id] 歌手的id
class SongUserDetailsPage extends StatefulWidget {
  final int id;
  final SongUserDetailsModel userDetailsModel;
  const SongUserDetailsPage({Key? key,required this.id,required this.userDetailsModel}) : super(key: key);

  @override
  _SongUserDetailsPageState createState() => _SongUserDetailsPageState();
}

class _SongUserDetailsPageState extends State<SongUserDetailsPage> with  AutomaticKeepAliveClientMixin,TickerProviderStateMixin{

  List<BadgeTab> tabs =[
    BadgeTab(text: "歌单"),
    BadgeTab(text: "收藏"),
  ];
  //收藏
  List<SongCollectModel> collectList=[];
  //歌单
  List<SongCollectModel> songList=[];
  int selectIndex =0;
  int mvSize =0;
  //粉丝数
  int fans =0;
  //关注数
  int collect =0;
  late PageController pageController;
  late TabController tabController ;

  late  StateSetter fanSet;

  @override
  void initState() {
    super.initState();
    tabController =TabController(length: tabs.length, vsync: this);

    pageController =PageController(initialPage: 0);
    getSongFns();
    getSongCollect();
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
          child: ListView(
            children: [
              StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) setState) {
                  fanSet =setState;
                  return  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExtendedImage.network(
                          widget.userDetailsModel.user?.avatarUrl==null?widget.userDetailsModel.artist.picUrl ?? CacheGlobalData.errorImg:  widget.userDetailsModel.user!.avatarUrl,
                          fit: BoxFit.cover,
                          width: 180,
                          height: 180,
                          shape: BoxShape.circle,
                          cache: true,
                      ),

                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                  widget.userDetailsModel.artist.name==null? widget.userDetailsModel.user?.nickname  ?? "未知":"未知"
                                  ,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30)
                                  ,maxLines: 1),
                              const SizedBox(height: 10,),
                              //标签
                              SizedBox(
                                height:30,
                                child: Row(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height:20,
                                          decoration: const BoxDecoration(
                                              color: Colors.black54,
                                              borderRadius: BorderRadius.horizontal(right: Radius.circular(20),left:  Radius.circular(20))
                                          ),
                                          padding: const EdgeInsets.only(left: 25,right: 5),
                                          child: Text(widget.userDetailsModel.identify?.imageDesc ?? "暂无描述",style: const TextStyle(color: Colors.white,fontSize: 13),),
                                        ),
                                        Positioned(child:
                                        ExtendedImage.network(
                                          widget.userDetailsModel.identify?.imageUrl ?? CacheGlobalData.errorImg,
                                          fit: BoxFit.cover,
                                          width: 20,
                                          height: 20,
                                          shape: BoxShape.circle,
                                          cache: true,
                                        )
                                        )
                                      ],
                                    ),

                                    Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.black54,
                                          borderRadius: BorderRadius.horizontal(right: Radius.circular(20),left:  Radius.circular(20))
                                      ),
                                      height: 20,
                                      margin:const EdgeInsets.only(left: 10),
                                      padding:const EdgeInsets.only(left: 5,right: 5),
                                      child:   Text("Lv${widget.userDetailsModel.user?.vipType ?? 0}",style: const TextStyle(color: Colors.white,fontSize: 13),),
                                    )
                                  ],
                                ),
                              ),
                              const Divider(color: Colors.black12,),

                              //关注
                              Row(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(right: 30),
                                      child: Column(
                                        children: [
                                          Text("${widget.userDetailsModel.eventCount ?? 0}",style: const TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                                          const Text("动态",style: TextStyle(color: Colors.grey,fontSize: 13),),
                                        ],
                                      ),
                                    ),
                                  const SizedBox(
                                    width: 1,
                                    height: 30,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(color: Colors.grey),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right: 30,left: 30),
                                    child: Column(
                                      children: [
                                        Text("$collect",style: const TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                                        const Text("关注",style: TextStyle(color: Colors.grey,fontSize: 13),),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 1,
                                    height: 30,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(color: Colors.grey),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 30),
                                    child: Column(
                                      children: [
                                        Text("$fans",style: const TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                                        const Text("粉丝",style: TextStyle(color: Colors.grey,fontSize: 13),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              //个人介绍
                              AutoSizeText.rich(
                                TextSpan(text: "个人介绍：",
                                  children: [
                                    TextSpan(text:
//                                    widget.userDetailsModel.artist.name==null?"未知": widget.userDetailsModel.user?.nickname ?? "未知"

                                        widget.userDetailsModel.artist.briefDesc==null?"暂无介绍":
                                        widget.userDetailsModel.user?.signature ?? "暂无介绍"


                                        ,style: TextStyle(color: Colors.grey[400],fontSize: 14))
                                  ],
                                  style: const TextStyle(color: Colors.white,fontSize: 15)
                                ),minFontSize: 12,maxLines: 1,overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      )

                    ],
                  );
                },
              ),

              const SizedBox(height: 50,),

              BrnTabBar(
                backgroundcolor: Colors.transparent,
                unselectedLabelColor: Colors.grey,
                tabWidth:150,
                controller: tabController,
                unselectedLabelStyle: const TextStyle(fontSize: 15),
                indicatorColor: Colors.white,
                indicatorWeight:2,
                labelColor:Colors.white,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                tabs: tabs,
                onTap: (state, index) {
                  setState(() {
                    selectIndex=index;
                  });
                },
              ),

              const SizedBox(height: 10,),
                GridView.builder( shrinkWrap: true,
                  itemCount: selectIndex==0?songList.length: collectList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    /// 纵轴间距
                    mainAxisSpacing: 20.0,
                    /// 横轴间距
                    crossAxisSpacing: 30.0,
                    /// 横轴元素个数
                    crossAxisCount: 4,
                    /// 宽高比
                    childAspectRatio: 0.9,
                  ), itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        if(selectIndex==0){
                          goToPage(songList,index);
                        }else{
                          goToPage(collectList,index);
                        }
                      },
                      child: LayoutBuilder(
                        builder: (context , constraints ) {
                          return    Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width:double.infinity,
                                  height: constraints.biggest.height-50,
                                  child:      ExtendedImage.network(
                                    selectIndex==0?songList[index].coverImgUrl ?? "":  collectList[index].coverImgUrl ?? "",
                                    fit: BoxFit.fill,
                                    cache: true,
                                    width: constraints.biggest.width,
                                    height: constraints.biggest.height-45,
                                  )),

                              const SizedBox(height: 10,),
                              SizedBox(
                                height: 40,
                                child: Text( selectIndex==0?songList[index].name ?? "":  collectList[index].name ?? "",style: const TextStyle(color: Colors.white,fontSize: 15),textScaleFactor: 1,),
                              )
                            ],);
                        },
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  //获取关注数，粉丝数量
  getSongFns() async{
      SongFansModel ? songFns = await UserSerVice.getSongFns(id: widget.id);
      if(songFns!=null){
        fans =songFns.fansCnt;
        collect=songFns.followCnt;
        fanSet(() {

        });
      }
  }

  //获取用户的个单和收藏
  getSongCollect() async{

    List<SongCollectModel> ? list = await UserSerVice.getSongCollect(uid: widget.userDetailsModel.user?.userId ?? widget.userDetailsModel.artist.id);
    if(list!=null){
      for(var i=0;i<list.length;i++){
        //true：是收藏，false：是歌单
        if(list[i].ordered){
          collectList.add(list[i]);
        }else{
          songList.add(list[i]);
        }
      }
      setState(() {
        tabs =[
          BadgeTab(text: "歌单(${songList.length})"),
          BadgeTab(text: "收藏(${collectList.length})"),
        ];
      });
    }
  }


  @override
  bool get wantKeepAlive => true;


  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    tabController.dispose();
  }

  void goToPage(List<SongCollectModel> songList,int index) {
    Get.to(()=>PlaySongDetailsPage(id: songList[index].id,
      picUrl: songList[index].coverImgUrl ?? "",
      name: selectIndex==0?  songList[index].name ?? "未知" :  collectList[index].creator.nickname ,
      avatarUrl: songList[index].creator.avatarUrl,
      nickname: songList[index].creator.nickname,
      createTime:  songList[index].createTime ?? 0,
      uid: songList[index].creator.userId,
    ),transition: Transition.rightToLeft);
  }
}

