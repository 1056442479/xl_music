

import 'package:animate_do/animate_do.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qq_music/model/dj/dj_details.dart';
import 'package:qq_music/model/dj/dj_user_top.dart';
import 'package:qq_music/page/dj/dj_details_page.dart';
import 'package:qq_music/page/dj/dj_user_details.dart';
import 'package:qq_music/page/zai_xian_music/music_hall/dj/dj_hall.dart';
import 'package:qq_music/page/zai_xian_music/music_hall/jing_xuan/jin_banner.dart';
import 'package:qq_music/service/dj/dj_service.dart';
import 'package:styled_widget/styled_widget.dart';

///精选页面
class SelectPage extends StatefulWidget {
  const SelectPage({Key? key}) : super(key: key);

  @override
  _SelectPageState createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> with AutomaticKeepAliveClientMixin{

  ///电台个性推荐
  List<DjDetailsModel> personalizeRecommendList =[];
  ///新人主播榜
  List<DjUserTopModel> topUserList =[];
  
  
  @override
  void initState() {
    super.initState();
    getDjPersonalizeRecommend();
    getDjUserNewTop();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: const EdgeInsets.only(left: 20,right: 20),
      child: ListView(
        children:  [
          const SelectBannerPage(),
          ///个性电台
          Container(
            margin:const EdgeInsets.only(top: 30),
            child: StatefulBuilder(
              builder: (BuildContext context, void Function(void Function()) setState) {
                return Row(
                  children: [
                    const Text("个性电台",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                    Expanded(child: Container()),
                    InkWell(
                      onTap: (){
                        Get.to(()=>const DjHall(),transition: Transition.rightToLeft);
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
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 20,),
            child: GridView.builder( shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
//                        padding: EdgeInsets.all(10.w),
                itemCount: personalizeRecommendList.length,
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
                      Get.to(()=>DjDetailsPage(id: personalizeRecommendList[index].id
                      ));
//                      Get.to(()=>DjDetailsPage(id: personalizeRecommendList[index].id, picUrl: personalizeRecommendList[index].picUrl, name: personalizeRecommendList[index].name,
//                        createTime:  personalizeRecommendList[index].createTime,username:  personalizeRecommendList[index].dj.nickname,
//                        uid: personalizeRecommendList[index].dj.userId,detailsModel: personalizeRecommendList[index],
//                      ));
                    },
                    child: LayoutBuilder(
                      builder: (context , constraints ) {
                        return    Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width:double.infinity,
                              height: constraints.biggest.height-50,
                              child: Stack(
                                children: [
                                  Image(image: NetworkImage(personalizeRecommendList[index].picUrl),fit: BoxFit.fill,height: constraints.biggest.height-45,),
                                  Positioned(
                                      right: 15,
                                      top: 5,
                                      child: Row(
                                        children: [
                                          const Icon(Icons.play_arrow_outlined,color: Colors.white,),
                                          const SizedBox(width: 5,),
                                          Text(personalizeRecommendList[index].subCount >10000?"${ (personalizeRecommendList[index].subCount/10000).truncate()}万":personalizeRecommendList[index].subCount.toString() ,style:const TextStyle(
                                              color: Colors.white,fontSize: 13
                                          ),),
                                        ],
                                      )
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10,),
                            SizedBox(
                              height: 40,
                              child: Text(personalizeRecommendList[index].name,style: const TextStyle(color: Colors.white,fontSize: 15),textScaleFactor: 1,),
                            )
                          ],);
                      },
                    ),
                  );
                }),

          ),

          ///主播新人榜
          Container(
            margin:const EdgeInsets.only(top: 30),
            child: StatefulBuilder(
              builder: (BuildContext context, void Function(void Function()) setState) {
                return const Text("新人主播",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),);

              },
            ),
          ),
          Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 20,),
        child:      GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          /// 纵轴间距
          mainAxisSpacing: 25,
          /// 横轴间距
          crossAxisSpacing: 20,
          /// 横轴元素个数
          crossAxisCount: 4,
          /// 宽高比
          childAspectRatio: 1.2,
        ),
          itemBuilder: (context, index) {
            return FadeInLeft(
              child: InkWell(
                  onTap: (){
                    Get.to(()=>DjUserDetailsPage(id: topUserList[index].id,));
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
          }, itemCount: topUserList.length,shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),),
      )
     

        ],
      ),
    );
  }

  ///可获取电台个性推荐列表
  getDjPersonalizeRecommend() async{
    var djPersonalizeRecommend =await DjService.getDjPersonalizeRecommend(limit: 5);
    if(djPersonalizeRecommend!=null){
      setState(() {
        personalizeRecommendList =djPersonalizeRecommend;
      });
    }
  }

  ///可获取主播新人榜
  getDjUserNewTop() async{
    var djPersonalizeRecommend =await DjService.getDjUserNewTop(limit: 8);
    if(djPersonalizeRecommend!=null){
      setState(() {
        topUserList =djPersonalizeRecommend;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}
