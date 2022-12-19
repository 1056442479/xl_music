import 'dart:async';
import 'dart:io';
import 'dart:math';


import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:qq_music/const/global.dart';
import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/controller/audio_list_controller.dart';
import 'package:qq_music/controller/page_controller.dart';

import 'package:qq_music/model/event/event_model.dart';
import 'package:qq_music/model/song/song_list_details.dart';
import 'package:qq_music/page/song_user/song_list.dart';
import 'package:qq_music/service/song/song_service.dart';
import 'package:qq_music/utils/Global.dart';
import 'package:qq_music/utils/MyIcons.dart';
import 'package:qq_music/utils/commutils.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

class AudioPlayPage extends StatefulWidget {
  const AudioPlayPage({Key? key}) : super(key: key);

  @override
  _AudioPlayPageState createState() => _AudioPlayPageState();
}

class _AudioPlayPageState extends State<AudioPlayPage> {
  Song ? song;
  String ? url;


  List<IconData> iconList = [
    XlIcons.xl_liebiaoxunhuan,
    XlIcons.xl_lie_biao,
    XlIcons.xl_suijibofang,
    XlIcons.xl_danqu,
  ];

  ///音量大小（步骤按100来）
  double volume = CacheGlobalData.globalVolume;

  //创建StreamController


  double nowTimeMs = 0; //当前位置的毫秒数
  //播放的
//  late StateSetter playSetState;

  //info的信息
  late StateSetter playInfoSetState;

  ///是否正在播放中
  bool playIng = false;

  ///是否正在滑动中
  bool slid = false;

  ///是否静音中
  bool flagJin = false;

  bool show = false;

  //缓存获取url的播放索引
  List<int> cacheIndex = [];
  late StreamSubscription listenAudioAndMv;
  late StreamSubscription listenAudio;
  late StreamSubscription listenAudioOver;
  late StreamSubscription listenAudioChange;
  late   MusicPageController musicPageController;

  @override
  void initState() {
    super.initState();
    musicPageController =  Get.put(MusicPageController());


    listenAudio = Global.getInstance()!.on<AudioPlayEvent>().listen((event) {
      ///清空播放列表
      if (event.clearAll != null && event.clearAll!) {
        Global.audioPlayer.pause();
        Global.audioPlayer.dispose();
        setState(() {
          AudioListController.playList.length = 0;
          AudioListController.playIndex = -1;
          AudioListController.recommendPlayId = -1;
        });
      }

      if(event.playUp!=null && event.playUp!){
        playUpSong();
      }
      if(event.playDown!=null && event.playDown!){
        playDownSong();
      }
      ///播放记录的初始歌曲
      if(event.showController!=null && event.showController!){

        Global.audioPlayer.pause();

        setState(() {
             song = AudioListController.playList[AudioListController.playIndex];
             url =event.playUrl!;
            if(settingModel.keepAudioProgress){
              if(event.playMs!=null){
              nowTimeMs =event.playMs!;
              streamController.sink.add({
                "text": CommUtils.formatMinSec(nowTimeMs.toInt()).trim(),
                "value": nowTimeMs,
              });
            }
          }
        });
        if(event.showAutoPlay!=null && event.showAutoPlay!){
          play(event.playUrl!, AudioListController.playList[AudioListController.playIndex],nowTimeMs);
        }
      }

      if(event.url!=null){
        if (event.playType == 1) {
          if (kDebugMode) {
            print("触发播放时间");
          }
          url = event.url;
          play(event.url!, event.song!,null);
          //设置托盘提示信息
          trayManager.setToolTip(
              '${event.song!.name} -- ${event.song!.ar.first.name}');
          Global.getInstance()!.fire(
              ChangePlayIndex(index:AudioListController.playIndex,playAll: null,downSong: song));
        }
        if (event.playType == -1) {
          if (kDebugMode) {
            print("触发暂停时间");
          }
          pause();
        }
      }
    });

    listenAudioAndMv =
        Global.getInstance()!.on<ChangeAudioAndMvPlayState>().listen((event) {
          if (event.playMv != null && event.playMv! &&
              Global.audioPlayer.state == PlayerState.playing) {
            pause();
          }
        });

    listenAudioChange = Global.audioPlayer.onPositionChanged.listen((p) async {
//      ///提前获取下首歌的url
//      if ((p.inMilliseconds + 1000 * 15) > song!.dt) {
//        getSongUrl(AudioListController.playIndex + 1);
//      }
      // p参数可以获取当前进度，也是可以调整的，比如p.inMilliseconds
      nowTimeMs = double.parse(p.inMilliseconds.toString());
      CacheGlobalData.nowPlayMs =double.parse(p.inMilliseconds.toString());
      //滑动就不传输参数了
      if (slid == false) {
        streamController.sink.add({
          "text": CommUtils.formatMinSec(nowTimeMs.toInt()).trim(),
          "value": nowTimeMs
        });
      }
    });

    //一首歌播完
    listenAudioOver = Global.audioPlayer.onPlayerComplete.listen((e) async {
//      playSetState(() {
        playIng = false;
        musicPageController.playIng.value=playIng;
        nowTimeMs = 0;
        CacheGlobalData.nowPlayMs =0;
//      });

      ///循环播放
      if (settingModel.playingType.toInt() == 0) {
        playLoopOrMenu(true, false);
      }

      ///顺序播放
      if (settingModel.playingType.toInt() == 1) {
        playLoopOrMenu(false, false);
      }

      ///随机播放
      if (settingModel.playingType.toInt() == 2) {
        playAtRandom();
      }

      ///单曲循环
      if (settingModel.playingType.toInt() == 3) {
//        playSetState(() {
          playIng = false;
          musicPageController.playIng.value=playIng;
          nowTimeMs = 0;
//        });
        play(url!, song!,null);
      }

      debugPrint("播完了-------");
    });
  }


  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: AudioListController.playIndex == -1 ? true : false,
      child: MediaQuery(
        data: const MediaQueryData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Material(
            color: const Color.fromRGBO(30, 30, 31, 1),
            elevation: 5,
            child: GestureDetector(
              onTap: () {
                if (Get.isOverlaysOpen) {
                  Get.back();
                }
              },
              child: Container(
                height: 70,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(16, 138, 255, 0.1)
                ),
                child: Row(
                  textDirection: TextDirection.ltr,
                  children: [
                    //图标部分
                    Expanded(flex: 1, child:

                    StatefulBuilder(
                      builder: (BuildContext context,
                          void Function(void Function()) setState) {
                        playInfoSetState = setState;
                        String name = "";
                        if (song != null && song?.ar != null) {
                          for (var i = 0; i < song!.ar.length; i++) {
                            name +="${song!.ar[i].name}/";
                          }
                        }
                        if(name.isNotEmpty){
                          name= name.substring(0,name.length-1);
                        }
                        return Row(
                          children: [
                            GestureDetector(
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: StatefulBuilder(
                                  builder: (BuildContext context,
                                      void Function(void Function()) setState) {
                                    return MouseRegion(
                                      onEnter: (e) {
                                        showStack(setState);
                                      },
                                      onExit: (e) {
                                        closeStack(setState);
                                      },
                                      child: InkWell(
                                        onTap: (){
                                          Global.getInstance()!.fire(ChangeMusicFullIndex(1));
                                        },
                                        child: Stack(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          song?.al
                                                              .picUrl ??
                                                              CacheGlobalData
                                                                  .errorImg),
                                                      fit: BoxFit.cover
                                                  ),
                                                  borderRadius: const BorderRadius
                                                      .all(Radius.circular(5))
                                              ),
                                            ),
                                            Offstage(
                                              offstage: !show,
                                              child: Container(
                                                width: double.infinity,
                                                height: double.infinity,
                                                color: const Color.fromRGBO(
                                                    0, 0, 0, 0.5),
                                              ),
                                            ),
                                            Offstage(
                                              offstage: !show,
                                              child: const Center(
                                                  child: Icon(Icons
                                                      .keyboard_arrow_up_outlined,
                                                    color: Colors.white,
                                                    size: 25,)
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },

                                ),
                              ),
                            ),
                            const SizedBox (width: 10,),
                            //歌手和名称部分
                            Container(
                              height: 40,
                              constraints: const BoxConstraints(
                                  maxWidth: 100
                              ),
                              child: Column(
                                children: [
                                  //歌名称
                                  TextScroll(
                                    song?.name ?? "",
//                                mode: TextScrollMode.bouncing,
//                                velocity: const Velocity(pixelsPerSecond: Offset(150, 0)),
//                                delayBefore: Duration(milliseconds: 500),
//                                    numberOfReps: 5,
//                                pauseBetween: Duration(milliseconds: 50),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14),
//                                textAlign: TextAlign.right,
//                                selectable: true,
                                  ),
                                  const SizedBox(height: 5,),
                                  //歌手
                                  Expanded(child: TextScroll(name,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12),),)
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    )
                    ),
//                  const SizedBox(width: 40,),

                    //操作表
                    Center(
                      child: SizedBox(
                        width: 430,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                ///上一级
                                RotatedBox(
                                  quarterTurns: 2,
                                  child: InkWell(
                                    onTap: () {
                                      playUpSong();
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
                                      playIng = true;
                                      musicPageController.playIng.value=playIng;
                                    } else {
                                      Global.audioPlayer.pause();
                                      playIng = false;
                                      musicPageController.playIng.value=playIng;
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
                                    playDownSong();
                                  },
                                  child: const Icon(
                                    Icons.play_arrow, color: Colors.white,
                                    size: 20,),
                                )

                              ],
                            ),

                            Expanded(
                                child: Container(
                                    alignment: Alignment.center,
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
                                                      nowTimeMs.toInt())
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
                                                      song != null ? (song!.dt==0?"60000": song!.dt .toString() ) : "1"),
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
                                    ))),
                          ],
                        ),
                      ),
                    ),
//                  const SizedBox(width: 40,),


                    Expanded(flex: 1, child: Container(
                      margin: const EdgeInsets.only(right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Container()),
                          StatefulBuilder(

                            builder: (BuildContext context,
                                void Function(void Function()) setState) {
                              return InkWell(onTap: () {
                                changePlayType(setState);
                              },
                                child: Icon(
                                  iconList[settingModel.playingType
                                      .toInt()], color: Colors.white,
                                  size: 20,),
                              );
                            },

                          ),
                          const SizedBox(width: 25,),
                          InkWell(onTap: changeVolume,
                            child: const Icon(
                              XlIcons.xl_laba, color: Colors.white, size: 18,),
                          ),
                          const SizedBox(width: 25,),
                          InkWell(onTap: showPlayListDrawer,
                            child: const Icon(
                              XlIcons.xl_playlist, color: Colors.white,
                              size: 18,),
                          ),
                        ],
                      ),
                    ),)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  ///开始播放
  ///[seekTime] 跳转的时间
  play(String url, Song s,double ? seekTime) async {
    if (song == null) {
      setState(() {
        song = s;
        playIng = true;
        musicPageController.playIng.value=playIng;

      });
      streamController.sink.add({"text": "00:00", "value":  seekTime==null?0.0:seekTime.floor()});

      if(song!.rtype!=-1){
        Global.getInstance()!.fire(
            ChangeSong(song:s));
        Global.audioPlayer.play(UrlSource(url),position: seekTime==null?Duration.zero:Duration(milliseconds: seekTime.floor()));
      }else{
        Global.audioPlayer.play(DeviceFileSource(song!.rtUrl),position: seekTime==null?Duration.zero:Duration(milliseconds: seekTime.floor()));
        if(s.id==-1){
          Future.delayed(const Duration(milliseconds: 200), () async{
            var duration = await Global.audioPlayer.getDuration();
            s.dt =duration?.inMilliseconds ?? 1000*60;
            Global.getInstance()!.fire(
                ChangeSong(song:s));
          });
        }
      }
      return;
    }
    var state = Global.audioPlayer.state;
    if (state == PlayerState.paused && s.id == song!.id) {
      resume();
    } else {
      setState(() {
        song = s;
        playIng = true;
        musicPageController.playIng.value=playIng;
      });
      streamController.sink.add({"text": "00:00", "value":  seekTime==null?0.0:seekTime.floor()});

      if(song!.rtype!=-1){
        Global.getInstance()!.fire(
            ChangeSong(song:s));
        Global.audioPlayer.play(UrlSource(url),position: seekTime==null?Duration.zero:Duration(milliseconds: seekTime.floor()));
      }else{
        Global.audioPlayer.play(DeviceFileSource(song!.rtUrl),position: seekTime==null?Duration.zero:Duration(milliseconds: seekTime.floor()));
        if(s.id==-1){
          Future.delayed(const Duration(milliseconds: 200), () async{
            var duration = await Global.audioPlayer.getDuration();
            s.dt =duration?.inMilliseconds ?? 1000*60;
            Global.getInstance()!.fire(
                ChangeSong(song:s));
          });
        }      }
      var currentRoute = Get.currentRoute;
      if (currentRoute == "/MvPlayPage") {
        Global.getInstance()!.fire(ChangeAudioAndMvPlayState(playMp3: true));
      }
    }
  }

  ///[loop] true循环播放或者false 顺序播放
  ///[overZero]  是否到最后重新播放
  playLoopOrMenu(bool loop, bool overZero) async {
//    try{
    var playIndex = AudioListController.playIndex;

      if (playIndex + 1 >= AudioListController.playList.length) {
        if (!loop) {
          EasyLoading.showToast("播放完毕");
          return;
        }
      }
      playDownSong();
  }

  ///随机播放
  playAtRandom() async {
    var playIndex = randomNumbers(0, AudioListController.playList.length);
    Global.logger.d(
        "随机播放---播放的歌曲是--${AudioListController.playList[playIndex].name}");




    AudioListController.playIndex = playIndex;

    playInfoSetState(() {
      playIng = false;
      musicPageController.playIng.value=playIng;

      song = AudioListController.playList[playIndex];
      nowTimeMs = 0;
    });
      String ? isOk;

    if(AudioListController.playList[playIndex].rtype!=-1){
      isOk = await getSongUrl(playIndex);
    }
      //连接获取失败，重新随机
      if (isOk == null && AudioListController.playList[playIndex].rtype!=-1) {
        playAtRandom();
        return;
      }
      ///如果是本地文件播放
      if(AudioListController.playList[playIndex].rtype==-1){
        var exit = checkPath(AudioListController.playList[playIndex].rtUrl);
        if(exit){
          Global.audioPlayer.play(DeviceFileSource(AudioListController.playList[playIndex].rtUrl));
          if(AudioListController.playList[playIndex].id==-1){
            Future.delayed(const Duration(milliseconds: 200), () async{
              var duration = await Global.audioPlayer.getDuration();
              song!.dt =duration?.inMilliseconds ?? 1000*60;
            });
          }
        }else{
          //删除列表这个音乐
          AudioListController.playList.removeWhere((element) => element.rtUrl==AudioListController.playList[playIndex].rtUrl);
          playAtRandom();
          return;
        }
      }else{
        Global.audioPlayer.play(UrlSource(isOk!));
      }


      playIng = true;
      musicPageController.playIng.value=playIng;

    Global.getInstance()!.fire(
        ChangePlayIndex(index:AudioListController.playIndex,playAll: null,downSong: song));
    Global.getInstance()!.fire(
        ChangeSong(song: AudioListController.playList[playIndex]));
    var currentRoute = Get.currentRoute;
    if (currentRoute == "/MvPlayPage") {
      Global.getInstance()!.fire(ChangeAudioAndMvPlayState(playMp3: true));
    }
  }


  //生成区间随机数(包含前一位，不包含后一位)
  int randomNumbers(int min, int max) {
    final random = Random();
    var result = min + random.nextInt(max - min);
    return result;
  }


  ///上一首
  playUpSong() async {
    //如果是第一首，那么从最后循环播放
    if (AudioListController.playList.length >= 2) {
      var index = AudioListController.playIndex == 0 ? AudioListController
          .playList.length - 1 :
      AudioListController.playIndex - 1 < 0 ? AudioListController.playList
          .length - 1 : AudioListController.playIndex - 1;

      debugPrint("上一首的index是--------$index----总数量length----${AudioListController
          .playList.length}");
      String ? isOk;
      if(AudioListController.playList[index].rtype!=-1){
        isOk = await getSongUrl(index);
      }
      if (isOk != null || AudioListController.playList[index].rtype==-1) {
        AudioListController.playIndex = index;

        song = AudioListController.playList[index];

        playIng = true;
        musicPageController.playIng.value=playIng;

        nowTimeMs = 0;

        if(AudioListController.playList[index].rtype!=-1){
          Global.audioPlayer.play(UrlSource(isOk!));
          Global.getInstance()!.fire(
              ChangeSong(song: AudioListController.playList[index]));
          Global.getInstance()!.fire(
              ChangePlayIndex(index:AudioListController.playIndex,playAll: null,downSong: song));
        }else{
          var exit = checkPath(AudioListController.playList[index].rtUrl);
          if(exit){
            Global.audioPlayer.play(DeviceFileSource(AudioListController.playList[index].rtUrl));
            if(AudioListController.playList[index].id==-1){
              Future.delayed(const Duration(milliseconds: 200), () async{
                var duration = await Global.audioPlayer.getDuration();
                song!.dt =duration?.inMilliseconds ?? 1000*60;
              });
            }
            Global.getInstance()!.fire(
                ChangeSong(song: AudioListController.playList[index]));
            ChangePlayIndex(index:AudioListController.playIndex,playAll: null,downSong:AudioListController.playList[index]);

    }else{
            //删除列表这个音乐
            AudioListController.playList.removeWhere((element) => element.rtUrl==AudioListController.playList[index].rtUrl);
            playUpSong();
          }
        }

      } else {
        playIng = false;
        musicPageController.playIng.value=playIng;

        AudioListController.playIndex-=1;
        playUpSong();
        EasyLoading.showToast("播放歌曲失败,自动为您播放上一首");
      }
      setState(() {

      });
    }
  }


  ///下一首
  playDownSong() async {
    //如果是第最后一首，那么从第一首播放
    if (AudioListController.playList.length >= 2) {
      var index = AudioListController.playIndex ==
          AudioListController.playList.length - 1 ? 0 :
      AudioListController.playIndex + 1 > AudioListController.playList.length ?
      0 : AudioListController.playIndex + 1;

      debugPrint("下一首的index是--------$index----总数量length----${AudioListController
          .playList.length}");
      String ? isOk;
      if(AudioListController.playList[index].rtype!=-1){
        isOk = await getSongUrl(index);
      }
      if (isOk != null || AudioListController.playList[index].rtype==-1) {
        AudioListController.playIndex = index;

        song = AudioListController.playList[index];

        playIng = true;
        musicPageController.playIng.value=playIng;

        nowTimeMs = 0;

        if(AudioListController.playList[index].rtype!=-1){
          Global.audioPlayer.play(UrlSource(isOk!));

          Global.getInstance()!.fire(
              ChangePlayIndex(index:AudioListController.playIndex,playAll: null,downSong: song));
          Global.getInstance()!.fire(
              ChangeSong(song: AudioListController.playList[index]));
        }else{
          var exit = checkPath(AudioListController.playList[index].rtUrl);
          if(exit){
            Global.audioPlayer.play(DeviceFileSource(AudioListController.playList[index].rtUrl));
            if(AudioListController.playList[index].id==-1){
              Future.delayed(const Duration(milliseconds: 200), () async{
                var duration = await Global.audioPlayer.getDuration();
                song!.dt =duration?.inMilliseconds ?? 1000*60;
              });
            }
            Global.getInstance()!.fire(
                ChangeSong(song: AudioListController.playList[index]));
            Global.getInstance()!.fire(
                ChangePlayIndex(index:AudioListController.playIndex,playAll: null,downSong: AudioListController.playList[index]));
          }else{
            //删除列表这个音乐
            AudioListController.playList.removeWhere((element) => element.rtUrl==AudioListController.playList[index].rtUrl);
            playUpSong();
          }
        }

      } else {
        playIng = false;
        musicPageController.playIng.value=playIng;
        AudioListController.playIndex+=1;
        playDownSong();
        EasyLoading.showToast("播放歌曲失败,自动为您播放下一首");
      }
      setState(() {

      });
    }
  }


  ///获取音乐url
  ///[playIndex] 要获取的播放的索引
  Future<String ?> getSongUrl(int playIndex) async {
//    if (cacheIndex.contains(playIndex) == false) { //避免重复获取失败的url
//    var playUrlList = AudioListController.playUrlList;

    if (playIndex < AudioListController.playList.length) {
//      if (playUrlList[playIndex]?.url == null) { //去掉缓存，缓存超时url不可用
        var getList = await SongService.getSongListUrl(
            ids: [ AudioListController.playList[playIndex].id], level: null);

        if (getList != null && getList.isNotEmpty) {
//          AudioListController.playUrlList.removeAt(playIndex);
//          AudioListController.playUrlList.insert(playIndex, getList[0]);
          var playList = AudioListController.playList[playIndex];
          //设置托盘提示信息
          trayManager.setToolTip(
              '${playList.name} -- ${playList.ar.first.name}');

          return getList[0].url;
        } else {
          var playList = AudioListController.playList[playIndex];
          Global.logger.e(
              "歌曲url获取失败------歌曲id----${playList.id}----名字是----${playList
                  .name}----列表索引是----$playIndex");
          cacheIndex.add(playIndex);
          return null;
        }
//      } else {
//        return playUrlList[playIndex]!.url;
//      }
    }
//    }
    return null;
  }





  ///暂停播放
  pause() async {
    var state = Global.audioPlayer.state;
    if (state == PlayerState.playing) {
      Global.audioPlayer.pause();
    }
    playIng = false;
    musicPageController.playIng.value=playIng;

    song;
//    playSetState(() {});
  }

  ///恢复播放
  resume() async {
    await Global.audioPlayer.resume();
//    playSetState(() {
      song;
      playIng = true;
      musicPageController.playIng.value=playIng;

//    });
    playInfoSetState(() {});
  }

  ///滑动跳转
  seekSlid(double v) async {
    await Global.audioPlayer.seek(Duration(milliseconds: v.floor()));

    var state = Global.audioPlayer.state;
    if (state == PlayerState.paused || state == PlayerState.completed) {
      await resume();
    }
    slid = false;
    debugPrint("滑动结束了...");
  }


  void showStack(void Function(void Function() p1) setState) {
    show = true;
    setState(() {});
  }

  void closeStack(void Function(void Function() p1) setState) {
    show = false;
    setState(() {});
  }


  ///展示播放列表
  void showPlayListDrawer() async{
    var windowSize = await windowManager.getSize();
    debugPrint("高度是----$windowSize");
    if (Get.isOverlaysClosed) {
      Get.dialog(
          Stack(
            children: [
              Positioned(right: 0, bottom: 0, child:
              Container(
                color: const Color.fromRGBO(41, 41, 43, 1),
                width: 400,
                height: windowSize.height,
                child: SongList(id: AudioListController.recommendPlayId,
                  type: 0,
                  list: AudioListController.playList,
                  chuan: true,),
              ),
              )
            ],
          ),
          barrierColor: Colors.transparent
      );
    } else {
      Get.back();
    }
  }


  ///检查文件是否存在
 bool checkPath(String path){
    var file = File(path);
    return file.existsSync();
  }


  ///调整音量(0-1)0:静音，1：最大
  void changeVolume() {
    if (Get.isOverlaysClosed) {
      Get.dialog(
          Stack(
            children: [
              Positioned(
                right: 40,
                bottom: 5,
                child: StatefulBuilder(
                  builder: (BuildContext context,
                      void Function(void Function()) setStates) {
                    return Container(
                      width: 80,
                      height: 220,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Material(
                        color: const Color.fromRGBO(41, 41, 43, 1),
                        child: Column(
                          children: [
                            Expanded(child: SfSliderTheme(
                              data: SfSliderThemeData(
                                activeTrackHeight: 5,
                                inactiveTrackHeight: 5,
                                thumbRadius: 5,
                                activeDividerRadius: 15,
                                overlayRadius: 15,
                                //放上去的圆点大小
                                inactiveTrackColor: Colors.grey,
                                thumbColor: const Color.fromRGBO(
                                    31, 210, 169, 1),
                                activeTrackColor: const Color.fromRGBO(
                                    31, 210, 169, 1),
                              ),
                              child: SfSlider.vertical(
                                max: 100,
                                min: 0,
                                value: volume,
                                onChanged: (value) {
                                  setStates(() {
                                    volume = value;
                                    CacheGlobalData.globalVolume =volume;
                                    flagJin = value == 0 ? true : false;
                                    Global.audioPlayer.setVolume(value / 100);
                                  });
                                },
                              ),
                            )),
                            const SizedBox(height: 5,),
                            Text("${(volume).truncate()}%",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),),
                            const SizedBox(height: 5,),
                            const Divider(height: 1, color: Colors.blueGrey),
                            //静音
                            InkWell(
                              onTap: () {
                                setStates(() {
                                  if (!flagJin) {
                                    flagJin = true;
                                    CacheGlobalData.globalVolume =0;
                                    Global.audioPlayer.setVolume(0);
                                  } else {
                                    flagJin = false;
                                    Global.audioPlayer.setVolume(volume / 100);
                                  }
                                });
                              },
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                child: Icon(Icons.volume_mute,
                                  color: flagJin ? Colors.red : Colors.white,),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },

                ),

              ),
            ],
          )
      );
    } else {
      Get.back();
    }
  }

  ///改变mp3播放方式
  void changePlayType(setStates) {
    if (Get.isOverlaysClosed) {
      Get.dialog(
          Stack(
            children: [
              Positioned(
                right: 80,
                bottom: 5,
                child: StatefulBuilder(
                  builder: (BuildContext context,
                      void Function(void Function()) setState) {
                    return Container(
                      width: 100,
                      height: 180,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Material(
                        color: const Color.fromRGBO(41, 41, 43, 1),
                        child: Column(
                          children: [
                            Expanded(child:
                            InkWell(
                              onTap: () {
                                setStates(() {
                                  settingModel.playingType = 0;
//                                  AudioListController.playingType = 0;
                                  Get.back();
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(iconList[0], color: Colors.white,
                                    size: 15,),
                                  const SizedBox(width: 15,),
                                  const Text("列表循环", style: TextStyle(
                                      color: Colors.white, fontSize: 13),),
                                ],
                              ),
                            )
                            ),
                            const Divider(color: Colors.black12, height: 1,),
                            Expanded(child:
                            InkWell(
                              onTap: () {
                                setStates(() {
                                  settingModel.playingType = 1;
//                                  AudioListController.playingType = 1;

                                });
                                Get.back();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(iconList[1], color: Colors.white,
                                    size: 15,),
                                  const SizedBox(width: 15,),
                                  const Text("顺序播放", style: TextStyle(
                                      color: Colors.white, fontSize: 13),),
                                ],
                              ),
                            )
                            ),
                            const Divider(color: Colors.black12, height: 1,),

                            Expanded(child:
                            InkWell(
                              onTap: () {
                                setStates(() {
                                  settingModel.playingType = 2;
//                                  AudioListController.playingType = 2;
                                  Get.back();
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(iconList[2], color: Colors.white,
                                    size: 15,),
                                  const SizedBox(width: 15,),
                                  const Text("随机播放", style: TextStyle(
                                      color: Colors.white, fontSize: 13),),
                                ],
                              ),
                            )
                            ),
                            const Divider(color: Colors.black12, height: 1,),

                            Expanded(child:
                            InkWell(
                              onTap: () {
                                setStates(() {
                                  settingModel.playingType = 3;
//                                  AudioListController.playingType = 3;
                                  Get.back();
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(iconList[3], color: Colors.white,
                                    size: 15,),
                                  const SizedBox(width: 15,),
                                  const Text("单曲循环", style: TextStyle(
                                      color: Colors.white, fontSize: 13),),
                                ],
                              ),
                            )
                            )
                          ],
                        ),
                      ),
                    );
                  },

                ),

              ),
            ],
          )
      );
    } else {
      Get.back();
    }
  }


  @override
  void dispose() {
    super.dispose();
    Global.audioPlayer.dispose();
    streamController.close();
    listenAudio.cancel();
    listenAudioAndMv.cancel();
    listenAudioChange.cancel();
    listenAudioOver.cancel();
  }


}
