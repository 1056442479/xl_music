
import 'package:qq_music/model/song/song_list_details.dart';


class AudioListController {

  ///播放音乐列表
 static  List<Song> playList =<Song>[];
  ///当前列表播放的索引
 static  int playIndex =-1;
  //正在播放的专辑或者歌单的id
 static  int  recommendPlayId =-1;

///初始化
 static initMethod(){
    playList= [];
    playIndex=-1;
    recommendPlayId=-1;
 }

}