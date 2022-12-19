
import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:qq_music/model/dj/dj_banner.dart';
import 'package:qq_music/model/dj/dj_category_list_model.dart';
import 'package:qq_music/model/dj/dj_details.dart';
import 'package:qq_music/service/dj/dj_service.dart';

import '../../dj/dj_details_page.dart';

class DjMainPage extends StatefulWidget {
  const DjMainPage({Key? key}) : super(key: key);

  @override
  _DjMainPageState createState() => _DjMainPageState();
}

class _DjMainPageState extends State<DjMainPage> with AutomaticKeepAliveClientMixin{

  List<DjBannerModel> bannerList =[];
  ///热门分类电台
  List<DjCategoryListModel> djCategoryList =[];
  ///热门电台
  List<DjDetailsModel> hotDjList =[];

  @override
  void initState() {
    super.initState();
    getDjBanner();
    getHotDj();
    getDjRecommendList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Material(
        color: const Color.fromRGBO(30, 30, 31, 1),
        child: Container(
        margin: const EdgeInsets.only(left: 20,right: 20),
        child: CustomScrollView(
          slivers: [
            ///轮播图
             SliverToBoxAdapter(
              child:   Container(
                  height:130,
                  width: double.infinity*0.7,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 20,),
                  child:Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        hoverColor: Colors.transparent,
                        onTap: (){
                          EasyLoading.showToast("仅做展示");
                        },
                        child: ExtendedImage.network(
                          bannerList[index].pic,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                    controller: SwiperController(),
                    itemCount: bannerList.length,
                    viewportFraction: 0.6,// 当前视窗展示比例 小于1可见上一个和下一个视窗
                    scale: 0.6, // 两张图片之间的间隔

                    index: 0,
                    autoplay: true,
                    loop: true,
                    autoplayDisableOnInteraction: true, // 用户进行操作时停止自动翻页

                  )),
            ),

            ///热门电台
            SliverToBoxAdapter(
              child:  Container(
                margin:const EdgeInsets.only(top: 30,bottom: 20),
                child:  const Text("热门",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
              ),
            ),
            SliverGrid(
                gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
              /// 纵轴间距
              mainAxisSpacing: 20.0,
              /// 横轴间距
              crossAxisSpacing: 7.0,
              /// 横轴元素个数
              crossAxisCount: 5,
              /// 宽高比
              childAspectRatio: 0.8,
            ),
                delegate:SliverChildBuilderDelegate((context, index) {
                  return FadeInLeft(
                    child: InkWell(
                      onTap: (){
                        Get.to(()=>DjDetailsPage(id: hotDjList[index].id,
                        ),transition: Transition.rightToLeft);
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
                                    Image(image: NetworkImage(hotDjList[index].picUrl),fit: BoxFit.fill,height: constraints.biggest.height-45,),
                                    Positioned(
                                        right: 15,
                                        top: 5,
                                        child: Row(
                                          children: [
                                            const  FaIcon(Icons.play_arrow_outlined,color: Colors.white,),
                                            const SizedBox(width: 5,),
                                            Text(hotDjList[index].subCount >10000?"${ (hotDjList[index].subCount/10000).truncate()}万":hotDjList[index].subCount.toString() ,style:const TextStyle(
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
                                child: Text(hotDjList[index].name,style: const TextStyle(color: Colors.white,fontSize: 15),textScaleFactor: 1,maxLines: 2,overflow: TextOverflow.ellipsis,),
                              )
                            ],);
                        },
                      ),
                    )
                  );
                },childCount:hotDjList.length)),

            const  SliverToBoxAdapter(
              child: SizedBox(height: 20,),
            ),

            SliverList(
                delegate: SliverChildBuilderDelegate((context,index){
                    return Column(
                      children: [
                        Container(

                          margin:const EdgeInsets.only(top: 30,bottom: 20),
                          alignment: Alignment.centerLeft,
                          child:   Text(djCategoryList[index].categoryName,style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                        ),

                        GridView.builder(   gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                          /// 纵轴间距
                          mainAxisSpacing: 20.0,
                          /// 横轴间距
                          crossAxisSpacing: 7.0,
                          /// 横轴元素个数
                          crossAxisCount: 5,
                          /// 宽高比
                          childAspectRatio: 0.8,
                        ), itemBuilder: (context,gridIndex){
                          return    FadeInLeft(
                              child: InkWell(
                                onTap: (){
                                  Get.to(()=>DjDetailsPage(id:djCategoryList[index].radios[gridIndex].id,
                                  ),transition: Transition.rightToLeft);
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
                                              Image(image: NetworkImage(djCategoryList[index].radios[gridIndex].picUrl),fit: BoxFit.fill,height: constraints.biggest.height-45,),
                                              Positioned(
                                                  right: 15,
                                                  top: 5,
                                                  child: Row(
                                                    children: [
                                                      const  FaIcon(Icons.play_arrow_outlined,color: Colors.white,),
                                                      const SizedBox(width: 5,),
                                                      Text(djCategoryList[index].radios[gridIndex].playCount >10000?"${ (djCategoryList[index].radios[gridIndex].playCount/10000).truncate()}万":djCategoryList[index].radios[gridIndex].playCount.toString() ,style:const TextStyle(
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
                                          child: Text(djCategoryList[index].radios[gridIndex].name,style: const TextStyle(color: Colors.white,fontSize: 15),textScaleFactor: 1,maxLines: 2,overflow: TextOverflow.ellipsis,),
                                        )
                                      ],);
                                  },
                                ),
                              )
                          );
                        },itemCount:djCategoryList[index].radios.length ,shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),)
                      ],
                    );
                },childCount: djCategoryList.length)
            )


          ],
        ),
    ));
  }

  ///轮播图
  getDjBanner() async{
    var banner =await DjService.getDjBanner();
    if(banner!=null){
      setState(() {
        bannerList=banner;
      });
    }
  }

  ///获取热门电台
  getHotDj() async{
    var hot =await DjService.getHotDj(page: 1,limit: 5);
    if(hot!=null){
      setState(() {
        hotDjList=hot;
      });
    }
  }

  getDjRecommendList() async{
    var hot =await DjService.getDjRecommendList();
    if(hot!=null){
      setState(() {
        djCategoryList=hot;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}
