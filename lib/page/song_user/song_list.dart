import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:qq_music/const/global.dart';
import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/controller/audio_list_controller.dart';
import 'package:qq_music/controller/page_controller.dart';
import 'package:qq_music/model/album/album_song_list_model.dart';
import 'package:qq_music/model/dj/dj_program_model.dart';
import 'package:qq_music/model/event/event_model.dart';
import 'package:qq_music/model/song/song_list_details.dart';
import 'package:qq_music/model/song/song_url_detail.dart';
import 'package:qq_music/model/user/song_user_model.dart';
import 'package:qq_music/page/more_deal/more_deal.dart';
import 'package:qq_music/page/more_deal/more_deal_down.dart';
import 'package:qq_music/page/mv/mv_play_page.dart';
import 'package:qq_music/page/song_user/album_details_page.dart';
import 'package:qq_music/page/song_user/song_user.dart';
import 'package:qq_music/service/dj/dj_service.dart';
import 'package:qq_music/service/song/song_service.dart';
import 'package:qq_music/service/user/user_service.dart';
import 'package:qq_music/utils/Global.dart';
import 'package:qq_music/utils/MyIcons.dart';
import 'package:qq_music/utils/commutils.dart';
import 'package:qq_music/utils/my_widget/CusBehavior.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

///[type] 0歌单的，1--歌手的，2--专辑的,3--电台的
///
///[id] 专辑或者歌曲的id
///
/// [list]传过来的数组数据
///
/// [chuan] 播放列表传入数组数据
class SongList extends StatefulWidget {
  final int id;
  final int  type;
  final List<Song> ? list;
  final bool ? chuan;
  const SongList({Key? key,required this.id,required this.type,this.list,this.chuan}) : super(key: key);

  @override
  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> with AutomaticKeepAliveClientMixin{
  int colorIndex =-1;
  List<Song> songList =[];
  SongUrlDetails ? songUrlDetails;
  //{"index":0,"set"StateSetter  mainSetState;}
  late List<Map> listSet=[];
//  late StateSetter  jiLuSetState;
  bool play =false; //当前是否播放中
//  Song ? playSong =CacheGlobalData.songIng; //播放的曲目信息
  String ? playUrl ;//播放的url
  //监听滚动事件
  final ItemScrollController itemScrollController = ItemScrollController();
  //初始记录的
  late  StateSetter initSet;
  StreamSubscription ? listen;
  @override
  void initState() {
    super.initState();

    if(widget.list!=null){
      songList =widget.list!;
      //延遲執行，不然null
      Future.delayed(const Duration(milliseconds: 500), () async {
        //执行代码写在这里
        if(AudioListController.playIndex>=0){
          //跳转到指定位置
          if(AudioListController.playList.isNotEmpty){
            itemScrollController.jumpTo(index:AudioListController.playIndex);
          }
        }
      });

    }
    Global.logger.d("歌曲列表创建了");


     listen = Global.getInstance()!.on<ChangePlayIndex>().listen((event) {
      if(event.playAll!=null && event.playAll!){
        getOneSongUrl(index: 0);
      }
      if(event.delMore!=null && event.delMore! && event.delType!=null){

        delMoreData(event.delType!,event.dataType);
      }
      if(event.index!=null){
        if(mounted){
          initSet((){
            colorIndex;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
//    AudioListController = Get.put(AudioListController());

    return   Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.chuan==null?
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
                  child:  Text(widget.type!=3? "歌曲":"声音",style:const TextStyle(color: Colors.grey,fontSize: 13),textScaleFactor:1),
                ),
              ),

              (widget.type!=1)? Expanded(
                flex: widget.chuan==null?  3:2,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text("歌手",style: TextStyle(color: Colors.grey,fontSize: 13),textScaleFactor:1),
                ),
              ):Container(),

              widget.type!=3  ?  Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text("专辑",style: TextStyle(color: Colors.grey,fontSize: 13),textScaleFactor:1),
                ),
              ):Container(),

              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text("时长",style: TextStyle(color: Colors.grey,fontSize: 13),textScaleFactor:1),
                ),
              ),
            ],
          ),
        ):Container(
          height: 140,
          margin:  const EdgeInsets.only(top: 120),
          child: Column(
            children:  [
              Container(
                margin:  const EdgeInsets.only(left: 15,right: 15,top: 50),
                width: double.infinity,
                child:  const Text("当前播放",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
              ),
              Container(
                margin:  const EdgeInsets.only(left: 15,right: 15),
                child: Row(
                  children: [
                    Text("${AudioListController.playList.length}首歌曲",style: const TextStyle(color: Colors.white,fontSize: 13),),
                    Expanded(child: Container()),
                    IconButton(onPressed: (){
                      var path = Get.currentRoute;
                      if(path!="/MoreDealPage"){
                        CacheGlobalData.delMoreList.length=0;
                        CacheGlobalData.delMoreList.addAll(songList);
                        Get.back();
                        Get.to(()=>const MoreDealPage());
                      }else{
                        EasyLoading.showToast("已在批量操作界面");
                      }
                    }, icon: const Icon(Icons.menu_rounded,size: 20,color: Colors.white,),tooltip: "批量操作",),
                    IconButton(onPressed: (){
                      ///清空列表
                      setState(() {
                        Global.getInstance()!.fire(AudioPlayEvent(playType: null, url: null,clearAll: true));
                      });
                    }, icon:const Icon(Icons.delete_rounded,size: 20,color: Colors.white,),tooltip: "清空列表",),
                  ],
                ),
              ),
              const Divider(),
            ],
          ),
        ),
        Expanded(child:   MediaQuery.removePadding(
          removeTop: false,
          context: context,
          child: FutureBuilder(
            future:   getSongListDetails(widget.id),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snap) {
              if (snap.connectionState == ConnectionState.done) {
                if (snap.hasError) {
                  return Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: BrnAbnormalStateWidget(
                      bgColor: Colors.transparent,
                      isCenterVertical: true,
                      themeData:BrnAbnormalStateConfig(
                          titleTextStyle:BrnTextStyle(color: Colors.red,fontSize: 18)
                      ),
                      title: "数据出错",
                    ),
                  );
                }
                return songList.isEmpty?const Center(child: Text("数据为空",style: TextStyle(color: Colors.white),),):    ScrollConfiguration(
                  behavior: CusBehavior(),
                  child: StatefulBuilder(

                    builder: (BuildContext context, void Function(void Function()) setState) {
                      initSet =setState;
                      return  ScrollablePositionedList.builder(
                        addAutomaticKeepAlives: true,
                        itemCount: songList.length,
                        itemScrollController: itemScrollController,
                        itemBuilder: (context, index) {
                          return StatefulBuilder(
                            builder: (BuildContext context, void Function(void Function()) setStates) {
                              return MouseRegion(
                                onEnter: (e){
                                  setStates(() {
                                    colorIndex=index;
                                  });
                                },
                                onExit: (e){
                                  setStates(() {
                                    colorIndex=-1;
                                  });
                                },
                                child: Container(
                                  color: colorIndex==index?const Color.fromRGBO(36, 36, 37, 1):Colors.transparent,
                                  height: 40,
                                  margin: const EdgeInsets.only(top: 5,bottom: 5,left: 15,right: 15),
                                  child: GestureDetector(
                                    behavior:HitTestBehavior.translucent,
                                    onDoubleTap:(){
                                      getOneSongUrl(index: index);
                                    } ,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        //名称
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              children: [
                                                //收藏
                                                InkWell(
                                                  onTap:(){
                                                    EasyLoading.showToast("需要登录后使用");
                                                  },
                                                  child: const Icon(XlIcons.xl_aixin1,color: Color.fromRGBO(229, 229, 230, 1),size: 14,),
                                                ),
                                                const SizedBox(width: 10,),
                                                //下载歌曲
                                                InkWell(
                                                    onTap:(){
                                                      if(songList[index].rtype==-1){
                                                        EasyLoading.showToast("本地文件，无需下载");
                                                        return;
                                                      }
                                                      getOneSongUrlDown(id: songList[index].id,song: songList[index]);
                                                    },
                                                    child:  Icon(XlIcons.xl_xiazai,color:songList[index].rtype==-1?Colors.greenAccent:const Color.fromRGBO(229, 229, 230, 1),size: 14,)
                                                ),
                                                const SizedBox(width: 10,),

                                                Container(
                                                  constraints: const BoxConstraints(
                                                      minWidth: 50,
                                                      maxWidth: 500
                                                  ),
                                                  width:  widget.chuan==null?  120:50,
                                                  child: AutoSizeText(songList[index].name,style:  TextStyle(color:
                                                  AudioListController.playIndex==-1 ? Colors.white:
                                                  getPlayColor(index),fontSize: 14,fontWeight: FontWeight.w200),
                                                    maxLines: 1,  overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),

                                                Offstage(
                                                  offstage:songList[index].mv>0?false:true,
                                                  child:  Container(
                                                    alignment: Alignment.center,
                                                    width: 20,
                                                    height: 15,
                                                    margin: const EdgeInsets.only(left: 15),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.grey),
                                                        borderRadius: const BorderRadius.all(Radius.circular(2))
                                                    ),
                                                    child:  InkWell(onTap: (){
                                                      if(widget.chuan!=null){
                                                        if(Get.isOverlaysOpen){
                                                         Get.back();
                                                        }
                                                      }
                                                      var currentRoute = Get.currentRoute;
                                                      if(currentRoute=="/MvPlayPage"){
                                                          Global.getInstance()!.fire(ChangeAudioAndMvPlayState(mvId: songList[index].mv));
                                                      }else{
                                                        Get.to(()=>MvPlayPage(index:0, mvDetailsModelList: const [],mvId: songList[index].mv,));
                                                      }

                                                    },child: const Text("MV",style: TextStyle(color: Colors.white,fontSize: 9),textScaleFactor: 1,),),
                                                  ),
                                                ),
                                                Offstage(
                                                  offstage:songList[index].fee>0?false:true,
                                                  child:  Container(
                                                    alignment: Alignment.center,
                                                    width: 20,
                                                    height: 15,
                                                    margin: const EdgeInsets.only(left: 15),
                                                    child:  InkWell(onTap: (){},child: const Text("VIP",style: TextStyle(color: Colors.greenAccent,fontSize: 10,),textScaleFactor: 1,),),
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                        // 歌手
                                        (widget.type!=1)?  Expanded(
                                          flex: widget.chuan==null?  3:2,
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
                                                      goToSongUser(songList[index].ar[authorIndex].id,songList[index].ar[authorIndex].name);
                                                    },
                                                    child: Center(
                                                      child: AutoSizeText("${
                                                          authorIndex==songList[index].ar.length-1?songList[index].ar[authorIndex].name:"${songList[index].ar[authorIndex].name}/"} "
                                                        ,textScaleFactor: 1,minFontSize: 11,
                                                        style:  TextStyle(color:getPlayColor(index),fontSize: 13),maxLines: 2,  overflow: TextOverflow.ellipsis,

                                                      ),
                                                    ),
                                                  );
                                                },itemCount: songList[index].ar.length,shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),
                                                  scrollDirection: Axis.horizontal,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ):Container(),
                                        //专辑
                                        ( widget.chuan==null && widget.type!=3 )? Expanded(
                                          flex: 2,
                                          child: Container(
                                            margin: const EdgeInsets.only(right: 7),
                                            alignment: Alignment.centerLeft,
                                            child:  ListTile(
                                              contentPadding: const EdgeInsets.all(0),
                                              title:AutoSizeText(songList[index].al.name.trim(),minFontSize: 11
                                                ,style:  TextStyle(color:getPlayColor(index),fontSize: 14),maxLines: 2,  overflow: TextOverflow.ellipsis,
                                              ),
                                              onTap: (){
                                                Get.to(()=>AlbumDetailsPage(id: songList[index].al.id,
                                                  createTime:  songList[index].publishTime ?? 0, name: songList[index].al.name,
                                                  picUrl: songList[index].al.picUrl ?? CacheGlobalData.errorImg, username: songList[index].ar[0].name,
                                                  uid: songList[index].ar[0].id,),transition: Transition.rightToLeft);

                                              },
                                            ),
                                          ),
                                        ):Container(),
                                        //歌曲时间
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child:Text(CommUtils.formatMinSec(songList[index].dt).trim(),style:  TextStyle(color:
                                            getPlayColor(index),fontSize: 14),),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                );
              } else if (snap.connectionState == ConnectionState.active) {
                return   Container();
              } else if (snap.connectionState == ConnectionState.waiting) {
                return Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: const Center(
                      child: SleekCircularSlider(
                          appearance: CircularSliderAppearance(
                            spinnerMode: true,
                          ))
                  ),
                );
              } else if (snap.connectionState == ConnectionState.none) {
                return Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: BrnAbnormalStateWidget(
                    bgColor: Colors.transparent,
                    isCenterVertical: true,
                    themeData:BrnAbnormalStateConfig(
                        titleTextStyle:BrnTextStyle(color: Colors.white,fontSize: 18)
                    ),
                    title: "暂无数据",
                  ),
                );
              }
              return Container();
            },

          ),
        ))

      ],
    );
  }





  ///点击播放
  getOneSongUrl({required int index}) async{
    if(AudioListController.playIndex==-1){
        dealSong(index: index);
      }else{
      if(AudioListController.playIndex>AudioListController.playList.length-1){
        dealSong(index: index);
      }
      if(AudioListController.playList[AudioListController.playIndex].id !=songList[index].id){
        dealSong(index: index);
      }else{
        if( Global.audioPlayer.state==PlayerState.paused){
          Global.getInstance()!.fire(AudioPlayEvent(song:songList[index], playType: 1, url: playUrl!));
          play=true;
        }else{
          Global.getInstance()!.fire(AudioPlayEvent(song:songList[index], playType: -1, url: ""));
          play =false;
        }
      }
    }
  }

  dealSong({required int index}) async{
    String ? url;
    if(songList[index].rtype==-1){
      url=songList[index].rtUrl;
    }else{
      url =  await ThisProjectUtils.getSongUrl(songList[index].id);
    }
    if(url==null){
      EasyLoading.showToast("该歌曲暂时无法播放");
      return;
    }
    playUrl = url;
    AudioListController.playIndex =index;

    if(settingModel.playingList){
      ///添加到列表
      if(widget.id!=AudioListController.recommendPlayId){
        AudioListController.recommendPlayId=widget.id;
        AudioListController.playList.length=0;
        AudioListController.playList.addAll(songList);
      }
    }else{
      dealOneSong(songList[index]);
    }


    CacheGlobalData.songIng =songList[index];
    Global.getInstance()!.fire(AudioPlayEvent(song:songList[index], playType: 1, url: playUrl));
    play =true;


    if(initSet!=null){
      if(mounted){
        initSet((){
          colorIndex;
        });
      }
    }
  }

  ///处理设置为单曲播放的
  dealOneSong(Song song){
    AudioListController.playIndex =0;
    ///添加到列表
    if(widget.id!=AudioListController.recommendPlayId){
      AudioListController.recommendPlayId=widget.id;

      AudioListController.playList.length=0;
      AudioListController.playList.add(song);
    }
  }

  ///点击下载
  getOneSongUrlDown({required int id,required Song song}) async{
    var songUrl = await ThisProjectUtils.getSongUrl(id);
    if(songUrl!=null ){
      EasyLoading.showToast("已加入下载队列");
      ThisProjectUtils.downMoreMusic(url: songUrl, song: song);
    }else{
      EasyLoading.showToast("获取下载链接地址失败");
    }
  }




  ///获取歌曲信息
  getSongListDetails(int id) async{
    if(songList.isNotEmpty || id==-1){
      return  songList;
    }
    MusicPageController put = Get.put(MusicPageController());
    if(widget.list!=null){
      return widget.list!;
    }
    //先获取缓存
    if(widget.type==0 ||widget.type==1){
      var indexWhere = CacheGlobalData.cacheSongDetailsList.indexWhere((element) => element['id']==id);
      if(indexWhere>=0){
        songList = CacheGlobalData.cacheSongDetailsList[indexWhere]['song'];
        if(songList.isNotEmpty){
          return songList;
        }
      }
    }else{
      var indexWhere = CacheGlobalData.cacheAlbumSongsDetailsList.indexWhere((element) => element['id']==id);
      if(indexWhere>=0){
        songList = CacheGlobalData.cacheAlbumSongsDetailsList[indexWhere]['al'];
       var  album = CacheGlobalData.cacheAlbumSongsDetailsList[indexWhere]['des'];
        put.changeAlbumDesc(album.description);
        return;
      }
    }

    Global.logger.d("歌单歌曲详情列表构建了----获取的数据量--${songList.length}");
    if( widget.type==0){
      await getSongListForAlbum(id);
    }
    if(widget.type==1){
     await  getArtistsInfo(id);
    }
    if(widget.type==2){

      await  getAlbumSongsListInfo(id,put);
    }
    if(widget.type==3){
      await  getListDjDetailInfo(id);
    }
  }


  ///获取歌单的歌曲列表
  ///[id] 歌单的id
  getSongListForAlbum(int id) async{
    var getList = await SongService.getSongListDetails(id: id);
    if(getList!=null){
      Global.logger.d(getList.length);
      if(getList.isNotEmpty){
        CacheGlobalData.cacheSongDetailsList .add({
          "id":id,
          "song":getList
        });
      }
      songList =getList;
    }
  }


  ///[id] 歌手id
  ///获取歌手的歌曲
  getArtistsInfo(int id) async{
    if(songList.isEmpty){
      SongUserModel ? songUserModel = await UserSerVice.getArtistsInfo(id: id);
      if(songUserModel!=null){
        if(songUserModel.code==200){
          if(songUserModel.hotSongs.isNotEmpty){
            CacheGlobalData.cacheSongDetailsList .add({
              "id":id,
              "song":songUserModel.hotSongs
            });
          }
          songList =songUserModel.hotSongs;
        }
      }
    }
  }


  ///[id] 专辑id
  ///获取专辑的歌曲
  getAlbumSongsListInfo(int id,MusicPageController musicPageController) async{
    if(songList.isEmpty){
      AlbumSongListModel ? albumSongListModel = await UserSerVice.getAlbumSongsListInfo(id: id);
      if(albumSongListModel!=null){
          if(albumSongListModel.songs.isNotEmpty){
            CacheGlobalData.cacheAlbumSongsDetailsList.add({
              "id":id,
              "al":albumSongListModel.songs,
              "des":albumSongListModel.album
            });

            musicPageController.changeAlbumDesc(albumSongListModel.album.description ?? "暂无描述");
//            CacheGlobalData.albumDesc =albumSongListModel.album.description;
            songList =albumSongListModel.songs;
          }

      }
    }
  }

  ///[id] 电台的id
  ///可查看对应电台的电台节目
  getListDjDetailInfo(int id) async{
    if(songList.isEmpty){
      List<DjProgramModel> ? djList = await DjService.getListDjDetailInfo(rid: id);
      if(djList!=null){
        if(djList.isNotEmpty){
          songList.length=0;
          for(var i=0;i<djList.length;i++){

           List<Ar>   ars =[];
          if( djList[i].mainSong.artists.isNotEmpty){
            var artists = djList[i].mainSong.artists;
            for(var j=0;j<artists.length;j++){
              var ar = Ar(id: artists[j].id, name: artists[j].name);
              ars.add(ar);
            }
          }
           Al al =Al(id:djList[i].mainSong.album.id, name: djList[i].mainSong.album.name ?? "未知"
               , pic: djList[i].mainSong.album.pic,picUrl: djList[i].mainSong.album.picUrl);
            Song song =Song(name: djList[i].mainSong.name, id:djList[i].mainSong.id,
                ar: ars, fee: djList[i].mainSong.fee , al:  al, dt: djList[i].mainSong.duration, mv: djList[i].mainSong.mvid);
            songList.add(song);
          }
        }
      }
    }
  }


  ///跟多数据处理
  void delMoreData(int delType, int? dataType) {
    CacheGlobalData.delMoreList.length=0;
    CacheGlobalData.delMoreList.addAll(songList);
    debugPrint("这里批量操作----个数${CacheGlobalData.delMoreList.length}");
    if(delType==0){
      Get.to(()=>const MoreDealPage(),transition: Transition.rightToLeft);
    }else{
      Get.to(()=>const MoreDealDownPage(),transition: Transition.rightToLeft);
    }
  }

  ///去往歌手页面
  void goToSongUser(int id,String name) {
      Get.to(()=> SongUser(id: id,username: name,),transition: Transition.rightToLeft);
  }


  @override
  bool get wantKeepAlive =>true;



  @override
  void dispose() {
    super.dispose();
    if(listen!=null){
      listen!.cancel();
    }
  }

  ///获取播放时的颜色
  getPlayColor(int index) {
    if(AudioListController.playIndex==-1){
      return Colors.white;
    }
   if(AudioListController.recommendPlayId!=widget.id && widget.chuan==null){
     return Colors.white;
   }

   if(AudioListController.playList[AudioListController.playIndex].rtype==-1){
     return ( AudioListController.playList[AudioListController.playIndex].rtUrl!=songList[index].rtUrl
         ? const Color.fromRGBO(229, 229, 230, 1)
         :Colors.greenAccent );
    }else{
     return ( AudioListController.playList[AudioListController.playIndex].id!=songList[index].id
         ? const Color.fromRGBO(229, 229, 230, 1)
         :Colors.greenAccent );
   }
  }



}
