
import 'package:animate_do/animate_do.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qq_music/model/dj/dj_cateory.dart';
import 'package:qq_music/model/dj/dj_details.dart';
import 'package:qq_music/model/dj/dj_user_top.dart';
import 'package:qq_music/page/dj/dj_details_page.dart';
import 'package:qq_music/page/dj/dj_type_details.dart';
import 'package:qq_music/page/dj/dj_user_details.dart';
import 'package:qq_music/page/zai_xian_music/music_hall/dj/dj_user_sort.dart';
import 'package:qq_music/service/dj/dj_service.dart';
import 'package:styled_widget/styled_widget.dart';

import 'dj_top_list_detail.dart';

///有声电台，音乐馆中
class DjHall extends StatefulWidget {
  const DjHall({Key? key}) : super(key: key);

  @override
  _DjHallState createState() => _DjHallState();
}

class _DjHallState extends State<DjHall> with AutomaticKeepAliveClientMixin{
  ///个性推荐
  List<DjDetailsModel> recommendList =[];

  ///电台类型
  List<DjCateListModel> cateList =[];

  ///电台排行榜
  List<DjDetailsModel> topList =[];

  ///最热主播榜
  List<DjUserTopModel> topUserList =[];

  String type  ="hot";
  @override
  void initState() {
    super.initState();
    getDjRecommend();
    getDjGroup();
    getDjTopList(10);
    getDjUserPopularTop();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Material(
      color: const Color.fromRGBO(30, 30, 31, 1),
      child: Container(
        margin: const EdgeInsets.only(left: 20,right: 20),
        width: double.infinity,

        height: double.infinity,
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),

            ///分类
            SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: () {
                        Get.to(()=>DjTypeListDetails( titleName: cateList[index].name,id: cateList[index].id,)
                            ,transition: Transition.rightToLeft);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 10, top: 10),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Color.fromRGBO(34, 34, 35, 1)
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ExtendedImage.network(
                            cateList[index].pic96X96Url,
                            height: 30,
                            width: 30,
                          ),
                          Text(
                            cateList[index].name,
                            style:
                            const TextStyle(color: Color.fromRGBO(180, 180, 180, 1), fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  );
                }, childCount: cateList.length),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  /// 纵轴间距
                  mainAxisSpacing: 5,

                  /// 横轴间距
                  crossAxisSpacing: 5,

                  /// 横轴元素个数
                  crossAxisCount: 8,

                  /// 宽高比
                  childAspectRatio:1.3,
                )),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),


            ///推荐节目
             SliverToBoxAdapter(
              child:    Container(
                margin:const EdgeInsets.only(top: 20),
                child: const Text("推荐节目",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  /// 纵轴间距
                  mainAxisSpacing: 20.0,
                  /// 横轴间距
                  crossAxisSpacing: 10.0,
                  /// 横轴元素个数
                  crossAxisCount: 3,
                  /// 宽高比
                  childAspectRatio: 3,
                ),
                delegate:SliverChildBuilderDelegate((context, index) {
                  return FadeInLeft(
                    child: InkWell(
                      onTap: (){
                        Get.to(()=>DjDetailsPage(id: recommendList[index].id),transition: Transition.rightToLeft);
                      },
                      child:  Styled.widget(child: Container(
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(36, 36, 37, 1),
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        child: Row(
                          children: [
                            ExtendedImage.network(
                              recommendList[index].picUrl,
                              fit: BoxFit.fill,
                              cache: true,
                            ),
                            Expanded(child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(recommendList[index].name,style: const TextStyle(color: Colors.white,fontSize: 15),),
                                  const  SizedBox(height: 10,),

                                  Text("${ recommendList[index].copywriter}",style: const TextStyle(color: Colors.grey,fontSize: 13),maxLines: 2,overflow: TextOverflow.ellipsis,)
                                ],
                              ),
                            ))
                          ],
                        ),
                      )
                      ).decorated(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ).elevation(1).card(),
                    ),
                  );
                },childCount:recommendList.length>9?9:recommendList.length)),

            ///电台排行榜
            SliverToBoxAdapter(
              child:    Container(
                margin:const EdgeInsets.only(top: 40),
                child: StatefulBuilder(

                  builder: (BuildContext context, void Function(void Function()) setState) {
                    return Row(
                      children: [
                        const Text("电台排行榜",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                        TextButton(onPressed: (){
                          if(type!="hot"){
                            setState((){
                              type ='hot';
                            });
                            getDjTopList(10);
                          }
                        }, child:  Text("热门",style: TextStyle(color: type=="hot"? Colors.greenAccent:Colors.white,fontSize: 15),),),
                        TextButton(onPressed: (){
                          if(type!="new"){
                            setState((){
                              type ='new';
                            });
                            getDjTopList(10);
                          }
                        }, child:  Text("飙升",style: TextStyle(color: type=="new"? Colors.greenAccent:Colors.white,fontSize: 15),),),
                        Expanded(child: Container()),

                        InkWell(
                          onTap: (){
                              Get.to(()=>const DjTopListDetail(),transition: Transition.rightToLeft);
                          },
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          child: Row(
                            children: const [
                              Text("更多"),
                              Icon(Icons.keyboard_arrow_right,size: 20,color: Colors.grey,)
                            ],
                          ),
                        ),
                        const SizedBox(width: 30,)
                      ],
                    );
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  /// 纵轴间距
                  mainAxisSpacing: 20.0,
                  /// 横轴间距
                  crossAxisSpacing: 10.0,
                  /// 横轴元素个数
                  crossAxisCount: 5,
                  /// 宽高比
                  childAspectRatio: 0.9,
                ),
                delegate:SliverChildBuilderDelegate((context, index) {
                  return FadeInLeft(
                    child: InkWell(
                      onTap: (){
                        Get.to(()=>DjDetailsPage(id: topList[index].id),transition: Transition.rightToLeft);
                      },
                      child:  Styled.widget(child: Container(
                        decoration: const BoxDecoration(
//                          color: Color.fromRGBO(36, 36, 37, 1),
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        child: Column(
                          children: [
                            Expanded(child: ExtendedImage.network(
                              topList[index].picUrl,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              cache: true,
                            )),
                            const SizedBox(height: 10,),
                            Text(topList[index].name,style: const TextStyle(color: Colors.white,fontSize: 15),maxLines: 1,overflow: TextOverflow.ellipsis,),

                          ],
                        ),
                      )
                      )
                    ),
                  );
                },childCount:topList.length)),

            ///人气主播
            SliverToBoxAdapter(
              child:    Container(
                margin:const EdgeInsets.only(top: 40),
                child: StatefulBuilder(

                  builder: (BuildContext context, void Function(void Function()) setState) {
                    return Row(
                      children: [
                        const Text("人气主播",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                        Expanded(child: Container()),

                        InkWell(
                          onTap: (){
                              Get.to(()=>const DjUserSort(),transition: Transition.rightToLeft);
                          },
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          child: Row(
                            children: const [
                              Text("更多"),
                              Icon(Icons.keyboard_arrow_right,size: 20,color: Colors.grey,)
                            ],
                          ),
                        ),
                        const SizedBox(width: 30,)
                      ],
                    );
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  /// 纵轴间距
                  mainAxisSpacing: 20.0,
                  /// 横轴间距
                  crossAxisSpacing: 10.0,
                  /// 横轴元素个数
                  crossAxisCount: 5,
                  /// 宽高比
                  childAspectRatio: 1,
                ),
                delegate:SliverChildBuilderDelegate((context, index) {
                  return FadeInLeft(
                    child: InkWell(
                        onTap: (){
                          gotoPage( topUserList[index]);
                        },
                        child:  Styled.widget(child: Container(
                          decoration: const BoxDecoration(
//                          color: Color.fromRGBO(36, 36, 37, 1),
                              borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          child: Column(
                            children: [
                              Expanded(child: ExtendedImage.network(
                                topUserList[index].avatarUrl,
                                fit: BoxFit.cover,
                                cache: true,
                                shape: BoxShape.circle,
                              )),
                              const SizedBox(height: 10,),
                              Text(topUserList[index].nickName,style: const TextStyle(color: Colors.white,fontSize: 15),maxLines: 1,overflow: TextOverflow.ellipsis,),
                            ],
                          ),
                        )
                        )
                    ),
                  );
                },childCount:topUserList.length)),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///可获得推荐电台
  getDjRecommend() async{
    var topData = await DjService.getDjRecommend();
    if(topData!=null && topData.isNotEmpty){
      setState(() {
        recommendList =topData;
      });
    }
  }

  ///可获得电台类型
  getDjGroup() async{
    var topData = await DjService.getDjCateList();
    if(topData!=null && topData.isNotEmpty){
      setState(() {
        cateList =topData;
      });
    }
  }

  ///可获得新晋电台榜/热门电台榜
  getDjTopList(int limit) async{
    var topData = await DjService.getDjTopList(type: type,limit: limit);
    if(topData!=null && topData.isNotEmpty){
      setState(() {
        topList =topData;
      });
    }
  }
  ///说明 : 调用此接口,可获取最热主播榜
  getDjUserPopularTop() async{
    var topData = await DjService.getDjUserPopularTop(limit: 10);
    if(topData!=null && topData.isNotEmpty){
      setState(() {
        topUserList =topData;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;

  void gotoPage(DjUserTopModel topUserList) {

    Get.to(()=>DjUserDetailsPage(id: topUserList.id));

  }


}
