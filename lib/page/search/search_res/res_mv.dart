
import 'dart:async';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/controller/search_controller.dart';
import 'package:qq_music/model/event/event_model.dart';
import 'package:qq_music/model/mv/mv_details.dart';
import 'package:qq_music/page/mv/mv_play_page.dart';
import 'package:qq_music/service/search/search_service.dart';
import 'package:qq_music/utils/Global.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:text_scroll/text_scroll.dart';

///MV搜索结果页
class ResMvPage extends StatefulWidget {
  final SearchController searchController;
  const ResMvPage({Key? key,required this.searchController}) : super(key: key);

  @override
  State createState() => _MoreDealPageState();
}

class _MoreDealPageState extends State<ResMvPage> with AutomaticKeepAliveClientMixin{
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
  List<MvDetailsModel> mvList =[];
  late StreamSubscription stream;


  @override
  void initState() {
    super.initState();
    keyword = CacheGlobalData.keyword;



    stream=  Global.getInstance()!.on<StartSearch>().listen((event) {
      if(keyword!=CacheGlobalData.keyword){
        keyword =CacheGlobalData.keyword;
        getResMv(init: true);
      }
    });


    scrollController.addListener(() {
      if (scrollController.offset+150>= scrollController.position.maxScrollExtent) {
        if(dataRes==false){
          dataRes=true;
          debugPrint("滚动到底部bottom了...");
          page+=1;
          getResMv(init: false,);
        }
      }
    });
    getResMv(init: true);
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
            itemCount: mvList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              /// 纵轴间距
              mainAxisSpacing: 20.0,
              /// 横轴间距
              crossAxisSpacing: 7.0,
              /// 横轴元素个数
              crossAxisCount: 3,
              /// 宽高比
              childAspectRatio: 1.4,
            ), itemBuilder: (context, index) {
              return InkWell(
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: (){
                  Get.to(()=>MvPlayPage(index:index , mvDetailsModelList: mvList),transition: Transition.rightToLeft);
                },
                child: LayoutBuilder(
                  builder: (context , constraints ) {
                    return    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                                width:double.infinity,
                                height: constraints.biggest.height-50,
                                child:      ExtendedImage.network(
                                  mvList[index].cover ?? CacheGlobalData.errorImg,
                                  fit: BoxFit.fill,
                                  cache: true,
                                  width: constraints.biggest.width,
                                  height: constraints.biggest.height-45,
                                )),
                            Positioned(
                                right: 15,
                                top: 5,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.play_arrow_outlined,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      mvList[index].playCount > 10000
                                          ? "${( mvList[index].playCount / 10000).truncate()}万"
                                          :  mvList[index].playCount.toString(),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 13),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                        const SizedBox(height: 10,),
                        TextScroll( mvList[index].name,style: const TextStyle(color: Colors.white,fontSize: 15),selectable: true,),
                        Text( mvList[index].artistName,style: const TextStyle(color: Colors.grey,fontSize: 12),textScaleFactor: 1,)
                      ],);
                  },
                ),
              );
            })
      ),
    );
  }


  ///获取数据
  getResMv({required bool init}) async{
    if(mounted){
      setState(() {
        if(init){
          page=1;
          initRes=true;
          dataRes =true;
          total=0;
          mvList.length=0;
        }
      });
      if(mvList.length>=total && mvList.isNotEmpty){
        EasyLoading.showToast("没有更多了");
        return;
      }
      try{
        var recSong = await SearchService.getSearchResult(keywords:keyword.trim(), page: page,limit: 50,type: 1004);
        if(recSong!=null ){
          if(recSong.result.mvs!=null){
            total =recSong.result.mvCount!;
            if(init){
              mvList =recSong.result.mvs!;
              CacheGlobalData.mvTotal=recSong.result.mvCount!;
              widget.searchController.total.value=recSong.result.mvCount!;

            }else{
              mvList.addAll(recSong.result.mvs!);
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
