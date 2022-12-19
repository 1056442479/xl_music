

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/model/mv/mv_details.dart';
import 'package:qq_music/model/mv/mv_top_model.dart';
import 'package:qq_music/page/mv/mv_play_page.dart';
import 'package:qq_music/service/mv/mv_service.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../mv/mv_all_page.dart';

class VideoRecommend extends StatefulWidget {
  const VideoRecommend({Key? key}) : super(key: key);

  @override
  _VideoRecommendState createState() => _VideoRecommendState();
}

class _VideoRecommendState extends State<VideoRecommend> with AutomaticKeepAliveClientMixin{

  ///最新mv
  List<MvDetailsModel> recList =[];
  ///网易出品mv
  List<MvDetailsModel> wyList =[];
  ///独家mv
  List<MvTopModel> topList =[];
  String area ="内地";
  List<String> areaList =["内地","港台","欧美","日本","韩国"];

  @override
  void initState() {
    super.initState();
    getFirstMvList();
    getExclusiveMvList();
    getTopMvList();
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Material(
      color:const Color.fromRGBO(30, 30, 30, 1),
      child: Container(
        margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
        child: ListView(
          children: [

            ///最新mv
            SizedBox(
              width: 200,
              height: 60,
              child: Row(
                children:  [
                  InkWell(
                    onTap: (){
                      Get.to(()=>const MvAllPage(),transition: Transition.rightToLeft);
                    },
                    child: Row(
                      children: const [
                        Text("最新MV",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                        SizedBox(width: 5,),
                        Icon(Icons.keyboard_arrow_right,color: Colors.white,),
                      ],
                    ),
                  ),
                  Expanded(child: Container()),

                  ListView.builder(scrollDirection: Axis.horizontal,shrinkWrap: true,itemBuilder: (context, index) {
                    return StatefulBuilder(
                      builder: (BuildContext context, void Function(void Function()) setState) {
                        return TextButton(onPressed: (){
                          if(area!=areaList[index]) {
                            setState((){
                                 area =areaList[index];
                                 getFirstMvList();
                               });
                          }
                        }, child: Text(areaList[index],style: TextStyle(color: area==areaList[index]?Colors.greenAccent:Colors.white,fontSize: 13),
                          selectionColor: Colors.transparent,));
                      },
                    );
                  },itemCount: areaList.length,)
                ],
              ),
            ),
            Container(
              height: 450,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 20,),
              child: GridView.builder( shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
//                        padding: EdgeInsets.all(10.w),
                  itemCount: recList.length>6?6: recList.length,
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
                        Get.to(()=>MvPlayPage(index:index , mvDetailsModelList: recList,mvId: recList[index].id,),transition: Transition.rightToLeft);
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
                                         recList[index].cover ?? CacheGlobalData.errorImg,
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
                                             recList[index].playCount > 10000
                                                ? "${( recList[index].playCount / 10000).truncate()}万"
                                                :  recList[index].playCount.toString(),
                                            style: const TextStyle(
                                                color: Colors.white, fontSize: 13),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                              const SizedBox(height: 10,),
                              TextScroll( recList[index].name,style: const TextStyle(color: Colors.white,fontSize: 15),selectable: true,),
                              Text( recList[index].artistName,style: const TextStyle(color: Colors.grey,fontSize: 12),textScaleFactor: 1,)
                            ],);
                        },
                      ),
                    );
                  }),

            ),

            ///网易出品
            Container(
              width: 100,
              height: 60,
              margin: const EdgeInsets.only(top: 20),
              child: InkWell(

                onTap: (){
                  Get.to(()=>const MvAllPage(),transition: Transition.rightToLeft);
                },
                child: Row(
                  children:  const [
                    Text("网易出品",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                    SizedBox(width: 5,),
                    Icon(Icons.keyboard_arrow_right,color: Colors.white,),
                  ],
                ),
              ),
            ),
            Container(
              height: 450,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 10,),
              child: GridView.builder( shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
//                        padding: EdgeInsets.all(10.w),
                  itemCount: wyList.length>6?6: wyList.length,
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
                        Get.to(()=>MvPlayPage(index:index , mvDetailsModelList: wyList,mvId: wyList[index].id,),transition: Transition.rightToLeft);
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
                                        wyList[index].cover ?? CacheGlobalData.errorImg,
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
                                            wyList[index].playCount > 10000
                                                ? "${( wyList[index].playCount / 10000).truncate()}万"
                                                :  wyList[index].playCount.toString(),
                                            style: const TextStyle(
                                                color: Colors.white, fontSize: 13),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                              const SizedBox(height: 10,),
                              TextScroll( wyList[index].name,style: const TextStyle(color: Colors.white,fontSize: 15),selectable: true,),
                              Text( wyList[index].artistName,style: const TextStyle(color: Colors.grey,fontSize: 12),textScaleFactor: 1,)
                            ],);
                        },
                      ),
                    );
                  }),

            ),

            ///热播MV
            Container(
              width: 100,
              height: 60,
              margin: const EdgeInsets.only(top: 20),
              child: InkWell(
                onTap: (){
                  Get.to(()=>const MvAllPage(),transition: Transition.rightToLeft);
                },
                child: Row(
                  children:  [
                    const   Text("热播MV",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                    const  SizedBox(width: 5,),
                    const  Icon(Icons.keyboard_arrow_right,color: Colors.white,),
                    Expanded(child: Container()),
                  ],
                ),
              ),
            ),
            Container(
              height: 450,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 10,),
              child: GridView.builder( shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
//                        padding: EdgeInsets.all(10.w),
                  itemCount:  topList.length>6?6:  topList.length,
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
                        Get.to(()=>MvPlayPage(index:index , mvDetailsModelList: const [],mvId:  topList[index].id,),transition: Transition.rightToLeft);
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
                                        topList[index].cover,
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
                                            topList[index].playCount > 10000
                                                ? "${( topList[index].playCount / 10000).truncate()}万"
                                                :  topList[index].playCount.toString(),
                                            style: const TextStyle(
                                                color: Colors.white, fontSize: 13),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                              const SizedBox(height: 10,),
                              TextScroll( topList[index].name,style: const TextStyle(color: Colors.white,fontSize: 15),selectable: true,),
                              Text( topList[index].artistName,style: const TextStyle(color: Colors.grey,fontSize: 12),textScaleFactor: 1,)
                            ],);
                        },
                      ),
                    );
                  }),

            ),
          ],
        ),
      ),
    );
  }

  ///推荐mv
  getFirstMvList() async{
    var firstMvList =await MvService.getFirstMvList(area: area);
    if(firstMvList!=null){
      setState(() {
        recList= firstMvList;
      });
    }
  }

  ///网易出品
  getExclusiveMvList() async{
    var firstMvList =await MvService.getExclusiveMvList(page: 1,limit: 6);
    if(firstMvList!=null){
      setState(() {
        wyList= firstMvList;
      });
    }
  }

  ///独家
  getTopMvList() async{
    var firstMvList =await MvService.getTopMvList(page: 1,limit: 6);
    if(firstMvList!=null){
      setState(() {
        topList= firstMvList;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}

