
import 'package:animate_do/animate_do.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qq_music/model/dj/dj_details.dart';
import 'package:qq_music/page/dj/dj_details_page.dart';
import 'package:qq_music/service/dj/dj_service.dart';
import 'package:styled_widget/styled_widget.dart';

///音乐馆电台排行榜
class DjTopListDetail extends StatefulWidget {
  const DjTopListDetail({Key? key}) : super(key: key);

  @override
  _DjUserSortState createState() => _DjUserSortState();
}

class _DjUserSortState extends State<DjTopListDetail> {

  ///热门电台排行榜
  List<DjDetailsModel> hotTopList =[];
  ///飙升电台排行榜
  List<DjDetailsModel> newTopList =[];

  String type  ="hot";

  @override
  void initState() {
    super.initState();
    getDjTopList(100);
  }
  @override
  Widget build(BuildContext context) {
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
            const SliverToBoxAdapter(
              child: SizedBox(
                child:    Text("电台排行榜",style: TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold),),
              ),
            ),

            ///电台排行榜
            SliverToBoxAdapter(
              child:    Container(
                margin:const EdgeInsets.only(top: 20),
                child: StatefulBuilder(

                  builder: (BuildContext context, void Function(void Function()) setState) {
                    return Row(
                      children: [
                        TextButton(onPressed: (){
                          if(type!="hot"){
                            setState((){
                              type ='hot';
                            });
                            getDjTopList(100);
                          }
                        }, child:  Text("热门",style: TextStyle(color: type=="hot"? Colors.greenAccent:Colors.white,fontSize: 15),),),
                        TextButton(onPressed: (){
                          if(type!="new"){
                            setState((){
                              type ='new';
                            });
                            getDjTopList(100);
                          }
                        }, child:  Text("飙升",style: TextStyle(color: type=="new"? Colors.greenAccent:Colors.white,fontSize: 15),),),
                        Expanded(child: Container()),
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
                          Get.to(()=>DjDetailsPage(id:type=="hot"? hotTopList[index].id:newTopList[index].id,));
//                          Get.to(()=>DjDetailsPage(id:type=="hot"? hotTopList[index].id:newTopList[index].id,
//                            username:  type=="hot"? hotTopList[index].dj.nickname:newTopList[index].dj
//                                .nickname, createTime:  type=="hot"? hotTopList[index].createTime:newTopList[index].createTime, name:  type=="hot"? hotTopList[index].name:newTopList[index].name
//                            , picUrl: type=="hot"? hotTopList[index].picUrl:newTopList[index].picUrl,
//                            uid: type=="hot"? hotTopList[index].dj.userId:newTopList[index].dj
//                                .userId,));
                        },
                        child:  Styled.widget(child: Container(
                          decoration: const BoxDecoration(
//                          color: Color.fromRGBO(36, 36, 37, 1),
                              borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          child: Column(
                            children: [
                              Expanded(child: ExtendedImage.network(
                               type=="hot"? hotTopList[index].picUrl:newTopList[index].picUrl,
                                fit: BoxFit.cover,
                                cache: true,
                                shape: BoxShape.circle,
                              )),
                              const SizedBox(height: 10,),
                              Text(  type=="hot"? hotTopList[index].name:newTopList[index].name,style: const TextStyle(color: Colors.white,fontSize: 15),maxLines: 1,overflow: TextOverflow.ellipsis,),
                            ],
                          ),
                        )
                        )
                    ),
                  );
                },childCount:type=="hot"?hotTopList.length:newTopList.length)),
          ],
        ),
      ),
    );
  }


  ///可获得新晋电台榜/热门电台榜
  getDjTopList(int limit) async{
    if(type=="hot" && hotTopList.isNotEmpty){
      setState(() {
          hotTopList;
      });
      return;
    }
    if(type=="new" && newTopList.isNotEmpty){
      setState(() {
        newTopList;
      });
      return;
    }
    var topData = await DjService.getDjTopList(type: type,limit: limit);
    if(topData!=null && topData.isNotEmpty){
          if(type=="hot"){
            hotTopList =topData;
          }else{
            newTopList =topData;
          }
    }
    setState(() {

    });
  }

}
