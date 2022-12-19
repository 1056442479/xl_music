

import 'package:animate_do/animate_do.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qq_music/model/top/top_sort.dart';
import 'package:qq_music/page/song_user/play_song_details.dart';
import 'package:qq_music/service/online_music/online_music_service.dart';
import 'package:styled_widget/styled_widget.dart';

class TopSortPage extends StatefulWidget {
  const TopSortPage({Key? key}) : super(key: key);

  @override
  _TopSortPageState createState() => _TopSortPageState();
}

class _TopSortPageState extends State<TopSortPage> with AutomaticKeepAliveClientMixin{

  List<TopSortModel> topList =[];
  List<TopSortModel> otherList =[];
  int topIndex =-1;
  @override
  void initState() {
    super.initState();
    getTopData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: const EdgeInsets.only(left: 20,right: 20),
      width: double.infinity,
      height: double.infinity,

      child: ListView(
        children: [
          Container(
             margin:const EdgeInsets.only(top: 20),
            child: const Text("官方榜",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
          ),
          ///官方榜单
          Container(
            margin:const EdgeInsets.only(top: 20),
            height: 380,
            width: double.infinity,
            child:  GridView.builder(
              shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: topList.length>4?4:topList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  /// 纵轴间距
                  mainAxisSpacing: 20.0,
                  /// 横轴间距
                  crossAxisSpacing: 30.0,
                  /// 横轴元素个数
                  crossAxisCount: 2,
                  /// 宽高比
                  childAspectRatio: 2.4,
                ),
                itemBuilder: (context, index) {
                  return LayoutBuilder(builder: (context,max){
                      return FadeInLeft(
                        child: InkWell(
                          onTap: (){
                            Get.to(()=> PlaySongDetailsPage(id: topList[index].id, picUrl: topList[index].coverImgUrl, name: topList[index].name ?? "佚名",
                            ),transition: Transition.rightToLeft);
                          },
                          child:  Styled.widget(child: Container(
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(36, 36, 37, 1),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                            child: Row(
                              children: [
                                Stack(
                                  children: [
                                    SizedBox(
                                        height: 150,
                                        width: 150,
                                        child: ExtendedImage.network(
                                          topList[index].coverImgUrl,
                                          fit: BoxFit.fill,
                                          cache: true,
                                        )),
//                                  Positioned(child:
//                                    Text("${ topList[index].subscribedCount}"),
//                                    right: 2,
//                                    bottom: 2,
//                                  )
                                  ],
                                ),

                                const SizedBox(width: 20,),
                                Expanded(child:   Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20,),
                                    Text("${topList[index].name}",style: const TextStyle(color: Colors.white,fontSize: 23,fontWeight: FontWeight.bold),),
                                    const SizedBox(height: 15,),
                                    Expanded(child:
                                    ListView.builder(itemBuilder: (contextSec,secondIndex){
                                      return Container(
                                        margin: const EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          children: [
                                            Text("${secondIndex+1}",style: const TextStyle(color: Colors.grey,fontSize: 13),),
                                            const SizedBox(width: 20,),
                                            Expanded(child:Text("${topList[index].tracks[secondIndex].first} - ${topList[index].tracks[secondIndex].second}"
                                              ,style: const TextStyle(color: Color.fromRGBO(145, 145, 145, 1),fontSize: 14,),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                            ),

                                          ],
                                        ),
                                      );
                                    },itemCount: topList[index].tracks.length,)
                                    )
                                  ],
                                )
                                )

                              ],
                            ),
                          )
                          ).decorated(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5),
                          ).elevation(1).card(),
                        ),
                      );
                  });
                })
          ),

          const   SizedBox(height: 10,),
          const Text("全球媒体榜",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
          ///全球媒体榜
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 20,),
            child: GridView.builder( shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
//                        padding: EdgeInsets.all(10.w),
                itemCount: otherList.length,
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
                      Get.to(()=> PlaySongDetailsPage(id: otherList[index].id, picUrl: otherList[index].coverImgUrl, name: otherList[index].name ?? "佚名",
                      ),transition: Transition.rightToLeft);
                    },
                    child: FadeIn(
                      child: LayoutBuilder(
                        builder: (context , constraints ) {
                          return    Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(child: SizedBox(
                                width:double.infinity,
                                child: Stack(
                                  children: [
                                    ExtendedImage.network(
                                      otherList[index].coverImgUrl,
                                      fit: BoxFit.fill,
                                    ),
                                    Positioned(
                                        right: 15,
                                        top: 5,
                                        child: Row(
                                          children: [
                                            const Icon(Icons.play_arrow_outlined,color: Colors.white,),
                                            const SizedBox(width: 5,),
                                            Text(otherList[index].subscribedCount >10000?"${ (otherList[index].subscribedCount/10000).truncate()}万":otherList[index].subscribedCount.toString() ,style:const TextStyle(
                                                color: Colors.white,fontSize: 13
                                            ),),
                                          ],
                                        )
                                    ),
                                  ],
                                ),
                              ))
                              ,
                              const SizedBox(height: 10,),
                              SizedBox(
                                height: 40,
                                child: Text(otherList[index].name ?? "",style: const TextStyle(color: Colors.white,fontSize: 15),textScaleFactor: 1,maxLines: 1,overflow: TextOverflow.ellipsis,),
                              )
                            ],);
                        },
                      ),
                    ),
                  );
                }),

          ),
        ],
      ),
    );
  }

  getTopData() async{
    var topData = await OnlineMusicService.getTopData();
    if(topData!=null && topData.isNotEmpty){
      setState(() {
        topList =topData;
        if(topList.length>4){
          for(var i=4;i<topList.length;i++){
            otherList.add(topList[i]);
          }
        }

      });
    }
  }

  @override
  bool get wantKeepAlive =>true;
}
