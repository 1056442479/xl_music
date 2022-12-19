
import 'dart:async';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/controller/search_controller.dart';
import 'package:qq_music/model/event/event_model.dart';
import 'package:qq_music/model/user/song_user_model.dart';
import 'package:qq_music/page/song_user/song_user.dart';
import 'package:qq_music/service/search/search_service.dart';
import 'package:qq_music/utils/Global.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';


///歌手搜索结果页
class ResSongUserPage extends StatefulWidget {
  final SearchController searchController;
  const ResSongUserPage({Key? key,required this.searchController}) : super(key: key);

  @override
  State createState() => _MoreDealPageState();
}

class _MoreDealPageState extends State<ResSongUserPage> with AutomaticKeepAliveClientMixin{
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
  List<Artist> artistList =[];
  late StreamSubscription stream;


  @override
  void initState() {
    super.initState();
    keyword =CacheGlobalData.keyword;



    stream=  Global.getInstance()!.on<StartSearch>().listen((event) {
      if(keyword!=CacheGlobalData.keyword){
        keyword =CacheGlobalData.keyword;
        getResSongUserList(init: true);
      }
    });



    scrollController.addListener(() {
      if (scrollController.offset+150>= scrollController.position.maxScrollExtent) {
        if(dataRes==false){
          dataRes=true;
          debugPrint("滚动到底部bottom了...");
          page+=1;
          getResSongUserList(init: false,);
        }
      }
    });
    getResSongUserList(init: true);
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
          ):
          GridView.builder(
              controller: scrollController,
              itemCount: artistList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                /// 纵轴间距
                mainAxisSpacing: 20.0,
                /// 横轴间距
                crossAxisSpacing: 20.0,
                /// 横轴元素个数
                crossAxisCount: 4,
                /// 宽高比
                childAspectRatio: 0.9,
              ), itemBuilder: (context, index) {
            return InkWell(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: (){
                Get.to(()=>SongUser(id:  artistList[index].id, username: artistList[index].name ?? "佚名",),transition: Transition.rightToLeft);
              },
              child: LayoutBuilder(
                builder: (context , constraints ) {
                  return    Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SizedBox(
                            width:double.infinity,
                            height: constraints.biggest.height-50,
                            child:      ExtendedImage.network(
                              artistList[index].picUrl ?? CacheGlobalData.errorImg,
                              fit: BoxFit.fill,
                              cache: true,
                              width: constraints.biggest.width,
                              height: constraints.biggest.height-45,
                            )),
                      ),
                      const SizedBox(height: 20,),
                      Text( artistList[index].name ?? "佚名",style: const TextStyle(color: Colors.grey,fontSize: 14),textScaleFactor: 1,)
                    ],);
                },
              ),
            );
          })
      ),
    );
  }


  ///获取数据
  getResSongUserList({required bool init}) async{
    if(mounted){
      setState(() {
        if(init){
          page=1;
          initRes=true;
          dataRes =true;
          total=0;
          artistList.length=0;
        }
      });
      if(artistList.length>=total && artistList.isNotEmpty){
        EasyLoading.showToast("没有更多了");
        return;
      }
      try{
        var recSong = await SearchService.getSearchResult(keywords:keyword.trim(), page: page,limit: 50,type: 100);
        if(recSong!=null ){
          if(recSong.result.artists!=null){
            total =recSong.result.artistCount!;
            if(init){
              artistList =recSong.result.artists!;
              CacheGlobalData.artistCount=recSong.result.artistCount!;
              widget.searchController.total.value=recSong.result.artistCount!;

            }else{
              artistList.addAll(recSong.result.artists!);
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
