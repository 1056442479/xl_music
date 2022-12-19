
import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qq_music/const/global.dart';
import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/controller/audio_list_controller.dart';
import 'package:qq_music/controller/page_controller.dart';
import 'package:qq_music/model/event/event_model.dart';
import 'package:qq_music/model/song/song_list_details.dart';
import 'package:qq_music/page/dao_hang.dart';
import 'package:qq_music/service/song/song_service.dart';
import 'package:qq_music/utils/Global.dart';
import 'package:qq_music/utils/commutils.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../song_user/song_user.dart';

class MusicFullPage extends StatefulWidget {
  const MusicFullPage({Key? key}) : super(key: key);

  @override
  _MusicFullPageState createState() => _MusicFullPageState();
}

class _MusicFullPageState extends State<MusicFullPage> {

  final  colorizeColors = [
    Colors.greenAccent,
    Colors.white
  ];



  List<Map> lrcList=[];

  int colorIndex =-1;
  //监听滚动事件
  final ScrollController itemScrollController = ScrollController();
  Song ? song ;
  late StreamSubscription<dynamic> fullController;
  double nowTimeMs = 0; //当前位置的毫秒数
  bool slid = false;
  int index =0; //记录索引
  double recordTime=-1; //记录时间
  bool pureMusic =false; ///是否是纯音乐
  late   MusicPageController musicPageController;
  late StreamSubscription listenAudioAndMv;

  @override
  void initState() {
    super.initState();

    if(AudioListController.playIndex!=-1){
      song =AudioListController.playList[AudioListController.playIndex];
      getSongLrc(song?.id ?? -1);
    }


    musicPageController =  Get.put(MusicPageController());

    listenAudioAndMv = Global.getInstance()!.on<ChangeSong>().listen((event) {
          recordTime =-1;
          nowTimeMs=0;
          debugPrint("歌曲改变了");
          if(event.song.id==-1){
            setState(() {
                 song =event.song;
                 lrcList.length=0;
                 pureMusic=false;
            });
            return;
          }
          if (event.song.id !=song?.id) {
            setState(() {
              lrcList.length=0;
              song =event.song;
              getSongLrc(song?.id ??-1);
            });
          }
    });



    fullController = streamController.stream.listen((event) {

      nowTimeMs =double.parse(event['value'].toString());


      if(song?.id!=-1 && pureMusic==false){
        if(nowTimeMs!=recordTime){
          debugPrint(nowTimeMs.toString());
          var indexWhere = lrcList.indexWhere((element) => element['time']>=nowTimeMs );
          if(indexWhere!=-1){
            if(itemScrollController.hasClients!=false){
              itemScrollController.animateTo((indexWhere-4<0?0:indexWhere-4)*50, duration: const Duration(seconds: 1), curve: Curves.linear);
            }
            setState(() {
              colorIndex =indexWhere-1<0?0:indexWhere-1;
            });
          }
        }
        recordTime =nowTimeMs;
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    return  MediaQuery(
      data: const MediaQueryData(),
      child: SlideInDown(
        child: Material(
          color: const Color.fromRGBO(30, 30, 31, 1),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child:  Column(
              children:  [
                const DaoHang(full: true,),
                Expanded(child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(50),
                    constraints: const BoxConstraints(
                      maxWidth: 1400,
                      maxHeight:850,
                      minWidth: 900,
                      minHeight: 550,
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(50),
                          child: Center(
                            child:ExtendedImage.network(
                              song?.al.picUrl ?? CacheGlobalData.errorImg,
                              width: 350,
                              height:350,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(child: Container(
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                              Center(
                                  child: Text(
                                    song?.name ?? "未知",
                                    style: const TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              const SizedBox(height: 15,),
                              Center(
                                  child: InkWell(
                                      onTap: () {
                                        Global.getInstance()!
                                            .fire(ChangeMusicFullIndex(0));
                                        Get.to(
                                                () => SongUser(
                                              id: song?.ar.first.id ??-1,
                                              username:  song?.ar.first.name ?? "佚名",
                                            ),
                                            transition: Transition.rightToLeft);
                                      },
                                      hoverColor: Colors.transparent,
                                      child: Text(
                                song?.ar.first.name ?? "佚名",
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.grey),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ))),
                              const SizedBox(height: 15,),
                                  ///歌词部分
                                  Expanded(child:
                                  lrcList.isEmpty?pureMusic? const Center(child: Text("纯音乐，请欣赏",style: TextStyle(color: Colors.white,fontSize: 30),)):
                                  const Center(child: Text("暂无歌词",style: TextStyle(color: Colors.white,fontSize: 30),)):
                                  ListView.builder(
                                  itemCount: lrcList.length-1,
                                  controller: itemScrollController,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      alignment: Alignment.center,
                                      color: colorIndex==index?const Color.fromRGBO(36, 36, 37, 1):Colors.transparent,
                                      height: lrcList[index]['lrc'].isEmpty?0: 40,
                                      margin: const EdgeInsets.only(top: 5,bottom: 5,left: 15,right: 15),
                                      child: GestureDetector(
                                        behavior:HitTestBehavior.translucent,
                                        onDoubleTap:(){
                                        } ,
                                        child:
                                        Text(
                                          lrcList[index]['lrc'],
                                          style: TextStyle(color: colorIndex==index?Colors.greenAccent:Colors.white,
                                              fontSize:  colorIndex==index?15:13
                                          ),
                                        ),
//                                        AnimatedTextKit(
//                                            animatedTexts: [
//                                              ColorizeAnimatedText(
//                                              lrcList[index]['lrc'],
//                                              textStyle: const TextStyle(
//                                                fontSize: 14.0,
//                                                color: Colors.white
//                                              ),
//                                              speed:  Duration(milliseconds:lrcList[index+1]['time']- lrcList[index]['time']),
//                                              colors: colorizeColors
//                                            ),
//                                          ],
////                                          pause:  Duration(milliseconds: lrcList[index]['time']),
//                                          isRepeatingAnimation:false
//                                        )

                                      ),
                                    );
                                  },
                                  ))

                              ],
                            ),
                        ))
                      ],
                    ),
                  ),
                )),

                ///列表
                Container(
                  margin: const EdgeInsets.only(left: 50,right: 50,bottom: 20),
                    height: 100,
                    constraints: const BoxConstraints(
                      maxWidth: 1400,
                    ),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Expanded(child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            ///上一级
                            RotatedBox(
                              quarterTurns: 2,
                              child: InkWell(
                                onTap: () {
                                  if(AudioListController.playIndex!=-1){
                                    Global.getInstance()!.fire(AudioPlayEvent(playUp: true));
                                  }
                                },
                                child: const Icon(
                                  Icons.play_arrow, color: Colors.white,
                                  size: 20,),
                              ),
                            ),
                            const SizedBox(width: 20,),

                            ///播放
                            InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                if (Global.audioPlayer.state == PlayerState.paused) {
                                  Global.audioPlayer.resume();
                                  musicPageController.playIng.value=true;
                                } else {
                                  Global.audioPlayer.pause();
                                  musicPageController.playIng.value=false;
                                }
                              },
                              child: Obx(() {
                                return Container(
                                  width: 30,
                                  height: 30,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.greenAccent
                                  ),
                                  child: musicPageController.playIng.value==true?
                                  const Icon(
                                    Icons.pause, color: Colors.black,
                                    size: 20,) :
                                  const Icon(
                                    Icons.play_arrow,
                                    color: Colors.black,
                                    size: 20,),
                                );
                              }),
                            ),

                            ///下一集
                            const SizedBox(width: 20,),
                            InkWell(
                              onTap: () {
                                if(AudioListController.playIndex!=-1){
                                  Global.getInstance()!.fire(AudioPlayEvent(playDown: true));
                                }
                              },
                              child: const Icon(
                                Icons.play_arrow, color: Colors.white,
                                size: 20,),
                            )

                          ],
                        ),),
                        SizedBox(
                          height: 50,
                          child: StreamBuilder(
                            stream: streamController.stream,
                            builder: (BuildContext context, AsyncSnapshot<dynamic>snapshot) {
                              return Row(
                                children: [
                                  Text(
                                    snapshot.hasData
                                        ? snapshot
                                        .data['text'] ??
                                        CommUtils.formatMinSec(
                                            0)
                                        : "00:00",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13),
                                    textScaleFactor: 1,
                                  ),
                                  Expanded(
                                    child: SfSliderTheme(
                                      data: SfSliderThemeData(
                                        activeTrackHeight: 2,
                                        inactiveTrackHeight: 2,
                                        thumbRadius: 5,
                                        activeDividerRadius: 15,
                                        overlayRadius: 15,
                                        //放上去的圆点大小
                                        inactiveTrackColor: Colors
                                            .grey,
                                        thumbColor: const Color
                                            .fromRGBO(
                                            31, 210, 169, 1),
                                        activeTrackColor: const Color
                                            .fromRGBO(
                                            31, 210, 169, 1),
                                      ),
                                      child: SfSlider(
                                        max: double.parse(
                                            song != null ? (song?.dt==0?"60000": song?.dt .toString() ?? "60000") : "60000"),
                                        min: 0,
                                        value: snapshot.hasData ?
                                        ((snapshot.data['value'] > song?.dt ?? 60000 ) ?  song?.dt ?? 60000 : snapshot.data['value'])

                                            : nowTimeMs,
                                        onChangeStart: (value) {
                                          slid = true;
//                                                    playSetState(() {
                                          streamController
                                              .sink
                                              .add({
                                            "text": CommUtils
                                                .formatMinSec(
                                                value.toInt()),
                                            "value": value
                                          });
                                          nowTimeMs = value;
//                                                    });
                                        },
                                        onChanged: (value) {
//                                                    playSetState(() {
                                          streamController
                                              .sink
                                              .add({
                                            "text": CommUtils
                                                .formatMinSec(
                                                value.toInt()),
                                            "value": value
                                          });
                                          nowTimeMs = value;
//                                                    });
                                        },
                                        onChangeEnd: (v) {
                                          seekSlid(v);
                                        },

                                      ),
                                    ),
                                  ),
                                  //最右边的时间
                                  Text(
                                    CommUtils.formatMinSec(
                                        song?.dt ?? 60000).trim(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13),
                                    textScaleFactor: 1,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///滑动跳转
  seekSlid(double v) async {
    await Global.audioPlayer.seek(Duration(milliseconds: v.floor()));

    var state = Global.audioPlayer.state;
    if (state == PlayerState.paused || state == PlayerState.completed) {
//      await resume();
    }
    slid = false;
    debugPrint("滑动结束了...");
  }

  ///获取歌词
  getSongLrc(int id) async{
    debugPrint("获取歌词");
    if(id!=-1){
      var songLrc = await SongService.getSongLrc(id: id);
      if(songLrc!=null){
        if(songLrc.needDesc!=null && songLrc.needDesc!){
          pureMusic =true;
        }else{
          lrcList = await  CommUtils.parseLrcStr(songLrc.lrc.lyric);
          pureMusic=false;
        }
      }
    }
  }
  
  @override
  void dispose() {
    super.dispose();
    listenAudioAndMv.cancel();

    debugPrint("全屏歌词页面卸载了");
  }
}
