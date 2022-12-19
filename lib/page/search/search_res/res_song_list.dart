
import 'dart:async';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/controller/search_controller.dart';
import 'package:qq_music/model/event/event_model.dart';
import 'package:qq_music/page/song_user/play_song_details.dart';
import 'package:qq_music/service/search/search_service.dart';
import 'package:qq_music/utils/Global.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import '../../../model/search_key/search_key.dart';

///歌单搜索结果页
class ResSongPlayPage extends StatefulWidget {
  final SearchController searchController;
  const ResSongPlayPage({Key? key,required this.searchController}) : super(key: key);

  @override
  State createState() => _MoreDealPageState();
}

class _MoreDealPageState extends State<ResSongPlayPage> with AutomaticKeepAliveClientMixin{
  bool addList =false;
  bool play =false;
  int total =0;
  int page =1;
  ///请求是否结束
  bool dataRes=false;
  ///是否初始请求
  bool initRes =true;
  String keyword="";

  ScrollController scrollController =ScrollController();
  List<SongPlayDetailsSearch> playList =[];
  late StreamSubscription stream;


  @override
  void initState() {
    super.initState();
    keyword =CacheGlobalData.keyword;




    stream=  Global.getInstance()!.on<StartSearch>().listen((event) {
      if(keyword!=CacheGlobalData.keyword){
        keyword =CacheGlobalData.keyword;
        getResSong(init: true);
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
        margin:const EdgeInsets.only(left: 20,right: 20,top: 20),
        child: initRes? const Center(
            child: SleekCircularSlider(
                appearance: CircularSliderAppearance(
                  spinnerMode: true,
                ))
        ): ListView.builder(itemBuilder: (context, index) {
          return InkWell(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor:Colors.transparent,
            onTap: (){
              Get.to(()=>PlaySongDetailsPage(id: playList[index].id, picUrl: playList[index].coverImgUrl, name:  playList[index].name,
              ),transition: Transition.rightToLeft);
            },
            child: Container(
              margin:const EdgeInsets.only(bottom: 20),
              height: 70,
              color: const Color.fromRGBO(36, 36, 37, 1),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(5),
                          child: ExtendedImage.network(
                            playList[index].coverImgUrl,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(child:   Container(
                          margin: const EdgeInsets.only(left: 15),
                          constraints: const BoxConstraints(
                              maxWidth: 300,
                              minWidth: 100
                          ),
                          child: Text(playList[index].name,style: const TextStyle(color: Colors.white,fontSize: 14),maxLines: 1,overflow: TextOverflow.ellipsis,),
                        ),)
                      ],
                    ),
                  ),


                  Expanded(flex: 1,child: Container(),),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.only(right: 30),
                      alignment: Alignment.centerLeft,
                      child:  Text(playList[index].trackCount >10000?"收听${ (playList[index].trackCount/10000).truncate()}万":"收听${playList[index].trackCount}" ,style:const TextStyle(
                          color: Colors.white,fontSize: 13
                      ),),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.only(right: 30),
                      alignment: Alignment.centerLeft,
                      child:  Text(playList[index].bookCount >10000?"收藏${ (playList[index].bookCount/10000).truncate()}万":"收藏${playList[index].bookCount}" ,style:const TextStyle(
                          color: Colors.white,fontSize: 13
                      ),),
                    ),
                  )
                ],
              ),
            ),
          );
        },itemCount: playList.length,shrinkWrap: true,),
      ),
    );
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
          playList.length=0;
        }
      });
      if(playList.length>=total && playList.isNotEmpty){
        EasyLoading.showToast("没有更多了");
        return;
      }
      try{
        var recSong = await SearchService.getSearchResult(keywords:keyword.trim(), page: page,limit: 50,type: 1000);
        if(recSong!=null ){
          if(recSong.result.playlists!=null){
            total =recSong.result.playlistCount!;
            if(init){
              playList =recSong.result.playlists!;
              CacheGlobalData.playlistCount=total;
              widget.searchController.total.value=recSong.result.playlistCount!;
            }else{
              playList.addAll(recSong.result.playlists!);
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



  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    stream.cancel();
    scrollController.dispose();
  }
}
