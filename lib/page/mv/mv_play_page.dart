import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:qq_music/const/global.dart';
import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/model/event/event_model.dart';
import 'package:qq_music/model/mv/mv_details.dart';
import 'package:qq_music/model/mv/mv_play_url.dart';
import 'package:qq_music/model/mv/mv_simli_model.dart';
import 'package:qq_music/page/song_user/song_user.dart';
import 'package:qq_music/service/mv/mv_service.dart';
import 'package:qq_music/utils/Global.dart';
import 'package:qq_music/utils/HttpUtil.dart';
import 'package:qq_music/utils/commutils.dart';
import 'package:qq_music/utils/my_widget/CusBehavior.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:window_manager/window_manager.dart';

///[index] 第一个mv的id
///[mvDetailsModelList] 获取的mv的列表页面
///[mvId]点击歌曲的mv进来的
///mv的播放界面
class MvPlayPage extends StatefulWidget {
  final int ? mvId;
  final int index;
  final List<MvDetailsModel>  mvDetailsModelList;

  const MvPlayPage({Key? key, required this.index, required this.mvDetailsModelList,this.mvId})
      : super(key: key);

  @override
  State createState() => _MvPlayPageState();
}

class _MvPlayPageState extends State<MvPlayPage> {
  List<SimilarMvModel> list = [];


  JustTheController justTheController = JustTheController();

  final playlist = Playlist(
    medias: [
      Media.network('https://www.example.com/music.aac'),
    ],
  );

  //列表播放的index
  int playListIndex =0;
  //播放的列表
  List<MvDetailsModel>  mvDetailsModelList =[];
  List<double> speedList = [0.5, 1.0, 1.25, 1.5, 2.0];
  int speedIndex =1;
  ///传过来的播放列表
  List<Media> mvMediaList =[];

  ///播放设置 (1---列表循环，-1：循环播放)
  int type =1;
  ///总时长
  double allTimeSeconds = 1; //总时长的秒数
  String startTime = "00:00";
  String endTime = "00:00";
  Timer? _timer; //控制定时器
  ///当前播放位置
  int nowTimeSeconds = 0; //当前位置的秒数
  double maxSize =1; //最大毫秒数
  bool slideChange = false;
  late  StateSetter playState;
  ///是否正在播放中
 bool playIng =false;
  ///是否展示控件
  bool showControllers =true;
  double initVolume = 50; //初始音量
  int hideSec = 5; //倒计时时间
  //播放出现错误
  bool error =false;
  late  StreamSubscription  listen;
  late  StreamSubscription  listenState;
  late  StreamSubscription  listenStatePosition;

  //创建StreamController
  final StreamController<dynamic> streamController = StreamController<dynamic>.broadcast();
  @override
  void initState() {
    super.initState();


    Future.delayed(Duration.zero, () {
      if(widget.mvId==null){
        mvDetailsModelList =widget.mvDetailsModelList;
        playListIndex =widget.index;
        endTime =CommUtils.formatMinSec(widget.mvDetailsModelList[playListIndex].duration);
        maxSize =double.parse(widget.mvDetailsModelList[playListIndex].duration.toString()) ;
        getMvUrl(widget.mvDetailsModelList[widget.index].id);
      }else{
        getMvUrl(widget.mvId!);
//    getSimilarMvInfo(widget.mvDetailsModelList[widget.index].id);

      }
    });


    listen =  Global.getInstance()!.on<ChangeAudioAndMvPlayState>().listen((event) {
      if(event.mvId!=null){
        getMvUrl(event.mvId!);
      }
      if(event.playMp3!=null && event.playMp3! && playIng){
        player.pause();
        playIng =false;
        playState((){});
      }
    });



    //监听播放状态
     listenState = player.playbackStream.listen((PlaybackState state) {
      //暂停中
      if(state.isPlaying==false && state.isPlaying!=playIng){
        playIng =false;
        playState((){});
      }
      //播放中
      if(state.isPlaying && state.isPlaying!=playIng){
        Global.getInstance()!.fire(ChangeAudioAndMvPlayState(playMv: true));
        playIng =true;
        playState((){});
      }
      //播放完成处理下个视频后播放
      if(state.isCompleted){
        debugPrint("视频播放完毕---${player.current.media?.resource}-----索引是$playListIndex");
        if(type==1){
          playListIndex++;
          if(playListIndex<mvDetailsModelList.length){
              playMv(playListIndex);
            }else{
              playListIndex=0;
              playMv(0);
            }
        }else{
          playMv(playListIndex);
        }
      }
    });

    //监听实时位置
    listenStatePosition=  player.positionStream.listen((PositionState state) {
      if(slideChange==false){
        nowTimeSeconds = state.position?.inMilliseconds ?? 0;
        var time = CommUtils.formatMinSec( state.position?.inMilliseconds ?? 0);
        streamController.sink
            .add({"text": time, "value": nowTimeSeconds});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(15),
      color: const Color.fromRGBO(30, 30, 31, 1),
      child: ListView(
        children: [

          //视频
          MouseRegion(
            onExit: (e){
              if(playIng==true){
                hideControls();
              }
            },
            onHover: (e){
              if(showControllers==false){
                setState(() {
                  showControllers=true;
                });
              }
            },
            child: Container(
              height: MediaQuery.of(context).size.width/2*0.75,
              color: Colors.black,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  //视频部分
                  GestureDetector(
                    onTap:(){
                      if(playIng==true){
                        setState(() {
                          showControllers=true;
                        });
                      }
                      player.playOrPause();
                    },
                    child: SizedBox(
                      child:  Video(
                        player: player,
                        height: 1920.0,
                        width: 1080.0,
                        scale: 1.0,
                        // default
                        showControls: false, // default
                      ),
                    ),
                  ),

                  //视频控件
                  Offstage(
                    offstage: (showControllers)?false:true,
                    child:       Container(
                        margin: const EdgeInsets.only(left: 20,right: 20),
                        child: Column(
                          children: [
                            Expanded(child: Container()),
                            StreamBuilder(
                              stream: streamController.stream,
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic>
                                  snapshot) {
                                return Row(
                                  children: [
                                    Text(
                                      snapshot.hasData
                                          ? snapshot
                                          .data['text']
                                          :startTime,
//                                  CommUtils.formatDuration(Duration(milliseconds: player.position.position?.inMilliseconds ?? 0)),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13),
                                      textScaleFactor: 1,
                                    ),
                                    Expanded(
                                      child: SfSliderTheme(
                                        data:SfSliderThemeData(
                                          activeTrackHeight:2,
                                          inactiveTrackHeight:2,
                                          thumbRadius: 5,
                                          activeDividerRadius: 15,
                                          overlayRadius: 15, //放上去的圆点大小
                                          inactiveTrackColor: Colors.grey,
                                          thumbColor:const Color.fromRGBO(31, 210, 169, 1),
                                          activeTrackColor:const Color.fromRGBO(31, 210, 169, 1),
                                        ),
                                        child: SfSlider(
                                          max: maxSize,
                                          min: 0,
                                          showTicks: false,
                                          tooltipTextFormatterCallback:(dy,value){
                                            var formatDuration = CommUtils.formatMinSec(int.parse(value.split(".")[0]));
                                            return formatDuration;
                                          },
                                          showLabels: false,
                                          enableTooltip: true,
                                          value:
                                          snapshot.hasData
                                              ? (snapshot.data[
                                          'value'] >
                                              player.position.duration?.inMilliseconds.toDouble()
                                              ?   player.position.duration?.inMilliseconds.toDouble()
                                              : snapshot.data[
                                          'value'])
                                              : player.position.duration?.inMilliseconds.toDouble(),
                                          onChangeStart: (v) {
                                            slideChange = true;
                                          },
                                          onChanged: (dynamic value) {
                                            startTime = CommUtils.formatMinSec(value.floor());
                                            streamController
                                                .sink
                                                .add({
                                              "text": startTime,
                                              "value": value
                                            });
                                            nowTimeSeconds = value.floor();
                                          },
                                          onChangeEnd: (v) {
                                            player.seek(Duration(milliseconds:  v.floor()));
                                            if(playIng==false){
                                              player.play();
                                              playIng=true;
                                              playState((){});
                                            }
                                            slideChange = false;
                                          },
                                        ),
                                      ),
                                    ),
                                    //最右边的时间
                                    Text(
                                      endTime,
                                      style: const TextStyle(color: Colors.white, fontSize: 13),
                                      textScaleFactor: 1,
                                    ),
                                  ],
                                );
                              },
                            ),

                            StatefulBuilder(
                              builder: (BuildContext context, void Function(void Function()) setState) {
                                playState =setState;
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 5,top: 5,right: 5),
                                  child:  Row(
                                    children: [
                                      //播放按钮
                                      InkWell(
                                        onTap: () {
                                          if(playIng){
                                            player.pause();
                                            playIng=false;
                                          }else{
                                            player.play();
                                            playIng=true;
                                          }
                                          playState((){

                                          });
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(left: 10, right: 10),
                                          alignment: Alignment.center,
                                          child:  Icon(
                                            playIng?Icons.pause:Icons.play_arrow,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      //下一集
                                      InkWell(
                                        onTap: nextSkip,
                                        child: Container(
                                          alignment: Alignment.bottomCenter,
                                          child: const Icon(
                                            Icons.skip_next,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      const SizedBox(
                                        width: 10,
                                      ),

                                      //音量
                                      JustTheTooltip(
                                          controller: justTheController,
                                          isModal: true,
                                          tailLength:10,
                                          barrierDismissible: true,
                                          margin: const EdgeInsets.only(right: 0,bottom: 150),
                                          tailBaseWidth: 10,
                                          preferredDirection: AxisDirection.down,
                                          content: StatefulBuilder(
                                            builder: (BuildContext context, void Function(void Function()) setStates) {
                                              return Container(
                                                width: 50,
                                                height: 100,
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                                ),
                                                child: Material(
                                                  color:const Color.fromRGBO(41, 41, 43, 1),
                                                  child: SfSliderTheme(
                                                    data:  SfSliderThemeData(
                                                      activeTrackHeight:5,
                                                      inactiveTrackHeight:5,
                                                      thumbRadius: 5,
                                                      activeDividerRadius: 15,
                                                      overlayRadius: 15, //放上去的圆点大小
                                                      inactiveTrackColor: Colors.grey,
                                                      thumbColor:const Color.fromRGBO(31, 210, 169, 1),
                                                      activeTrackColor:const Color.fromRGBO(31, 210, 169, 1),
                                                    ),
                                                    child: SfSlider.vertical(
                                                      max: 100,
                                                      min: 0,
                                                      value: initVolume,
                                                      onChanged: ( value) {
                                                        setStates((){
                                                          initVolume =value;
                                                          player.setVolume(value/100);
                                                        });
                                                      },
                                                      onChangeEnd: (e){
                                                        justTheController.hideTooltip();
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          child:const Icon(Icons.volume_mute,color: Colors.white,)
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),

                                      //下载
                                      IconButton(
                                        tooltip:"MV下载",
                                        onPressed:downMv,icon: const Icon(Icons.download_rounded,color: Colors.white,size: 20,)  ,),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      //播放设置循环
                                      IconButton(
                                        tooltip:type==1?"列表循环":"循环播放",
                                        onPressed: (){
                                        playState((){
                                          type==1?type=-1:type=1;
                                        });
                                      },icon: Icon(type==1?Icons.menu: Icons.cyclone,color: Colors.white,size: 20,)  ,),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      //倍速
                                      TextButton(
                                        onPressed: () {
                                          setState((){
                                            speedIndex++;
                                            if(speedIndex<speedList.length){
                                              player.setRate(speedList[speedIndex]);
                                            }else{
                                              speedIndex=0;
                                              player.setRate(speedList[speedIndex]);
                                            }
                                          });
                                        },
                                        child: Text(
                                          speedIndex==1?"倍速": "${speedList[speedIndex]}x",
                                          textScaleFactor: 1.0,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),

                                      const SizedBox(
                                        width: 20,
                                      ),

                                    ],
                                  ),
                                );
                              },
                            )
                          ],
                        )
                    ),
                  )



                ],
              ),
            ),
          ),


          //相似的MV
          Offstage(
            offstage: mvDetailsModelList.isNotEmpty?false:true,
            child:  Container(
              margin: const EdgeInsets.only(left: 20,right: 20,top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(mvDetailsModelList.isNotEmpty? mvDetailsModelList[playListIndex].name:"未知",style: const TextStyle(color: Colors.white,fontSize: 16),),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      const Text("来自",style: TextStyle(color: Colors.grey,fontSize: 13),),
                      InkWell(
                          onTap: (){
                            player.pause();
                            var mv = mvDetailsModelList[playListIndex>=mvDetailsModelList.length?mvDetailsModelList.length-1:playListIndex];

                            Get.to(SongUser(id:mv.artistId ?? 0, username:mv.artistName));
                          },
                          child: Text(" ${
                              mvDetailsModelList.isNotEmpty? mvDetailsModelList[playListIndex>=mvDetailsModelList.length?mvDetailsModelList.length-1:playListIndex].artistName:"佚名"}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14))),
                      const SizedBox(width: 10,),

                      const Text(" 观看数 ",style: TextStyle(color: Colors.grey,fontSize: 13)),
                      Text( mvDetailsModelList.isNotEmpty?mvDetailsModelList[playListIndex>=mvDetailsModelList.length?mvDetailsModelList.length-1:playListIndex].playCount > 10000
                          ? "${(mvDetailsModelList[playListIndex>=mvDetailsModelList.length?mvDetailsModelList.length-1:playListIndex].playCount / 10000).truncate()}万"
                          :  mvDetailsModelList[playListIndex>=mvDetailsModelList.length?mvDetailsModelList.length-1:playListIndex].playCount.toString():"0",
                        style: const TextStyle(
                            color: Colors.grey, fontSize: 13),),
                    ],
                  ),

                  const SizedBox(height: 20,),
                  ScrollConfiguration(
                    behavior: CusBehavior(),
                    child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: mvDetailsModelList.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          /// 纵轴间距
                          mainAxisSpacing: 20.0,

                          /// 横轴间距
                          crossAxisSpacing: 30.0,

                          /// 横轴元素个数
                          crossAxisCount: 4,

                          /// 宽高比
                          childAspectRatio: 0.9,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              if(playListIndex!=index){
                                playListIndex=index;
                                playMv(index);
                              }
                            },
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        SizedBox(
                                            width: double.infinity,
                                            height: constraints.biggest.height - 50,
                                            child: ExtendedImage.network(
                                              mvDetailsModelList[index].picUrl==null?
                                              (mvDetailsModelList[index].imgurl ==null?  mvDetailsModelList[index].cover ?? CacheGlobalData.errorImg :  mvDetailsModelList[index].imgurl!)
                                                  : mvDetailsModelList[index].picUrl!,
                                              fit: BoxFit.fill,
                                              cache: true,
                                              height: constraints.biggest.height - 45,
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
                                                  mvDetailsModelList[index].playCount > 10000
                                                      ? "${(mvDetailsModelList[index].playCount / 10000).truncate()}万"
                                                      : mvDetailsModelList[index].playCount.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white, fontSize: 13),
                                                ),
                                              ],
                                            )),
                                        Positioned(
                                          right: 5,
                                          bottom: 5,
                                          child: Text(
                                            CommUtils.formatMinSec(mvDetailsModelList[index].duration),
                                            style: const TextStyle(
                                                color: Colors.white, fontSize: 13),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 30,
                                      child: AutoSizeText(
                                        mvDetailsModelList[index].name,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 15),
                                        textScaleFactor: 1,
                                        minFontSize: 12,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          )


        ],
      ),
    );
  }
  ///视频处于播放状态，hideSec秒后隐藏控制器
  hideControls() {
    if (showControllers) {
      _timer = Timer(Duration(seconds: hideSec), () {
        if(mounted){
          setState(() {
            showControllers=false;
          });
        }
      });
    }
  }


  ///获取第一个Mv的链接
  void getMvUrl(int id) async {
    MvPlayUrlModel? mvPlayUrl = await  MvService.getMvPlayUrl(id: id);
    if (mvPlayUrl != null) {
      if(mvPlayUrl.url!=null){

        if(widget.mvId==null){
          final media = Media.network(
            mvPlayUrl.url,
          );
          for(var i=0;i<mvDetailsModelList.length;i++){
            mvMediaList.add(media);
          }
          getOtherMvUrl();
          playMv(widget.index);
        }else{
          getMvDetailsInfo(id,mvPlayUrl.url!);
        }
      }else{
        error=true;
      }
    }
  }

  getMvDetailsInfo(int id,String url) async{
    mvDetailsModelList.length=0;

    MvDetailsModel ? mvDetailsModel = await MvService.getMvDetailsInfo(mvid:id);
    mvMediaList.add(Media.network(url));
    player.open(Media.network(url),autoStart: true);
    if(mvDetailsModel!=null){
      setState(() {
        mvDetailsModelList.add(mvDetailsModel);
        playIng=true;
        endTime =CommUtils.formatMinSec(mvDetailsModel.duration);
        maxSize =double.parse(mvDetailsModel.duration.toString()) ;
        streamController.sink
            .add({"text": "00:00", "value": 1.0});
      });
    }
  }

  ///获取其他的MV的链接
  void getOtherMvUrl() async {

      for(var i =0;i<mvDetailsModelList.length;i++){
        if(i!=widget.index){
          MvPlayUrlModel? mvPlayUrl = await MvService.getMvPlayUrl(id: mvDetailsModelList[i].id);
          if (mvPlayUrl != null) {
            if(mvPlayUrl.url!=null){
              final media = Media.network(
                mvPlayUrl.url,
              );
              mvMediaList.removeAt(i);
              mvMediaList.insert(i, media);
            }else{
              var me =  Media.network(
                CacheGlobalData.errorVideoUrl,
              );
              mvMediaList.removeAt(i);
              mvMediaList.insert(i, me);
            }
          }
        }
      }




  }

//  ///获取相似的mv
//  void getSimilarMvInfo(int id) async {
//    var getList = await MvService.getSimilarMvInfo(mvid:id);
//    if (getList != null) {
//        setState(() {
//          list =getList;
//        });
//    }
//  }


  ///下一集
  void nextSkip() async{
    playListIndex++;
    if(playListIndex<mvDetailsModelList.length){
      playMv(playListIndex);
    }else{
      playListIndex=0;
      playMv(0);
    }
  }

  ///播放MV
  ///[index] 要播放的列表索引
  playMv(int index) async{
    setState(() {
      player.open(mvMediaList[index],autoStart: true);
      playIng=true;
      endTime =CommUtils.formatMinSec(mvDetailsModelList[index].duration);
      maxSize =double.parse(mvDetailsModelList[index].duration.toString()) ;
      streamController.sink
          .add({"text": "00:00", "value": 1.0});
    });
  }

  ///下载mv
  downMv() async{
    var song = mvDetailsModelList[playListIndex];
    //获取下载方式(音乐和mv命名格式(0--歌曲名，1--歌手-歌曲名，2--歌曲名-歌手))
    var musicDownName = settingModel.musicDownName;
    String names = "${song.name}.mp4";
    if(musicDownName==1){
      names = "${song.artistName} - ${song.name}.mp4";
    }
    if(musicDownName==1){
      names = "${song.name} - ${song.artistName}.mp4";
    }
    DioUtils().downFile(mvMediaList[playListIndex].resource,names, true);
  }

  ///播放设置
  void menuPlay() async{

  }

  @override
  void dispose() {
    super.dispose();
    if(playIng){
      player.pause();
    }
    player.dispose();
    justTheController.dispose();
    streamController.close();
    listen.cancel();
    listenStatePosition.cancel();
    listenState.cancel();

    if(_timer!=null && _timer!.isActive){
      _timer!.cancel();
    }
  }

  ///全屏
  void screen() async{
    bool fullScreen = await windowManager.isFullScreen();
    fullScreen? windowManager.setFullScreen(false): windowManager.setFullScreen(true);
  }




}
