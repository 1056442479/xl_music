

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/model/mv/mv_details.dart';

import 'package:qq_music/service/mv/mv_service.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';import 'package:text_scroll/text_scroll.dart';

import 'mv_play_page.dart';


///全部MV
class MvAllPage extends StatefulWidget {
  const MvAllPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MvAllPageState createState() => _MvAllPageState();
}

class _MvAllPageState extends State<MvAllPage> with AutomaticKeepAliveClientMixin{

  List<MvDetailsModel> allList =[];
  bool dataRes =false;
  bool noMore =false;
  int page =1;

  ///地区选择
  List<String> areaList =["全部","内地","港台","欧美","日本","韩国"];
  String area="全部";

  ///类型选择
  List<String> typeList =["全部","官方版","原生","现场版","网易出品"];
  String type="全部";

  ///排序选择
  List<String> orderList =["上升最快","最热","最新"];
  String order="上升最快";
  ScrollController scrollController =ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.offset+100 >= scrollController.position.maxScrollExtent) {
        if(dataRes==false){
          dataRes=true;
          debugPrint("滚动到底部bottom了...");
          page+=1;
          getAllMvList(init: false);
        }
      }
    });

    getAllMvList(init: true);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Material(
      color:const Color.fromRGBO(30, 30, 31, 1),
      child: Container(
        margin: const EdgeInsets.only(left: 20,right: 20,top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("全部MV",style: TextStyle(color: Colors.white,fontSize: 25),),
            const SizedBox(height: 20,),
            Expanded(child: dataRes?
            const Center(
                child: SleekCircularSlider(
                    appearance: CircularSliderAppearance(
                      spinnerMode: true,
                    ))
              )
                : CustomScrollView(
              controller: scrollController,
              slivers: [
                  SliverToBoxAdapter(
                  child: SizedBox(
//                    height: 180,
                    child: Column(
                      children: [
                        //地区
                        SizedBox(
                          height: 30,
                          child: ListView.builder(itemBuilder: (context, index) {
                            return InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              onTap: (){
                                if(area!=areaList[index]){
                                  setState(() {
                                    area =areaList[index];
                                    getAllMvList(init: true);
                                  });
                                }
                              },
                              child: Container(
                                width: 80,
                                height: 30,
                                alignment: Alignment.center,
                                margin:const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    gradient: areaList[index]==area?const LinearGradient(
                                        colors: [
                                          Color.fromRGBO(21, 212, 174, 1),
                                          Color.fromRGBO(31, 208, 163, 1),
                                          Color.fromRGBO(30, 205, 150, 1),
                                        ]
                                    ):const LinearGradient(
                                        colors: [
                                          Colors.black26,
                                          Colors.black26,
                                        ]
                                    ),
                                    borderRadius: const BorderRadius.all(Radius.circular(40))
                                ),
                                padding: const EdgeInsets.all(5),
                                child: Text(areaList[index],style: const TextStyle(color: Colors.white,fontSize: 15),),
                              ),
                            );
                          },itemCount: areaList.length,scrollDirection: Axis.horizontal,),
                        ),
                        const SizedBox(height: 20,),

                        //类型
                        SizedBox(
                          height: 30,
                          child: ListView.builder(itemBuilder: (context, index) {
                            return InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              onTap: (){
                                if(type!=typeList[index]){
                                  setState(() {
                                    type =typeList[index];
                                    getAllMvList(init: true);
                                  });
                                }
                              },
                              child: Container(
                                width: 80,
                                height: 30,
                                alignment: Alignment.center,
                                margin:const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    gradient: typeList[index]==type?const LinearGradient(
                                        colors: [
                                          Color.fromRGBO(21, 212, 174, 1),
                                          Color.fromRGBO(31, 208, 163, 1),
                                          Color.fromRGBO(30, 205, 150, 1),
                                        ]
                                    ):const LinearGradient(
                                        colors: [
                                          Colors.black26,
                                          Colors.black26,
                                        ]
                                    ),
                                    borderRadius: const BorderRadius.all(Radius.circular(40))
                                ),
                                padding: const EdgeInsets.all(5),
                                child: Text(typeList[index],style: const TextStyle(color: Colors.white,fontSize: 15),),
                              ),
                            );
                          },itemCount: typeList.length,scrollDirection: Axis.horizontal,),
                        ),
                        const SizedBox(height: 20,),

                        //排序
                        SizedBox(
                          height: 30,
                          child: ListView.builder(itemBuilder: (context, index) {
                            return InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              onTap: (){
                                if(order!=orderList[index]){
                                  setState(() {
                                    order =orderList[index];
                                    getAllMvList(init: true);
                                  });
                                }
                              },
                              child: Container(
                                width: 80,
                                height: 30,
                                alignment: Alignment.center,
                                margin:const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    gradient: orderList[index]==order?const LinearGradient(
                                        colors: [
                                          Color.fromRGBO(21, 212, 174, 1),
                                          Color.fromRGBO(31, 208, 163, 1),
                                          Color.fromRGBO(30, 205, 150, 1),
                                        ]
                                    ):const LinearGradient(
                                        colors: [
                                          Colors.black26,
                                          Colors.black26,
                                        ]
                                    ),
                                    borderRadius: const BorderRadius.all(Radius.circular(40))
                                ),
                                padding: const EdgeInsets.all(5),
                                child: Text(orderList[index],style: const TextStyle(color: Colors.white,fontSize: 15),),
                              ),
                            );
                          },itemCount: orderList.length,scrollDirection: Axis.horizontal,),
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 20,),
                ) ,

                
                  SliverGrid(delegate:SliverChildBuilderDelegate((context,index){
                    return InkWell(
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: (){
                        Get.to(()=>MvPlayPage(index:index , mvDetailsModelList: allList,mvId: allList[index].id,),transition: Transition.rightToLeft);
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
                                        allList[index].cover ?? CacheGlobalData.errorImg,
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
                                            allList[index].playCount > 10000
                                                ? "${( allList[index].playCount / 10000).truncate()}万"
                                                :  allList[index].playCount.toString(),
                                            style: const TextStyle(
                                                color: Colors.white, fontSize: 13),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                              const SizedBox(height: 10,),
                              TextScroll( allList[index].name,style: const TextStyle(color: Colors.white,fontSize: 15),selectable: true,),
                              Text( allList[index].artistName,style: const TextStyle(color: Colors.grey,fontSize: 12),textScaleFactor: 1,)
                            ],);
                        },
                      ),
                    );
                  },childCount:allList.length ) ,  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    /// 纵轴间距
                    mainAxisSpacing: 20.0,
                    /// 横轴间距
                    crossAxisSpacing: 20.0,
                    /// 横轴元素个数
                    crossAxisCount: 3,
                    /// 宽高比
                    childAspectRatio: 1.4,
                  ))
              ],
            ))
          ],
        ),
      ),
    );
  }


  getAllMvList( {required bool init}) async{

    if(init){
      page =1;
      dataRes=true;
      noMore =false;
      allList.length=0;
    }
    if(noMore){
      dataRes=false;
      EasyLoading.showToast("没有更多了");
      return;
    }
    var allMvList = await MvService.getAllMvList(page: page,area: area,order: order,type: type,limit: 30);
    if(allMvList!=null){
      if(allMvList.isEmpty){
        noMore =true;
      }else{
        allList.addAll(allMvList);
      }
    }
    setState(() {
      dataRes=false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
