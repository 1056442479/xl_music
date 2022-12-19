

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bruno/bruno.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qq_music/model/mv/mv_top_model.dart';
import 'package:qq_music/page/mv/mv_play_page.dart';
import 'package:qq_music/page/song_user/song_user.dart';
import 'package:qq_music/service/mv/mv_service.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class  VideoSortPage extends StatefulWidget {
  const  VideoSortPage({Key? key}) : super(key: key);

  @override
  _VideoRecommendState createState() => _VideoRecommendState();
}

class _VideoRecommendState extends State< VideoSortPage> with TickerProviderStateMixin,AutomaticKeepAliveClientMixin{

  List<MvTopModel> topList =[];
  bool dataRes =false;
 
  ///地区选择
  String ? area;
  List<BadgeTab> tabs =[
    BadgeTab(text: "总榜"),
    BadgeTab(text: "内地"),
    BadgeTab(text: "港台"),
    BadgeTab(text: "欧美"),
    BadgeTab(text: "日本"),
    BadgeTab(text: "韩国"),
  ];
  late TabController tabController ;

  @override
  void initState() {
    super.initState();
    getTopMvList(init: true);

    tabController =TabController(length: tabs.length, vsync: this);
 
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Material(
      color:const Color.fromRGBO(30, 30, 30, 1),
      child: Container(
        margin: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30,),
            const Text("MV排行榜",style: TextStyle(color: Colors.white,fontSize: 35),),
            const SizedBox(height: 20,),
            Expanded(child:
            dataRes?
            const Center(
                child: SleekCircularSlider(
                    appearance: CircularSliderAppearance(
                      spinnerMode: true,
                    ))
            )
                :  CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child:  BrnTabBar(
                      backgroundcolor: Colors.transparent,
                      unselectedLabelColor: Colors.grey,
                      tabWidth:60,
                      unselectedLabelStyle: const TextStyle(fontSize: 15),
                      indicatorColor: Colors.greenAccent,
                      indicatorWeight:2,
                      controller: tabController,
                      labelColor:Colors.greenAccent,
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                      tabs: tabs,
                      onTap: (state, index) {
                        if(area!=tabs[index].text){
                          if(index==0){
                            area=null;
                          }else{
                            area =tabs[index].text;
                          }
                          tabController.index=index;
                          getTopMvList(init: true);
                        }
                      },
                    ),
                  ),
                  SliverList(delegate:
                    SliverChildBuilderDelegate((context, index) {
                      return Container(
                        height: 80,
                        margin:const EdgeInsets.only(left: 30,top: 15),
                        child: Row(
                          children: [
                            Text("${index+1}",style: TextStyle(color:index<3? Colors.greenAccent:Colors.white,fontSize: 14),),
                            const SizedBox(width: 60,),
                            InkWell(
                              onTap: (){
                                Get.to(()=>MvPlayPage(index:index , mvDetailsModelList: const [],mvId: topList[index].id,),transition: Transition.rightToLeft);
                              },
                              child: ExtendedImage.network(
                                topList[index].cover,
                                fit: BoxFit.fill,
                                width: 160,
                                height: double.infinity,
                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                                cache: true,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              constraints:const BoxConstraints(
                                minWidth: 100,
                                maxWidth: 500,
                                maxHeight: 150
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(child: AutoSizeText(topList[index].name,style: const TextStyle(color:Colors.white,fontSize: 16),minFontSize: 11,maxLines: 1,overflow: TextOverflow.ellipsis,),
                                    onTap: (){
                                      Get.to(()=>MvPlayPage(index:index , mvDetailsModelList: const [],mvId: topList[index].id,),transition: Transition.rightToLeft);
                                    },
                                  ),
                                  const SizedBox(height: 15,),
                                  InkWell(child: Text(topList[index].artistName,style: const TextStyle(color:Colors.grey,fontSize: 13),),onTap: (){
//                                    var mv = mvDetailsModelList[playListIndex>=mvDetailsModelList.length?mvDetailsModelList.length-1:playListIndex];
                                    Get.to(SongUser(id:topList[index].artistId, username:topList[index].artistName));
                                  },),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },childCount: topList.length)
                  )
                ],
              )
            )

          ],
        ),
      ),
    );
  }

  getTopMvList( {required bool init}) async{

    if(init){
      setState(() {
        dataRes=true;
        topList.length=0;
      });
    }
    var allMvList = await MvService.getTopMvList(page: 1,area: area,limit: 50);
    if(allMvList!=null){
      topList.addAll(allMvList);
    }
    setState(() {
      dataRes=false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

