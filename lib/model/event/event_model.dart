
import 'package:qq_music/model/down/down_model.dart';
import 'package:qq_music/model/song/song_list_details.dart';

class SendRecId{
  int id;
  SendRecId(this.id);
}

class ChangeMusicFullIndex{
  int  index;///改变章节
  ChangeMusicFullIndex(this.index);
}

class ChangePlayIndex{
  int ? index;///改变颜色
  Song ? downSong;///改变颜色的歌曲
  bool ? playAll;///播放全部

  bool ? delMore; ///数据
  int ?delType; ///处理的类型，0--批量操作，1--下载
  ///数据的类型，0--歌曲，1--电台，2--本地，默认0
  int ? dataType;
  ChangePlayIndex({this.index,this.playAll,this.delType,this.delMore,this.dataType,this.downSong});
}

///改变mv和歌曲的播放状态
class ChangeAudioAndMvPlayState{
  //切换播放源
  int ? mvId;


  bool ? playMp3;///mp3是否播放了
  bool ? playMv;///mv是否播放了
  ChangeAudioAndMvPlayState({this.playMv,this.playMp3,this.mvId});
}

///音乐播放器操作
class AudioPlayEvent{
  //下面三个一起的
  Song ? song;
  String ?  url;
  int ? playType; //1--播放，-1--暂停

  //独立的
  bool ? clearAll; //是否清空播放列表,处理这个的时候其它数据随便写

  //下面两个一起的
  bool ? playUp;//是否播放上一首,处理这个的时候其它数据随便写
  bool ? playDown;//是否播放下一首,处理这个的时候其它数据随便写


  //下面四个参数一起的
  bool ? showController;//是否展示控制列表
  String ? playUrl;//播放的url
  bool ? showAutoPlay;//是否自动播放
  double ? playMs ;///记录的播放毫秒数

  AudioPlayEvent({ this.song, this.playType, this.url,this.clearAll,this.playUp,this.playDown,this.showController,this.showAutoPlay,this.playUrl,this.playMs});
}


class ChangeDownIng{
  int deleteId;
  ChangeDownIng({required this.deleteId});
}

class ChangeDownOver{
  DownModel downModel;
  ChangeDownOver({required this.downModel});
}

class ChangeErrorOver{
  Map<dynamic, dynamic> errors;
  ChangeErrorOver({required this.errors});
}

class ChangeSong{
  Song song;
  ChangeSong({required this.song});
}

///开始搜索
class StartSearch{
  String keyword;
  StartSearch({required this.keyword});
}