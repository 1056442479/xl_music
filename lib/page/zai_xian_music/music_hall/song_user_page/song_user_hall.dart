
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:qq_music/model/user/song_user_select.dart';
import 'package:qq_music/page/song_user/song_user.dart';
import 'package:qq_music/service/online_music/online_music_service.dart';

class SongUserHall extends StatefulWidget {
  const SongUserHall({Key? key}) : super(key: key);

  @override
  _SongUserHallState createState() => _SongUserHallState();
}

class _SongUserHallState extends State<SongUserHall> with AutomaticKeepAliveClientMixin{

  List<SongUserSelect> songSelectList =[];
  int page =1;

  //地区
  int area =-1;
  //分类
  int type =-1;
  ScrollController scrollController =ScrollController();

  ///地区列表
  List<Map> areaList =[
    {
      "id":-1,
      "name":"全部"
    },{
      "id":7,
      "name":"内地"
    },{
      "id":96,
      "name":"欧美"
    },{
      "id":8,
      "name":"日本"
    },{
      "id":16,
      "name":"韩国"
    },{
      "id":0,
      "name":"其它"
    }
  ];

  ///类型
  List<Map> typeList =[
    {
      "id":-1,
      "name":"全部"
    },{
      "id":1,
      "name":"男歌手"
    },{
      "id":2,
      "name":"女歌手"
    },{
      "id":3,
      "name":"乐队"
    }
  ];
  //筛选
  dynamic initial =-1;
  int initialIndex =0;

  //数据是否请求中
  bool dataRs =false;
  List<dynamic>  initialList =[
    "热门","A","B","C","D","E","F","G","H","I","G","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","#"
  ];
  bool noMore =false;

  @override
  void initState() {
    super.initState();
    getGroupSongUser(init: true);

    scrollController.addListener(() {
      if (scrollController.offset+40 >= scrollController.position.maxScrollExtent) {
        if(dataRs==false){
          dataRs=true;
          debugPrint("滚动到底部bottom了...");
          getGroupSongUser(init: false);
        }

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: const EdgeInsets.only(left: 20,right: 20),
      width: double.infinity,
      height: double.infinity,
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 180,
              child: Column(
                children: [
                  //地区
                  SizedBox(
                    height: 30,
                    child: ListView.builder(itemBuilder: (context, index) {
                      return InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onTap: (){
                          if(area!=areaList[index]['id']){
                            setState(() {
                              area =areaList[index]['id'];
                              getGroupSongUser(init: true);
                            });
                          }
                        },
                        child: Container(
                          width: 80,
                          height: 30,
                          alignment: Alignment.center,
                          margin:const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              gradient: areaList[index]['id']==area?const LinearGradient(
                                  colors: [
                                    Color.fromRGBO(21, 212, 174, 1),
                                    Color.fromRGBO(31, 208, 163, 1),
                                    Color.fromRGBO(30, 205, 150, 1),
                                  ]
                              ):const LinearGradient(
                                  colors: [
                                    Colors.black26,
                                    Colors.black26,
                                  ]
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(40))
                          ),
                          padding: const EdgeInsets.all(5),
                          child: Text(areaList[index]['name'],style: const TextStyle(color: Colors.white,fontSize: 15),),
                        ),
                      );
                    },itemCount: areaList.length,scrollDirection: Axis.horizontal,),
                  ),
                  const SizedBox(height: 20,),

                  //类型
                  SizedBox(
                    height: 30,
                    child: ListView.builder(itemBuilder: (context, index) {
                      return InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onTap: (){
                          if(type!=typeList[index]['id']){
                            setState(() {
                              type =typeList[index]['id'];
                              getGroupSongUser(init: true);
                            });
                          }
                        },
                        child: Container(
                          width: 80,
                          height: 30,
                          alignment: Alignment.center,
                          margin:const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              gradient: typeList[index]['id']==type?const LinearGradient(
                                  colors: [
                                    Color.fromRGBO(21, 212, 174, 1),
                                    Color.fromRGBO(31, 208, 163, 1),
                                    Color.fromRGBO(30, 205, 150, 1),
                                  ]
                              ):const LinearGradient(
                                  colors: [
                                    Colors.black26,
                                    Colors.black26,
                                  ]
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(40))
                          ),
                          padding: const EdgeInsets.all(5),
                          child: Text(areaList[index]['name'],style: const TextStyle(color: Colors.white,fontSize: 15),),
                        ),
                      );
                    },itemCount: typeList.length,scrollDirection: Axis.horizontal,),
                  ),
                  const SizedBox(height: 20,),

                  //筛选
                  Expanded(
                    child:  GridView.builder(
                        itemCount: initialList.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          /// 纵轴间距
                          mainAxisSpacing: 5,
                          /// 横轴间距
                          crossAxisSpacing: 5,
                          /// 横轴元素个数
                          crossAxisCount: 14,
                          /// 宽高比
                          childAspectRatio:2,
                        ), itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          if(index!=initialIndex){
                            setState(() {
                              initial =initialList[index]=="热门"?-1:initialList[index]=="#"?0:initialList[index];
                              initialIndex =index;
                              getGroupSongUser(init: true);
                            });
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(left: 3),
                          child: Text("${initialList[index]}",style: TextStyle(color: index==initialIndex? Colors.greenAccent:Colors.white),),
                        ),
                      );
                    })
                  ),
                ],
              ),
            ),
          ),
          SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                return InkWell(
                  hoverColor: Colors.transparent,
                  onTap: (){
                    Get.to(()=> SongUser(id: songSelectList[index].id, username: songSelectList[index].name,),transition: Transition.rightToLeft);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 15,right: 15),
                    child: Column(
                      children: [
                        Expanded(child:   ExtendedImage.network( songSelectList[index].picUrl,fit: BoxFit.fill,)
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          songSelectList[index].name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textScaleFactor: 1,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),

                      ],
                    ),
                  ),
                );
              }, childCount: songSelectList.length),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                /// 纵轴间距
                mainAxisSpacing: 25,
                /// 横轴间距
                crossAxisSpacing: 20,
                /// 横轴元素个数
                crossAxisCount: 4,
                /// 宽高比
                childAspectRatio: 1.2,
              )),

        ],
      ),
    );
  }

  ///获取筛选歌手
  ///[init] 是否重新帅选了
  getGroupSongUser({required bool init}) async{
    if(init){
      noMore =false;
      songSelectList.length=0;
    }
    if(noMore){
      dataRs=false;
      EasyLoading.showToast("没有更多了");
      return;
    }

    var topData = await OnlineMusicService.getGroupSongUser(page: page,area: area,initial: initial,type: type,limit: 28);
    if(topData!=null){
      if(topData.isEmpty){
        noMore =true;
      }else{
        songSelectList.addAll(topData);
      }
    }
    setState(() {
      dataRs=false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }
  @override
  bool get wantKeepAlive =>true;
  }



