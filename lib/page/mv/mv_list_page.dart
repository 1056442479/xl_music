

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bruno/bruno.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/model/mv/mv_details.dart';
import 'package:qq_music/page/mv/mv_play_page.dart';
import 'package:qq_music/service/mv/mv_service.dart';
import 'package:qq_music/utils/commutils.dart';
import 'package:qq_music/utils/my_widget/CusBehavior.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class MvListPage extends StatefulWidget {
  final int id;
  final int ? mvSize;
  const MvListPage({Key? key,required this.id,this.mvSize}) : super(key: key);

  @override
  _AlbumPageState createState() => _AlbumPageState();
}

class _AlbumPageState extends State<MvListPage> with AutomaticKeepAliveClientMixin{

  List<MvDetailsModel> mvList =[];

  @override
  Widget build(BuildContext context) {
    super.build(context);


    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child:   MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: FutureBuilder(
            future:   getMvListListDetails(widget.id),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snap) {
              if (snap.connectionState == ConnectionState.done) {
                if (snap.hasError) {
                  return Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: BrnAbnormalStateWidget(
                      bgColor: Colors.transparent,
                      isCenterVertical: true,
                      themeData:BrnAbnormalStateConfig(
                          titleTextStyle:BrnTextStyle(color: Colors.red,fontSize: 18)
                      ),
                      title: "数据出错",
                    ),
                  );
                }
                return  mvList.isEmpty?const Center(child: Text("数据为空",style: TextStyle(color: Colors.white),),):  ScrollConfiguration(
                  behavior: CusBehavior(),
                  child: GridView.builder( shrinkWrap: false,
                      itemCount: mvList.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        /// 纵轴间距
                        mainAxisSpacing: 20.0,
                        /// 横轴间距
                        crossAxisSpacing: 30.0,
                        /// 横轴元素个数
                        crossAxisCount: 4,
                        /// 宽高比
                        childAspectRatio: 0.9,
                      ), itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                           Get.to(MvPlayPage(index: index,mvDetailsModelList: mvList,),transition: Transition.rightToLeft);
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
                                            mvList[index].picUrl==null?mvList[index].imgurl ?? CacheGlobalData.errorImg:CacheGlobalData.errorImg,
                                            fit: BoxFit.fill,
                                            cache: true,
                                            height: constraints.biggest.height-45,
                                          )),
                                      Positioned(
                                          right: 15,
                                          top: 5,
                                          child: Row(
                                            children: [
                                              const Icon(Icons.play_arrow_outlined,color: Colors.white,),
                                              const SizedBox(width: 5,),
                                              Text(mvList[index].playCount >10000?"${ (mvList[index].playCount/10000).truncate()}万":mvList[index].playCount.toString() ,style:const TextStyle(
                                                  color: Colors.white,fontSize: 13
                                              ),),
                                            ],
                                          )
                                      ),
                                      Positioned(
                                          right: 5,
                                        bottom: 5,
                                          child: Text(CommUtils.formatMinSec(mvList[index].duration),style: const TextStyle(color: Colors.white,fontSize: 13),),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  SizedBox(
                                    height: 30,
                                    child: AutoSizeText(mvList[index].name,style: const TextStyle(color: Colors.white,fontSize: 15)
                                      ,textScaleFactor: 1,minFontSize: 12,maxLines: 1,overflow: TextOverflow.ellipsis,),
                                  )
                                ],);
                            },
                          ),
                        );
                      }),
                );
              } else if (snap.connectionState == ConnectionState.active) {
                return   Container();
              } else if (snap.connectionState == ConnectionState.waiting) {
                return Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: const Center(
                      child: SleekCircularSlider(
                          appearance: CircularSliderAppearance(
                            spinnerMode: true,
                          ))
                  ),
                );
              } else if (snap.connectionState == ConnectionState.none) {
                return Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: BrnAbnormalStateWidget(
                    bgColor: Colors.transparent,
                    isCenterVertical: true,
                    themeData:BrnAbnormalStateConfig(
                        titleTextStyle:BrnTextStyle(color: Colors.white,fontSize: 18)
                    ),
                    title: "暂无数据",
                  ),
                );
              }
              return Container();
            },

          ),
        ))

      ],
    );
  }

  getMvListListDetails(int id) async{

//    if(widget.mvSize==null || widget.mvSize==0){
//      return;
//    }
    if(mvList.isEmpty){
      //先获取缓存
      var indexWhere = CacheGlobalData.cacheMvDetailsList.indexWhere((element) => element['id']==id);
      if(indexWhere>=0){
        mvList = CacheGlobalData.cacheMvDetailsList[indexWhere]['mv'];
        return;
      }

      var list = await MvService.getMvListInfo(id: id);
      if(list!=null && list.isNotEmpty){
        CacheGlobalData.cacheMvDetailsList .add({
          "id":id,
          "mv":list
        });
        mvList =list;
      }
    }
  }

  @override
  bool get wantKeepAlive => true;


}
