
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/model/mv/mv_details.dart';
import 'package:qq_music/page/mv/mv_all_page.dart';
import 'package:qq_music/service/mv/mv_service.dart';
import 'package:qq_music/utils/commutils.dart';

import '../../mv/mv_play_page.dart';

///每日新碟推荐
class EveryDayMv extends StatefulWidget {
  const EveryDayMv({Key? key}) : super(key: key);

  @override
  _EveryDayMvState createState() => _EveryDayMvState();
}

class _EveryDayMvState extends State<EveryDayMv> with AutomaticKeepAliveClientMixin{
  List<MvDetailsModel> mvList=[];

  @override
  void initState() {
    super.initState();
    getEveryDayMv();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         SizedBox(
            width: 150,
            child: InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: (){
                Get.to(()=>const MvAllPage(),transition: Transition.rightToLeft);
              },
              child: Row(
                children: const [
                  Text("推荐MV",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                  SizedBox(width: 5,),
                  Icon(Icons.keyboard_arrow_right,color: Colors.white,)
                ],
              ),
            ),
          ),
          Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 20,),
          child: GridView.builder( shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
//                        padding: EdgeInsets.all(10.w),
              itemCount: mvList.length>3?3:mvList.length,
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
                  onTap: (){
                    Get.to(()=>MvPlayPage(index:index , mvDetailsModelList: mvList,),transition: Transition.rightToLeft);
                  },
                  child: LayoutBuilder(
                    builder: (context , constraints ) {
                      return    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                  width:double.infinity,
                                  height: constraints.biggest.height-50,
                                  child:      ExtendedImage.network(
                                    mvList[index].picUrl ?? CacheGlobalData.errorImg,
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
                                            ? "${(mvList[index].playCount / 10000).truncate()}万"
                                            : mvList[index].playCount.toString(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 13),
                                      ),
                                    ],
                                  )),
                              Positioned(
                                right: 5,
                                bottom: 5,
                                child: Text(
                                  CommUtils.formatMinSec(mvList[index].duration),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10,),
                          SizedBox(
                            height: 40,
                            child: Text(mvList[index].name,style: const TextStyle(color: Colors.white,fontSize: 15),textScaleFactor: 1,),
                          )
                        ],);
                    },
                  ),
                );
              }),

        ),
        ],
      ),
    );
  }


  ///获取每日推荐的mv
  getEveryDayMv() async{
      var getList = await MvService.getMvPerRecommend();
      if(getList!=null){
        setState(() {
          mvList =getList;
        });
      }
  }

  @override
  bool get wantKeepAlive => true;

}
