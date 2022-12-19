
import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:qq_music/const/global.dart';
import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/controller/audio_list_controller.dart';
import 'package:qq_music/controller/search_controller.dart';
import 'package:qq_music/model/event/event_model.dart';
import 'package:qq_music/model/song/song_list_details.dart';
import 'package:qq_music/page/more_deal/more_deal_down.dart';
import 'package:qq_music/page/song_user/album_details_page.dart';
import 'package:qq_music/page/song_user/song_user.dart';
import 'package:qq_music/service/search/search_service.dart';
import 'package:qq_music/utils/Global.dart';
import 'package:qq_music/utils/commutils.dart';
import 'package:qq_music/utils/my_widget/CusBehavior.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

///音乐搜索结果页
class ResSongPage extends StatefulWidget {
  final String keyword;
  final SearchController searchController;
  const ResSongPage({Key? key,required this.keyword,required this.searchController}) : super(key: key);

  @override
  State createState() => _MoreDealPageState();
}

class _MoreDealPageState extends State<ResSongPage> with AutomaticKeepAliveClientMixin{
  bool addList =false;
  bool play =false;
  int total =0;
  int page =1;
  ///请求是否结束
  bool dataRes=false;
  ///是否初始请求
  bool initRes =true;
  String keyword="";
  Song ? downSong;
  ScrollController scrollController =ScrollController();
  List<Song> songList =[];
  late StreamSubscription stream;
  late StreamSubscription listen;


  @override
  void initState() {
    super.initState();
    keyword =widget.keyword;



    stream=  Global.getInstance()!.on<StartSearch>().listen((event) {
      if(keyword!=event.keyword){
        keyword =event.keyword.trim();
        getResSong(init: true);
      }
    });
    listen = Global.getInstance()!.on<ChangePlayIndex>().listen((event) {
      if(mounted && event.downSong!=null){
        setState(() {
          downSong =event.downSong;
        });
      }
    });

    scrollController.addListener(() {
      if (scrollController.offset+150>= scrollController.position.maxScrollExtent) {
        if(dataRes==false){
          dataRes=true;
          debugPrint("滚动到底部bottom了...");
          page+=1;
          getResSong(init: false,);
        }
      }
    });
    getResSong(init: true);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Material(
      color: const Color.fromRGBO(30, 30, 31, 1),
      child: Container(
        margin:const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
              child: Row(
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap:(){
                      if(songList.isEmpty){
                        EasyLoading.showToast("暂无搜素记录");
                        return;
                      }
                      dealPayAllSong(0);
                    },
                    child: Container(
                      width: 110,
                      height: 35,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(Icons.play_arrow_outlined,color: Colors.white,size: 17,),
                          SizedBox(width: 5,),
                          Text("播放全部",style: TextStyle(color: Colors.white,fontSize: 15),)
                        ],
                      ),
                    ),
                  ),
                  const   SizedBox(width: 10,),
                  ///添加至播放列表
                  InkWell(
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap:(){
                      if(songList.isEmpty){
                        EasyLoading.showToast("暂无搜索记录");
                        return;
                      }
                      if(play){
                        EasyLoading.showToast("已添加至播放列表");
                        return;
                      }
                      if(addList==false){
                        AudioListController.playList.addAll(songList);
                        final ids = AudioListController.playList.map((e) => e.id).toSet();
                        AudioListController.playList.retainWhere((x) => ids.remove(x.id));
                        addList=true;
                        EasyLoading.showToast("已添加至播放列表");
                      }else{
                        EasyLoading.showToast("已添加至播放列表");
                      }
                    },
                    child: Container(
                      width: 110,
                      height: 35,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Color.fromRGBO(52, 52, 53, 1)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(Icons.add,color: Colors.white,size: 17,),
                          SizedBox(width: 5,),
                          Text("播放队列",style: TextStyle(color: Colors.white,fontSize: 15),)
                        ],
                      ),
                    ),
                  ),

                  ///下载
                  const SizedBox(width: 10,),
                  InkWell(
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap:(){
                      if(songList.isEmpty){
                        EasyLoading.showToast("暂无搜素记录");
                        return;
                      }
                      CacheGlobalData.delMoreList =songList;
                      Get.to(()=>const MoreDealDownPage(),transition: Transition.rightToLeft);
                    },
                    child: Container(
                      width: 110,
                      height: 35,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Color.fromRGBO(52, 52, 53, 1)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(Icons.download_rounded,color: Colors.white,size: 17,),
                          SizedBox(width: 5,),
                          Text("下载",style: TextStyle(color: Colors.white,fontSize: 15),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //表头
            Container(
              margin:  const EdgeInsets.only(left: 15,right: 15,top: 10),
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child:  const Text("歌曲",style: TextStyle(color: Colors.grey,fontSize: 13),textScaleFactor:1),
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text("歌手",style: TextStyle(color: Colors.grey,fontSize: 13),textScaleFactor:1),
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text("专辑",style: TextStyle(color: Colors.grey,fontSize: 13),textScaleFactor:1),
                    ),
                  ),

                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text("时长",style: TextStyle(color: Colors.grey,fontSize: 13),textScaleFactor:1),
                    ),
                  ),
                ],
              ),
            ),

            //歌曲列表
            Expanded(child:initRes? const Center(
                child: SleekCircularSlider(
                    appearance: CircularSliderAppearance(
                      spinnerMode: true,
                    ))
            ): ListView.builder( addAutomaticKeepAlives: true,
              itemCount: songList.length,
              controller: scrollController,
              itemBuilder: (context, index) {
                return StatefulBuilder(
                  builder: (BuildContext context, void Function(void Function()) setStates) {
                    return Container(
                      height: 40,
                      margin: const EdgeInsets.only(top: 5,bottom: 5,left: 15,right: 15),
                      child: GestureDetector(
                        behavior:HitTestBehavior.translucent,
                        onDoubleTap:(){
                          dealPayAllSong(index);
                        } ,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //名称
                            Expanded(
                              flex: 3,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  constraints: const BoxConstraints(
                                      minWidth: 50, maxWidth: 500),
                                  child: AutoSizeText(
                                    songList[index].name,
                                    style:  TextStyle(
                                        color: (downSong?.id ==songList[index].id)?Colors.greenAccent: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w200),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    minFontSize: 11,
                                  ),
                                ),
                              ),
                            ),
                            const  SizedBox(width: 10,),
                            // 歌手
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin: const EdgeInsets.only(right: 7),
                                alignment: Alignment.centerLeft,
                                child: MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: ScrollConfiguration(
                                    behavior: CusBehavior(),
                                    child: ListView.builder(itemBuilder: (context,authorIndex){
                                      return InkWell(
                                        hoverColor: Colors.transparent,
                                        onTap: (){
                                          goToSongUser(songList[index].ar[authorIndex].id,songList[index].ar[authorIndex].name);
                                        },
                                        child: Center(
                                          child: AutoSizeText("${
                                              authorIndex==songList[index].ar.length-1?songList[index].ar[authorIndex].name:"${songList[index].ar[authorIndex].name}/"} "
                                            ,textScaleFactor: 1,minFontSize: 11,
                                            style:   TextStyle(
                                                color: (downSong?.id ==songList[index].id)?Colors.greenAccent: Colors.white
                                                ,fontSize: 13),maxLines: 2,  overflow: TextOverflow.ellipsis,

                                          ),
                                        ),
                                      );
                                    },itemCount: songList[index].ar.length,shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            //专辑
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin: const EdgeInsets.only(right: 7),
                                alignment: Alignment.centerLeft,
                                child:  ListTile(
                                  contentPadding: const EdgeInsets.all(0),
                                  title:AutoSizeText(songList[index].al.name.trim(),minFontSize: 11
                                    ,style:   TextStyle(
                                      color: (downSong?.id ==songList[index].id)?Colors.greenAccent: Colors.white,

                                      fontSize: 14,fontWeight: FontWeight.w200),maxLines: 2,  overflow: TextOverflow.ellipsis,
                                  ),
                                  hoverColor: Colors.transparent,
                                  onTap: (){
                                    Get.to(()=>AlbumDetailsPage(id: songList[index].al.id,
                                      createTime:  songList[index].publishTime ?? 0, name: songList[index].al.name,
                                      picUrl: songList[index].al.picUrl ?? CacheGlobalData.errorImg, username: songList[index].ar[0].name,
                                      uid: songList[index].ar[0].id,),transition: Transition.rightToLeft);
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            //时间
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: const EdgeInsets.only(right: 7),
                                alignment: Alignment.centerLeft,
                                child:  Text( CommUtils.formatMinSec(songList[index].dt),style:  TextStyle(fontSize: 12,
                                  color: (downSong?.id ==songList[index].id)?Colors.greenAccent: Colors.white,
                                ),)
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },)
            )
          ],
        ),
      ),
    );
  }


  ///去往歌手页面
  void goToSongUser(int id,String name) {
    Get.to(()=> SongUser(id: id,username: name,),transition: Transition.rightToLeft);
  }

  ///获取数据
  getResSong({required bool init}) async{
    if(mounted){
      setState(() {
        if(init){
          page=1;
          initRes=true;
          dataRes =true;
          total=0;
          songList.length=0;
        }
      });
      if(songList.length>=total && songList.isNotEmpty){
        EasyLoading.showToast("没有跟多了");
        return;
      }
      try{
        var recSong = await SearchService.getSearchResult(keywords:keyword.trim(), page: page,limit: 50,type: 1);
        if(recSong!=null ){
          if(recSong.result.songs!=null){
            total =recSong.result.songCount!;
            if(init){
              songList =recSong.result.songs!;

              CacheGlobalData.songTotal=total;
              widget.searchController.total.value=recSong.result.songCount!;
            }else{
              songList.addAll(recSong.result.songs!);
            }

            setState(() {
              initRes=false;
            });
          }
        }
      }catch(e){
        Global.logger.e(e);
      }

      dataRes =false;
    }

  }

  ///处理播放
  ///[index] 点击的索引
  void dealPayAllSong(int index) async{
    var playUrl = await ThisProjectUtils.getSongUrl(songList[index].id);
    if(playUrl==null){
      EasyLoading.showToast("该歌曲暂时无法播放");
      return;
    }

    AudioListController.recommendPlayId=-1;
    if(settingModel.playingList){
      startPlay(index: index,playUrl: playUrl);
    }else{
      AudioListController.playIndex=0;
      AudioListController.playList.length=0;
      AudioListController.playList.add(songList[index]);
      Global.getInstance()!.fire(AudioPlayEvent(playMs:0, playUrl:playUrl,showController:true,showAutoPlay:true));
      setState(() {
        downSong =songList[index];
      });
    }

  }

  ///播放全部
  void startPlay({int ? index,required String playUrl}) async{
    index ??=0;


    AudioListController.playIndex=index;
    AudioListController.playList.length=0;
    AudioListController.playList.addAll(songList);
    //去重
    final ids = AudioListController.playList.map((e) => e.id).toSet();
    AudioListController.playList.retainWhere((x) => ids.remove(x.id));


    Global.getInstance()!.fire(AudioPlayEvent(playMs:0, playUrl:playUrl,showController:true,showAutoPlay:true));
    setState(() {
      downSong =songList[index!];
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    stream.cancel();
    listen.cancel();
    scrollController.dispose();
  }
}
