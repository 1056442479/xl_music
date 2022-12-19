

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qq_music/model/video/video_details.dart';
import 'package:qq_music/model/video/video_group_model.dart';
import 'package:qq_music/service/video_service/VideoService.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:text_scroll/text_scroll.dart';

class  MvDetailsPage extends StatefulWidget {
  const  MvDetailsPage({Key? key}) : super(key: key);

  @override
  _VideoRecommendState createState() => _VideoRecommendState();
}

class _VideoRecommendState extends State< MvDetailsPage> {
  ///视频分类
  List<VideoGroupModel> videoGroupList =[];
  ///视频标签
  List<VideoGroupModel> videoCategoryList =[];

  ///视频列表
  List<VideoDetailsModel> videoList =[];

  int selectTagsIndex =-1;

  @override
  void initState() {
    super.initState();
//    getVideoCategory();
    getVideoGroup();
    getAllVideoList(true);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color:const Color.fromRGBO(30, 30, 30, 1),
      child: Container(
        margin: const EdgeInsets.only(left: 20,right: 20),
        child: CustomScrollView(
            slivers:[
//              StatefulBuilder(
//                builder: (BuildContext context, void Function(void Function()) setState) {
//                  return SliverGrid(
//                      delegate: SliverChildBuilderDelegate((context, index) {
//                        return InkWell(
//                          splashColor: Colors.transparent,
//                          highlightColor: Colors.transparent,
//                          focusColor: Colors.transparent,
//                          hoverColor: Colors.transparent,
//                          onTap: () {
//                          },
//                          child: Container(
//                            alignment: Alignment.center,
//                            margin: const EdgeInsets.only(right: 10, top: 10),
//                            decoration: const BoxDecoration(
//                                borderRadius: BorderRadius.all(Radius.circular(5)),
//                                color: Color.fromRGBO(48, 48, 49, 1)),
//                            padding: const EdgeInsets.all(5),
//                            child: Text(
//                              videoCategoryList[index].name,
//                              style:
//                              const TextStyle(color: Colors.white, fontSize: 15),
//                            ),
//                          ),
//                        );
//                      }, childCount: videoCategoryList.length),
//                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                        /// 纵轴间距
//                        mainAxisSpacing: 5,
//
//                        /// 横轴间距
//                        crossAxisSpacing: 5,
//
//                        /// 横轴元素个数
//                        crossAxisCount: 6,
//
//                        /// 宽高比
//                        childAspectRatio: 3,
//                      ));
//                },
//              ),
//              const SliverToBoxAdapter(
//                child: SizedBox(
//                  height: 20,
//                ),
//              ),

              //精品歌单
              SliverToBoxAdapter(
                child:  SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        const Text("全部视频",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                        Expanded(child: Container()),
                        InkWell(
                          onTap: showTagsWindow,
                          hoverColor: Colors.transparent,
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(left: 5,right: 5),
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(15)),
                                border: Border.all(color: Colors.black26)
                            ),
                            child: Text(selectTagsIndex==-1? "全部视频":videoGroupList[selectTagsIndex].name),
                          ),
                        ),
                        const SizedBox(width: 40,)
                      ],
                    )
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 10,
                ),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: 20,),
              ) ,

              ///列表
              SliverGrid(delegate:SliverChildBuilderDelegate((context,index){
                return InkWell(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: (){
//                    Get.to(()=>MvPlayPage(index:index , mvDetailsModelList: videoList,mvId: videoList[index].id,),transition: Transition.rightToLeft);
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
                                    videoList[index].data.coverUrl,
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
                                        videoList[index].data.playTime > 10000
                                            ? "${( videoList[index].data.playTime / 10000).truncate()}万"
                                            :  videoList[index].data.playTime.toString(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 13),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                          const SizedBox(height: 10,),
                          TextScroll( videoList[index].data.title,style: const TextStyle(color: Colors.white,fontSize: 15),selectable: true,),
                          Text( videoList[index].data.creator.nickname,style: const TextStyle(color: Colors.grey,fontSize: 12),textScaleFactor: 1,)
                        ],);
                    },
                  ),
                );
              },childCount:videoList.length ) ,  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                /// 纵轴间距
                mainAxisSpacing: 20.0,
                /// 横轴间距
                crossAxisSpacing: 20.0,
                /// 横轴元素个数
                crossAxisCount: 3,
                /// 宽高比
                childAspectRatio: 1.4,
              ))

            ]
        ),
      ),
    );
  }

  ///可获取视频标签列表
  getVideoGroup() async{
      var videoGroup = await VideoService.getVideoGroup();
      if(videoGroup!=null){
        videoGroupList =videoGroup;
      }
  }

  ///可获取视频分类列表
  getVideoCategory() async{
    var videoGroup = await VideoService.getVideoCategory();
    if(videoGroup!=null){
      videoCategoryList =videoGroup;
      setState(() {

      });
    }
  }

  ///获取分类标签下的视频
  getVideoList(int id,bool init) async{
    if(init){
      videoList.length=0;
    }
    var videoGroup = await VideoService.getVideoList(id: id);
    if(videoGroup!=null){
      videoList.addAll(videoGroup);
      setState(() {

      });
    }
  }

  ///获取全部视频列表
  getAllVideoList(bool init) async{
    if(init){
      videoList.length=0;
    }
    var videoGroup = await VideoService.getAllVideoList();
    if(videoGroup!=null){
      videoList.addAll(videoGroup);
      setState(() {

      });
    }
  }

  
  
  showTagsWindow(){
    Get.dialog(
        Stack(
          children: [
            Positioned(
                right: 50,
                top: 150,
                child: Material(
                  child: Styled.widget(
                    child: Container(
                      width: 500,
                      height: 430,
                      padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                      child: StatefulBuilder(
                        builder: (BuildContext context, void Function(void Function()) setStates) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                height:30,
                                margin: const EdgeInsets.only(left: 20),
                                child: InkWell(
                                    onTap: () {
                                      if(selectTagsIndex!=-1){
                                        setStates(() {
                                          selectTagsIndex = -1;
                                        });
                                        setState(() {

                                        });
                                        Get.back();
                                        getAllVideoList(true);
                                      }
                                    },
                                    child: Text(
                                      "全部视频",
                                      style: TextStyle(
                                          color: selectTagsIndex == -1
                                              ? Colors.greenAccent
                                              : Colors.white),
                                    )),
                              ),
                              const Divider(),
                              Expanded(
                                  child:  GridView.builder(

                                      itemCount: videoGroupList.length,
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        /// 纵轴间距
                                        mainAxisSpacing: 5,
                                        /// 横轴间距
                                        crossAxisSpacing: 5,
                                        /// 横轴元素个数
                                        crossAxisCount: 5,
                                        /// 宽高比
                                        childAspectRatio:2,
                                      ), itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: (){
                                        if(index!=selectTagsIndex){
                                          setStates(() {
                                            selectTagsIndex =index;
                                          });
                                          setState(() {

                                          });
                                          Get.back();
                                          getVideoList(videoGroupList[index].id,true);
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.only(left: 3),
                                        child: Text(videoGroupList[index].name,style: TextStyle(color: index==selectTagsIndex? Colors.greenAccent:Colors.white),),
                                      ),
                                    );
                                  })
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ).elevation(2),
                )
            )
          ],
        ),
        barrierColor:Colors.transparent
    );

  }
}

