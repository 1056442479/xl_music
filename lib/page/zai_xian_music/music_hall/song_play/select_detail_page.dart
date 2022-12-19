

import 'package:animate_do/animate_do.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:qq_music/model/song_play/song_play_details.dart';
import 'package:qq_music/page/song_user/play_song_details.dart';
import 'package:qq_music/service/song/song_service.dart';

class SelectDetailsPage extends StatefulWidget {
  final String tagsName;
  const SelectDetailsPage({Key? key,required this.tagsName}) : super(key: key);

  @override
  _SelectDetailsPageState createState() => _SelectDetailsPageState();
}

class _SelectDetailsPageState extends State<SelectDetailsPage> {
  List<SongPlayDetails> songPlayDetailsList = [];

  //精品歌单数据是否请求中
  bool dataRs =false;
  ///before: 分页参数,取上一页最后一个歌单的 updateTime 获取下一页数据
  int? before;
  ScrollController scrollController =ScrollController();

  bool noMore =false;

  @override
  void initState() {
    super.initState();
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
    return Material(
      color: const Color.fromRGBO(30, 30, 31, 1),
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20,top: 20),
          child:CustomScrollView(
            slivers: <Widget>[
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 10,
                ),
              ),
               SliverToBoxAdapter(
                child: SizedBox(
                  child: Text(widget.tagsName,style:const TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 20,
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
      ),
    );
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

    if(songPlayDetailsList.isNotEmpty){
      before =songPlayDetailsList[songPlayDetailsList.length-1].updateTime;
    }
    var highQualityList = await SongService.getHighQualitySongPlays(before: before,cat:widget.tagsName);
    if (highQualityList != null) {
      if(highQualityList.isEmpty){
        noMore =true;
        EasyLoading.showToast("暂无数据");
      }else{
        songPlayDetailsList.addAll(highQualityList);
      }
    }
    setState(() {
      dataRs=false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }
}
