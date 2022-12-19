import 'dart:async';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bruno/bruno.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:qq_music/const/global.dart';
import 'package:qq_music/controller/audio_list_controller.dart';
import 'package:qq_music/controller/down_del/down_del_model.dart';
import 'package:qq_music/model/down/down_model.dart';
import 'package:qq_music/model/event/event_model.dart';
import 'package:qq_music/model/song/song_list_details.dart';
import 'package:qq_music/page/song_user/album_details_page.dart';
import 'package:qq_music/page/song_user/song_user.dart';
import 'package:qq_music/utils/Global.dart';
import 'package:qq_music/utils/commutils.dart';



class DownOverPage extends StatefulWidget {
  const DownOverPage({Key? key}) : super(key: key);

  @override
  _DownOverPageState createState() => _DownOverPageState();
}

class _DownOverPageState extends State<DownOverPage> with AutomaticKeepAliveClientMixin{
  Song ? downSong;

  List<DownModel> downOver = [];
  ///转换后的数据
  List<Song> parseList = [];
  late StreamSubscription downOverListen;

  late StreamSubscription  listen;

  @override
  void initState() {
    super.initState();
    downOver.addAll( DownDelControllerModel.downOverList);

    if(AudioListController.playIndex!=-1){
      var play= AudioListController.playList[AudioListController.playIndex];
      if(play.rtype==-1){
          downSong =play;
      }
    }

    downOverListen = Global.getInstance()!.on<ChangeDownOver>().listen((event) {
          if(mounted){
            setState(() {
              downOver = DownDelControllerModel.downOverList;
            });
          }
        });
    listen = Global.getInstance()!.on<ChangePlayIndex>().listen((event) {
      if(mounted && event.downSong!=null){
        setState(() {
          downSong =event.downSong;
        });
      }
    });
    parseData();
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Material(
      color: const Color.fromRGBO(30, 30, 31, 1),
      child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              SizedBox(
                height: 80,
                child: Row(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: payAllSong,
                      child: Container(
                        width: 110,
                        height: 35,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            gradient:LinearGradient(
                                colors: [
                                  Color.fromRGBO(31, 210, 170, 1),
                                  Color.fromRGBO(31, 209, 163, 1),
                                  Color.fromRGBO(30, 205, 152, 1),
                                ]
                            )
                        ),
                        child:  const Text("播放全部",style: TextStyle(color: Colors.white,fontSize: 15),),
                      ),
                    ),
                    const   SizedBox(width: 10,),

                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: addFileSong,
                      child: Container(
                        width: 110,
                        height: 35,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Color.fromRGBO(52, 52, 53, 1)
                        ),
                        child:  const Text("添加歌曲",style: TextStyle(color: Colors.white,fontSize: 15),),
                      ),
                    ),
                    const   SizedBox(width: 10,),
//                    Expanded(child: Container()),
                    InkWell(
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: (){
                        if(downOver.isEmpty){
                          EasyLoading.showToast("列表为空，无需清除");
                          return;
                        }
                        BrnDialogManager.showConfirmDialog(context,
                            title: "提示",
                            cancel: '取消',
                            confirm: '确定',
                            message: "您是否选择清空已下载歌曲。", onConfirm: () {
                              Get.back();
                              dealAllSong();
                            }, onCancel: () {
                              Get.back();
                            });

                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 130,
                        height: 35,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Color.fromRGBO(52, 52, 53, 1)
                        ),
                        child: const Text("清空全部",
                          style: TextStyle(color: Colors.white, fontSize: 15),),
                      ),
                    )
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text("歌曲",
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                            textScaleFactor: 1),
                      ),
                    ),

                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text("歌手",
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                            textScaleFactor: 1),
                      ),
                    ),

                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text("专辑",
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                            textScaleFactor: 1),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text("大小",
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                            textScaleFactor: 1),
                      ),
                    ),
                  ],
                ),
              ),

              //下载列表
              Expanded(child:ListView.builder(addAutomaticKeepAlives: true,
                itemCount:   downOver.length,
                itemBuilder: (context, index) {
                  return StatefulBuilder(
                    builder: (BuildContext context,
                        void Function(void Function()) setStates) {
                      return Container(
                        height: 40,
                        margin: const EdgeInsets.only(
                            top: 5, bottom: 5, left: 15, right: 15),
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onDoubleTap: () {

                          },
                          child: GestureDetector(
                            onDoubleTap: (){
                              doublePayAllSong(index);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //名称
                                Expanded(
                                    flex: 3,
                                    child:  Container(
                                      constraints: const BoxConstraints(
                                          minWidth: 50, maxWidth: 500),
                                      child: AutoSizeText(
                                        downOver[index].songName,
                                        style:  TextStyle(
                                            color: (downSong?.rtUrl ==downOver[index].absolutePath)?Colors.greenAccent: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w200),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        minFontSize: 11,
                                      ),
                                    )
                                ),
                                const SizedBox(width: 10,),
                                // 歌手
                                Expanded(
                                  flex: 2,
                                  child: InkWell(
                                    hoverColor: Colors.transparent,
                                    onTap: (){
                                      var model =downOver[index];
                                      if(model.songId!=-1){
                                        Get.to(()=> SongUser(id: model.songUserId,username: model.songUserName,),transition: Transition.rightToLeft);
                                      }else{
                                        EasyLoading.showToast("外部歌曲，无法前往");
                                      }
                                    },
                                    child: Container(
                                        margin: const EdgeInsets.only(right: 7),
                                        alignment: Alignment.centerLeft,
                                        child: AutoSizeText(downOver[index].songUserName
                                          , textScaleFactor: 1,
                                          minFontSize: 11,
                                          style:  TextStyle(
                                              color: (downSong?.rtUrl ==downOver[index].absolutePath)?Colors.greenAccent: Colors.white,
                                               fontSize: 13),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,

                                        )
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                // 专辑
                                Expanded(
                                  flex: 2,
                                  child: InkWell(
                                    hoverColor: Colors.transparent,
                                    onTap: (){
                                      var model =downOver[index];
                                      if(model.songId!=-1){
                                        Get.to(()=>AlbumDetailsPage(id:model.albumId,
                                          createTime: 0, name:model.albumName,
                                          picUrl: model.cover, username:model.songUserName,
                                          uid: model.songUserId,),transition: Transition.rightToLeft);
                                      }else{
                                        EasyLoading.showToast("外部歌曲，无法前往");
                                      }
                                    },
                                    child: Container(
                                        margin: const EdgeInsets.only(right: 7),
                                        alignment: Alignment.centerLeft,
                                        child: AutoSizeText(downOver[index].albumName
                                          , textScaleFactor: 1,
                                          minFontSize: 11,
                                          style:  TextStyle(
                                              color: (downSong?.rtUrl ==downOver[index].absolutePath)?Colors.greenAccent: Colors.white,
                                              fontSize: 13),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,

                                        )
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                //大小
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 7),

                                    alignment: Alignment.centerLeft,
                                    child:  Text(downOver[index].size ?? "未知" ,style: TextStyle(
                                      color: (downSong?.rtUrl ==downOver[index].absolutePath)?Colors.greenAccent: Colors.white,
                                    ),),
                                  ),
                                )

                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },)
              )
            ],
          )
      ),
    );
  }
  ///播放全部
  void payAllSong() async{
      startPlay();
  }
  ///双击播放
  ///[index] 点击的索引
  void doublePayAllSong(int index) async{
    AudioListController.recommendPlayId=-1;
    if(settingModel.playingList){
      startPlay(index: index);
    }else{
      AudioListController.playIndex=0;
      AudioListController.playList.length=0;
      AudioListController.playList.add(parseList[index]);
      Global.getInstance()!.fire(AudioPlayEvent(playMs:0, playUrl:parseList[index].rtUrl,showController:true,showAutoPlay:true));
      setState(() {
        downSong =parseList[index];
      });
    }

  }

  ///解析数据
  parseData() async{
    parseList.length=0;
    for(var i=0;i<downOver.length;i++){
      Song song =Song(name: downOver[i].songName, id:downOver[i].songId,rtUrl:  downOver[i].absolutePath,rtype: -1,
          ar:[Ar(id: downOver[i].songUserId, name: downOver[i].songUserName) ] ,
          fee: 0 , al: Al(id:  downOver[i].albumId, name:  downOver[i].albumName, pic: 0,picUrl:downOver[i].cover), dt:downOver[i].duration==0?10:downOver[i].duration, mv: 0);
      parseList.add(song);
    }
  }

  ///播放全部
  void startPlay({int ? index}) async{
    index ??=0;

    AudioListController.playIndex=index;
    AudioListController.playList.length=0;
    AudioListController.playList.addAll(parseList);
    //去重
    final ids = AudioListController.playList.map((e) => e.rtUrl).toSet();
    AudioListController.playList.retainWhere((x) => ids.remove(x.rtUrl));

    Global.getInstance()!.fire(AudioPlayEvent(playMs:0, playUrl:parseList[index].rtUrl,showController:true,showAutoPlay:true));
    setState(() {
      downSong =parseList[index!];
    });
  }

  ///清空全部的下载记录
  void dealAllSong() async{
    EasyLoading.show(status: "请稍等..",dismissOnTap: false,maskType: EasyLoadingMaskType.black);

    Directory dir= Directory("${settingModel.downUrl}\\");

    try{
      if(!dir.existsSync()){
        EasyLoading.showToast("系统目录不存在");
        return;
      }

      // recursive是否递归列出子目录 followLinks是否允许link
      await dir.list(recursive: true).toList().then((value){
        for(var i=0;i<value.length;i++){
          if(value[i].absolute.toString().contains(".mp3")){
            value[i].delete();
          }
        }
      });
      setState(() {
        DownDelControllerModel.downOverList.length=0;
        downOver.length=0;
      });
      EasyLoading.showToast("文件已清空");
    }catch(e){
      Global.logger.e(e);
      EasyLoading.showToast("文件清理失败");
    }
  }



  ///手动添加歌曲
  void addFileSong() async{
    const XTypeGroup musicTypeGroup = XTypeGroup(
      label: 'music',
      extensions: ['mp3', 'ape','m4a']
    );
    final List<XFile> files = await openFiles(acceptedTypeGroups: <XTypeGroup>[
      musicTypeGroup,
    ]);
    if(files.isNotEmpty){
      for(var i=0;i<files.length;i++){
        var path = files[i].path;
        ///根据路和名字径先判断下载列表是否存在
        var indexWhere = downOver.indexWhere((element) => element.absolutePath==path);
        var fileName = path.split("\\")[path.split("\\").length-1];
        var index = downOver.indexWhere((element) => element.songName==fileName);
        if(indexWhere>-1 || index>-1){
          debugPrint("$path已经存在了");
          continue;
        }

        ThisProjectUtils.getDownMusicInfo(path: files[i].path);
        copyFile(files[i],fileName);
      }
    }
  }

  ///复制所选文件到下载文件
  copyFile(XFile xFile,String fileName) async{
    Directory directory = Directory("${settingModel.downUrl}\\");
    if(directory.existsSync()==false){
      //不存在那么就先创建
      directory.createSync();
    }
    var file = File(xFile.path);
    file.copy("${settingModel.downUrl}\\$fileName");
  }
  
  @override
  void dispose() {
    super.dispose();
    downOverListen.cancel();
    listen.cancel();
  }

  @override
  bool get wantKeepAlive => true;


}




