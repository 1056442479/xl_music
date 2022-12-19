import 'package:animate_do/animate_do.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:qq_music/model/song_play/high_quality_tags.dart';
import 'package:qq_music/model/song_play/song_play_details.dart';
import 'package:qq_music/page/song_user/play_song_details.dart';
import 'package:qq_music/page/zai_xian_music/music_hall/song_play/select_all_page.dart';
import 'package:qq_music/page/zai_xian_music/music_hall/song_play/select_detail_page.dart';
import 'package:qq_music/service/song/song_service.dart';
import 'package:styled_widget/styled_widget.dart';

///歌单
class SongPlayHall extends StatefulWidget {
  const SongPlayHall({Key? key}) : super(key: key);

  @override
  _SongPlayHallState createState() => _SongPlayHallState();
}

class _SongPlayHallState extends State<SongPlayHall> with AutomaticKeepAliveClientMixin{
  ///热门分类标签,第一个放全部
  List<String> songPlayHotList = [
    "全部"
  ];
  int hotSelectIndex =-1;

  //精品歌单数据是否请求中
  bool dataRs =false;


  ///精品歌单标签
  List<HighQualityTagsModel> highQualityTagsList = [];
  int selectTagsIndex =-1;
  ScrollController scrollController =ScrollController();

  ///精品歌单数据
  List<SongPlayDetails> songPlayDetailsList = [];

  ///before: 分页参数,取上一页最后一个歌单的 updateTime 获取下一页数据
  int? before;

  bool noMore =false;

  @override
  void initState() {
    super.initState();
    getHighQualityTags();
    getSongPlayHotCategory();
    getHighQualitySongPlays(init: true);

    scrollController.addListener(() {
      if (scrollController.offset+40 >= scrollController.position.maxScrollExtent) {
        if(dataRs==false){
          dataRs=true;
          debugPrint("滚动到底部bottom了...");
          getHighQualitySongPlays(init: false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20,top: 20),
      child:CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
            SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: () {
                      if (index ==0) {
                        Get.to(()=>const SelectAllPage(),transition: Transition.fadeIn);
                      }else{
                        Get.to(SelectDetailsPage(tagsName: songPlayHotList[index]),transition: Transition.rightToLeft);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 10, top: 10),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Color.fromRGBO(48, 48, 49, 1)),
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        songPlayHotList[index],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  );
                }, childCount: songPlayHotList.length),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  /// 纵轴间距
                  mainAxisSpacing: 5,

                  /// 横轴间距
                  crossAxisSpacing: 5,

                  /// 横轴元素个数
                  crossAxisCount: 6,

                  /// 宽高比
                  childAspectRatio: 3,
                )),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),

            //精品歌单
            SliverToBoxAdapter(
                child:  SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        const Text("精品歌单",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
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
                            child: Text(selectTagsIndex==-1? "全部歌单":highQualityTagsList[selectTagsIndex].name),
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
            SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                return InkWell(
                  hoverColor: Colors.transparent,
                  onTap: () {
                    Get.to(() => PlaySongDetailsPage(
                      id: songPlayDetailsList[index].id,
                      picUrl: songPlayDetailsList[index].coverImgUrl,
                      name: songPlayDetailsList[index].name,
                      avatarUrl:
                      songPlayDetailsList[index].creator.avatarUrl,
                      createTime: songPlayDetailsList[index].createTime,
                      nickname:
                      songPlayDetailsList[index].creator.nickname,
                      uid: songPlayDetailsList[index].creator.userId,
                    ));
                  },
                  child: FadeIn(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Stack(
                                    children: [
                                      ExtendedImage.network(
                                        songPlayDetailsList[index].coverImgUrl,
                                        fit: BoxFit.fill,
                                      ),
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
                                                songPlayDetailsList[index]
                                                    .subscribedCount >
                                                    10000
                                                    ? "${(songPlayDetailsList[index].subscribedCount / 10000).truncate()}万"
                                                    : songPlayDetailsList[index]
                                                    .subscribedCount
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 40,
                              child: Text(
                                songPlayDetailsList[index].name,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15),
                                textScaleFactor: 1,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                );
              }, childCount: songPlayDetailsList.length),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(

                /// 纵轴间距
                mainAxisSpacing: 20.0,

                /// 横轴间距
                crossAxisSpacing: 7.0,

                /// 横轴元素个数
                crossAxisCount: 5,

                /// 宽高比
                childAspectRatio: 0.8,
              )
          ),
        ],
      )
    );
  }

  /// 热门歌单标签列表
  getSongPlayHotCategory() async {
    var hotTags = await SongService.getSongPlayHotCategory();
    if (hotTags != null) {
      songPlayHotList.addAll(hotTags.map((e) => e.name).toList());
    }
  }


  /// 精品歌单标签列表
  getHighQualityTags() async {
    var highQualityTags = await SongService.getHighQualityTags();
    if (highQualityTags != null) {
      highQualityTagsList = highQualityTags;
    }
  }

  ///获取精品歌单
  ///[init] 是否重新帅选了
  getHighQualitySongPlays({required bool init}) async {
    if(init){
      before =null;
      noMore =false;
      songPlayDetailsList.length=0;
    }
    if(noMore){
      dataRs=false;
      EasyLoading.showToast("没有更多了");
      return;
    }
    String ? cat ;
    if(highQualityTagsList.isNotEmpty){
      if(selectTagsIndex!=-1){
        cat = selectTagsIndex==0?null:highQualityTagsList[selectTagsIndex].name;
      }
    }
    if(songPlayDetailsList.isNotEmpty){
      before =songPlayDetailsList[songPlayDetailsList.length-1].updateTime;
    }
    var highQualityList = await SongService.getHighQualitySongPlays(before: before,cat:cat);
    if (highQualityList != null) {
      if(highQualityList.isEmpty){
        noMore =true;
      }else{
        songPlayDetailsList.addAll(highQualityList);
      }
    }
    setState(() {
      dataRs=false;
    });
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
                                  getHighQualitySongPlays(init: true);
                                }
                              },
                              child: Text(
                                "全部歌单",
                                style: TextStyle(
                                    color: selectTagsIndex == -1
                                        ? Colors.greenAccent
                                        : Colors.white),
                              )),
                        ),
                        const Divider(),
                        Expanded(
                            child:  GridView.builder(

                                itemCount: highQualityTagsList.length,
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
                                    getHighQualitySongPlays(init: true);
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(left: 3),
                                  child: Text(highQualityTagsList[index].name,style: TextStyle(color: index==selectTagsIndex? Colors.greenAccent:Colors.white),),
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

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
