
import 'dart:async';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/controller/search_controller.dart';
import 'package:qq_music/model/album/album_model.dart';
import 'package:qq_music/model/event/event_model.dart';
import 'package:qq_music/page/song_user/album_details_page.dart';
import 'package:qq_music/page/song_user/song_user.dart';
import 'package:qq_music/service/search/search_service.dart';
import 'package:qq_music/utils/Global.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

///专辑搜索结果页
class ResAlbumPage extends StatefulWidget {
  final SearchController searchController;
  const ResAlbumPage({Key? key,required this.searchController}) : super(key: key);

  @override
  State createState() => _MoreDealPageState();
}

class _MoreDealPageState extends State<ResAlbumPage> with AutomaticKeepAliveClientMixin{
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
  List<AlbumDetailsModel> albumList =[];
  late StreamSubscription stream;


  @override
  void initState() {
    super.initState();
    keyword =CacheGlobalData.keyword;



    stream=  Global.getInstance()!.on<StartSearch>().listen((event) {
      if(keyword!=CacheGlobalData.keyword){
        keyword =CacheGlobalData.keyword;
        getAlbumList(init: true);
      }
    });


    scrollController.addListener(() {
      if (scrollController.offset+150>= scrollController.position.maxScrollExtent) {
        if(dataRes==false){
          dataRes=true;
          debugPrint("滚动到底部bottom了...");
          page+=1;
          getAlbumList(init: false,);
        }
      }
    });
    getAlbumList(init: true);
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
        ): GridView.builder(
            controller: scrollController,
            itemCount: albumList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              /// 纵轴间距
              mainAxisSpacing: 20.0,
              /// 横轴间距
              crossAxisSpacing: 7.0,
              /// 横轴元素个数
              crossAxisCount: 5,
              /// 宽高比
              childAspectRatio: 0.8,
            ), itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              Get.to(()=>AlbumDetailsPage(id:albumList[index]. id, username: albumList[index].artist?.name ?? "佚名",
                  createTime: albumList[index].publishTime, name:  albumList[index].name,
                  picUrl: albumList[index].picUrl, uid: albumList[index].artist?.id ?? 0),transition: Transition.rightToLeft);
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
                          albumList[index].picUrl,
                          fit: BoxFit.fill,
                          cache: true,
                          width: constraints.biggest.width,
                          height: constraints.biggest.height-45,
                        )),

                    const SizedBox(height: 10,),
                    SizedBox(
                      height: 40,
                      child: Text(albumList[index].name,style: const TextStyle(color: Colors.white,fontSize: 15),textScaleFactor: 1,),
                    )
                  ],);
              },
            ),
          );
        })
      ),
    );
  }


  ///去往歌手页面
  void goToSongUser(int id,String name) {
    Get.to(()=> SongUser(id: id,username: name,),transition: Transition.rightToLeft);
  }

  ///获取数据
  getAlbumList({required bool init}) async{
    if(mounted){
      setState(() {
        if(init){
          page=1;
          initRes=true;
          dataRes =true;
          total=0;
          albumList.length=0;
        }
      });
      if(albumList.length>=total && albumList.isNotEmpty){
        EasyLoading.showToast("没有跟多了");
        return;
      }
      try{
        var recSong = await SearchService.getSearchResult(keywords:keyword.trim(), page: page,limit: 50,type: 10);
        if(recSong!=null ){
          if(recSong.result.albums!=null){
            total =recSong.result.albumCount!;
            if(init){
              albumList =recSong.result.albums!;

              CacheGlobalData.albumsTotal=total;
              widget.searchController.total.value=recSong.result.albumCount!;
            }else{
              albumList.addAll(recSong.result.albums!);
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
