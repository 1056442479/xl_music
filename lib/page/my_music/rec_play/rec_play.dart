

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/controller/audio_list_controller.dart';
import 'package:qq_music/model/event/event_model.dart';
import 'package:qq_music/model/song/rec_play_song_model.dart';
import 'package:qq_music/model/song/song_list_details.dart';
import 'package:qq_music/page/song_user/album_details_page.dart';
import 'package:qq_music/page/song_user/song_user.dart';
import 'package:qq_music/service/user/user_service.dart';
import 'package:qq_music/utils/Global.dart';
import 'package:qq_music/utils/commutils.dart';
import 'package:qq_music/utils/my_widget/CusBehavior.dart';

///最近播放列表
class RecPlayPage extends StatefulWidget {
  const RecPlayPage({Key? key}) : super(key: key);

  @override
  _MoreDealPageState createState() => _MoreDealPageState();
}

class _MoreDealPageState extends State<RecPlayPage> {
  bool addList =false;
  bool play =false;

  ///最近播放音乐列表--100
  List<RecPlaySongModel> recPlayMusicList =CacheGlobalData.recPlayMusicList;
  List<Song> songList =[];

  var textSetState ;

  @override
  void initState() {
    super.initState();
    if(recPlayMusicList.isEmpty){
      getRecSong();
    }else{
      for(var i=0;i<recPlayMusicList.length;i++){
        songList.add(recPlayMusicList[i].data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromRGBO(30, 30, 31, 1),
      child: Container(
        margin:const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("最近播放",style: TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold),),

            SizedBox(
              height: 80,
              child: Row(
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap:(){
                      if(recPlayMusicList.isEmpty){
                        EasyLoading.showToast("暂无播放记录");
                        return;
                      }
                      startPlay();
                    },
                    child: Container(
                      width: 110,
                      height: 35,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(Icons.play_arrow_outlined,color: Colors.white,size: 17,),
                          SizedBox(width: 5,),
                          Text("播放",style: TextStyle(color: Colors.white,fontSize: 15),)
                        ],
                      ),
                    ),
                  ),
                  const   SizedBox(width: 10,),
                  ///添加至播放列表
                  InkWell(
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap:(){
                      if(recPlayMusicList.isEmpty){
                        EasyLoading.showToast("暂无播放记录");
                        return;
                      }
                      if(play){
                        EasyLoading.showToast("已添加至播放列表");
                        return;
                      }
                      if(addList==false){
                        AudioListController.playList.addAll(songList);
                        final ids = AudioListController.playList.map((e) => e.id).toSet();
                        AudioListController.playList.retainWhere((x) => ids.remove(x.id));
                        addList=true;
                        EasyLoading.showToast("已添加至播放列表");
                      }else{
                        EasyLoading.showToast("已添加至播放列表");
                      }
                    },
                    child: Container(
                      width: 110,
                      height: 35,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Color.fromRGBO(52, 52, 53, 1)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(Icons.add,color: Colors.white,size: 17,),
                          SizedBox(width: 5,),
                          Text("播放队列",style: TextStyle(color: Colors.white,fontSize: 15),)
                        ],
                      ),
                    ),
                  ),

                  ///下载
                  const SizedBox(width: 10,),
                  InkWell(
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap:(){

                    },
                    child: Container(
                      width: 110,
                      height: 35,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Color.fromRGBO(52, 52, 53, 1)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(Icons.download_rounded,color: Colors.white,size: 17,),
                          SizedBox(width: 5,),
                          Text("下载",style: TextStyle(color: Colors.white,fontSize: 15),)
                        ],
                      ),
                    ),
                  ),

                  ///批量操作
//                  Expanded(child: Container()),
//                  InkWell(
//                    splashColor: Colors.transparent,
//                    hoverColor: Colors.transparent,
//                    highlightColor: Colors.transparent,
//                    onTap:(){
//                      CacheGlobalData.delMoreList.length=0;
//                      CacheGlobalData.delMoreList.addAll(songList);
//                      debugPrint("这里批量操作----个数${CacheGlobalData.delMoreList.length}");
//                      Get.to(()=>const MoreDealPage());
//                    },
//                    child: Container(
//                      alignment: Alignment.center,
//                      width: 130,
//                      height: 35,
//                      decoration: const BoxDecoration(
//                          borderRadius: BorderRadius.all(Radius.circular(30)),
//                          color: Color.fromRGBO(52, 52, 53, 1)
//                      ),
//                      child:  const Text("批量操作",style: TextStyle(color: Colors.white,fontSize: 15),),
//                    ),
//                  )
                ],
              ),
            ),
            Container(
              margin:  const EdgeInsets.only(left: 15,right: 15,top: 10),
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child:  const Text("歌曲",style: TextStyle(color: Colors.grey,fontSize: 13),textScaleFactor:1),
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text("歌手",style: TextStyle(color: Colors.grey,fontSize: 13),textScaleFactor:1),
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text("专辑",style: TextStyle(color: Colors.grey,fontSize: 13),textScaleFactor:1),
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text("播放时间",style: TextStyle(color: Colors.grey,fontSize: 13),textScaleFactor:1),
                    ),
                  ),
                ],
              ),
            ),

            //歌曲列表
            Expanded(child: ListView.builder( addAutomaticKeepAlives: true,
              itemCount: recPlayMusicList.length,
              itemBuilder: (context, index) {
                return StatefulBuilder(
                  builder: (BuildContext context, void Function(void Function()) setStates) {
                    return Container(
                      height: 40,
                      margin: const EdgeInsets.only(top: 5,bottom: 5,left: 15,right: 15),
                      child: GestureDetector(
                        behavior:HitTestBehavior.translucent,
                        onDoubleTap:(){

                        } ,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //名称
                            Expanded(
                              flex: 3,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  constraints: const BoxConstraints(
                                      minWidth: 50, maxWidth: 500),
                                  child: AutoSizeText(
                                    recPlayMusicList[index].data.name,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w200),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    minFontSize: 11,
                                  ),
                                ),
                              ),
                            ),
                            const  SizedBox(width: 10,),
                            // 歌手
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin: const EdgeInsets.only(right: 7),
                                alignment: Alignment.centerLeft,
                                child: MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: ScrollConfiguration(
                                    behavior: CusBehavior(),
                                    child: ListView.builder(itemBuilder: (context,authorIndex){
                                      return InkWell(
                                        onTap: (){
                                          goToSongUser(recPlayMusicList[index].data.ar[authorIndex].id,recPlayMusicList[index].data.ar[authorIndex].name);
                                        },
                                        child: Center(
                                          child: AutoSizeText("${
                                              authorIndex==recPlayMusicList[index].data.ar.length-1?recPlayMusicList[index].data.ar[authorIndex].name:"${recPlayMusicList[index].data.ar[authorIndex].name}/"} "
                                            ,textScaleFactor: 1,minFontSize: 11,
                                            style:  const TextStyle(color: Colors.white,fontSize: 13),maxLines: 2,  overflow: TextOverflow.ellipsis,

                                          ),
                                        ),
                                      );
                                    },itemCount: recPlayMusicList[index].data.ar.length,shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            //专辑
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin: const EdgeInsets.only(right: 7),
                                alignment: Alignment.centerLeft,
                                child:  ListTile(
                                  contentPadding: const EdgeInsets.all(0),
                                  title:AutoSizeText(recPlayMusicList[index].data.al.name.trim(),minFontSize: 11
                                    ,style:  const TextStyle(color:
                                    Colors.white,fontSize: 14,fontWeight: FontWeight.w200),maxLines: 2,  overflow: TextOverflow.ellipsis,
                                  ),
                                  onTap: (){
                                    Get.to(()=>AlbumDetailsPage(id: recPlayMusicList[index].data.al.id,
                                      createTime:  recPlayMusicList[index].data.publishTime ?? 0, name: recPlayMusicList[index].data.al.name,
                                      picUrl: recPlayMusicList[index].data.al.picUrl ?? CacheGlobalData.errorImg, username: recPlayMusicList[index].data.ar[0].name,
                                      uid: recPlayMusicList[index].data.ar[0].id,),transition: Transition.rightToLeft);
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            //时间
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin: const EdgeInsets.only(right: 7),
                                alignment: Alignment.centerLeft,
                                child:  Text( DateTime.fromMillisecondsSinceEpoch(recPlayMusicList[index].playTime).toString().split(".")[0],style: const TextStyle(fontSize: 12,color: Colors.grey),)
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },)
            )
          ],
        ),
      ),
    );
  }
  ///去往歌手页面
  void goToSongUser(int id,String name) {
    Get.to(()=> SongUser(id: id,username: name,),transition: Transition.rightToLeft);
  }

  ///获取数据
  getRecSong() async{
    var recSong = await UserSerVice.getRecSong();
    if(recSong!=null){
      setState(() {
        for(var i=0;i<recPlayMusicList.length;i++){
          songList.add(recPlayMusicList[i].data);
        }
        recPlayMusicList =recSong;
      });
    }
  }

  void startPlay() async{
    AudioListController.initMethod();

    AudioListController.playList.addAll(songList);
    AudioListController.playIndex =0;
    //去重
    final ids = AudioListController.playList.map((e) => e.id).toSet();
    AudioListController.playList.retainWhere((x) => ids.remove(x.id));

    var playUrl = await ThisProjectUtils.getSongUrl(songList[0].id);

    Global.getInstance()!.fire(AudioPlayEvent(playMs:0, playUrl: playUrl!,showController:true,showAutoPlay:true));
    play=true;
  }

}
