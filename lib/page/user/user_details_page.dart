

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bruno/bruno.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/model/song/song_collect.dart';
import 'package:qq_music/model/user/user_details_model.dart';
import '../song_user/play_song_details.dart';
import 'package:qq_music/service/user/user_service.dart';
import 'package:qq_music/utils/my_widget/CusBehavior.dart';

///[uid] 用户的id
///[username] 用户名
class UserDetailsPage extends StatefulWidget {
  final int uid;
  final String username;
  const UserDetailsPage({Key? key,required this.uid,required this.username}) : super(key: key);

  @override
  _SongUserState createState() => _SongUserState();
}

class _SongUserState extends State<UserDetailsPage> with TickerProviderStateMixin ,AutomaticKeepAliveClientMixin{

  List<BadgeTab> tabs =[
    BadgeTab(text: "歌单"),
    BadgeTab(text: "收藏"),
  ];
  //收藏
  List<SongCollectModel> collectList=[];
  //歌单
  List<SongCollectModel> songList=[];
  int selectIndex =0;
  late TabController tabController ;
  late  StateSetter mainSet;
  late  StateSetter textSet;

  UserDetails ? userDetails;

  @override
  void initState() {
    super.initState();
    tabController =TabController(length: tabs.length, vsync: this);

    getUserInfo(widget.uid);

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
                  mainSet =setState;
                  return  userDetails==null?const SizedBox( height: 150,
                    width: 150,): Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          image: DecorationImage(
                            image: NetworkImage(userDetails?.profile.avatarUrl ?? CacheGlobalData.errorImg),
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

                                crossAxisAlignment: CrossAxisAlignment.center,

                                children: [
                                  SelectableText(userDetails==null? widget.username:userDetails!.profile.nickname,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30)
                                      ,maxLines: 1),
                                  const SizedBox(width: 10,),
                                  //标签
                                  SizedBox(

                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.black54,
                                              borderRadius: BorderRadius.horizontal(right: Radius.circular(20),left:  Radius.circular(20))
                                          ),
                                          height: 20,
                                          margin:const EdgeInsets.only(left: 10),
                                          padding:const EdgeInsets.only(left: 5,right: 5),
                                          child:   Text("Lv${userDetails?.level ?? 0}",style: const TextStyle(color: Colors.white,fontSize: 13),),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              const Divider(color: Colors.black12,height: 1,),
                              //关注
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 30),
                                    child: Column(
                                      children: [
                                        Text("${userDetails?.profile.eventCount ?? 0}",style: const TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
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
                                        Text("${userDetails?.profile.follows ?? 0}",style: const TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
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
                                        Text("${userDetails?.profile.followeds ?? 0}",style: const TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                                        const Text("粉丝",style: TextStyle(color: Colors.grey,fontSize: 13),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              const SizedBox(height: 10,),
                              //个人介绍
                              AutoSizeText.rich(
                                TextSpan(text: "个人介绍：",
                                    children: [
                                      TextSpan(text:userDetails==null?" 暂无介绍":  userDetails!.profile.signature.isEmpty ? " 暂无介绍":  userDetails!.profile.signature,style: TextStyle(color: Colors.grey[400],fontSize: 14))
                                    ],
                                    style: const TextStyle(color: Colors.white,fontSize: 15)
                                ),minFontSize: 12,maxLines: 1,overflow: TextOverflow.ellipsis,
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
                tabWidth:150,
                unselectedLabelStyle: const TextStyle(fontSize: 15),
                indicatorColor: Colors.white,
                indicatorWeight:2,
                controller: tabController,
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

  void goToPage(List<SongCollectModel> songList,int index) {
    Get.to(()=>PlaySongDetailsPage(
      id: songList[index].id,
      picUrl: songList[index].coverImgUrl ?? "",
      name: selectIndex==0?  songList[index].name ?? "未知" :  collectList[index].creator.nickname ,
      avatarUrl: songList[index].creator.avatarUrl,
      nickname: songList[index].creator.nickname,
      createTime:  songList[index].createTime ?? 0,
      uid: songList[index].creator.userId,
    ),transition: Transition.rightToLeft);
  }

  //获取用户的个单和收藏
  getSongCollect() async{

    List<SongCollectModel> ? list = await UserSerVice.getSongCollect(uid: widget.uid);
    if(list!=null){
      for(var i=0;i<list.length;i++){
        //true：是收藏，false：是歌单
        if(list[i].ordered){
          collectList.add(list[i]);
        }else{
          songList.add(list[i]);
        }
      }
      if(mounted){
        setState(() {
          tabs =[
            BadgeTab(text: "歌单(${songList.length})"),
            BadgeTab(text: "收藏(${collectList.length})"),
          ];
        });
      }
    }
  }



  @override
  bool get wantKeepAlive => true;

  ///获取用户的详情
  getUserInfo(int uid) async{
    var user = await UserSerVice.getUserInfo(uid: uid);
    if(user!=null){
      userDetails =user;
      mainSet((){});
    }
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }
}
