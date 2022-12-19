
import 'dart:convert';
import 'package:qq_music/const/global.dart';
import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/model/album/album_model.dart';
import 'package:qq_music/model/song/song_every_model.dart';
import 'package:qq_music/model/song/song_lrc.dart';
import 'package:qq_music/model/song_play/high_quality_tags.dart';
import 'package:qq_music/model/song_play/song_play_all_category.dart';
import 'package:qq_music/model/song_play/song_play_hot_category%20.dart';
import '../../model/song_play/song_play_details.dart';
import '../../model/recommend/recommend_play_song.dart';
import 'package:qq_music/model/song/song_list_details.dart' as song;
import 'package:qq_music/model/song/song_url_detail.dart';
import 'package:qq_music/utils/Global.dart';
import 'package:qq_music/utils/HttpUtil.dart';

class SongService{


  //获取每日推荐歌单(不推荐，总是302)
//  static Future<List<RecommendModel> ?> getEveryDaySong() async{
//    var result = await DioUtils().get("/recommend/resource", {});
//    Global.logger.d(result);
//    if(jsonDecode(result)['code']!=200){
//      return null;
//    }
//    try{
//      var songList = SongList.fromJson(jsonDecode(result));
//      return songList.recommend;
//     }catch(e){
//      Global.logger.e(e);
//  }
//
//    return null;
//
//  }

  ///获取每日推荐新歌10首
  static Future<List<SongEveryModel> ?> getEveryDayNewSong() async{
    var result = await DioUtils().get("/personalized/newsong", {});
    Global.logger.d(result);
    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result)['result'];
      var list = List<SongEveryModel>.from(json.map((x) => SongEveryModel.fromJson(x)));
      return list;
    }catch(e){
      Global.logger.e(e);
    }
    return null;
  }

  ///获取每日推荐歌单
  static Future<List<RecommendPlaySongModel> ?> getEveryDaySongPlay() async{
    var result = await DioUtils().get("/personalized", {});
    Global.logger.d(result);
    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result)['result'];
      var list = List<RecommendPlaySongModel>.from(json.map((x) => RecommendPlaySongModel.fromJson(x)));
      return list;
    }catch(e){
      Global.logger.e(e);
    }
    return null;
  }



  ///获取歌单的详细信息
  ///说明 : 歌单能看到歌单名字, 但看不到具体歌单内容 , 调用此接口 , 传入歌单 id, 可 以获取对应歌单内的所有的音乐(未登录状态只能获取不完整的歌单,登录后是完整的)，但是返回的 trackIds 是完整的，tracks 则是不完整的，可拿全部 trackIds 请求一次 song/detail 接口获取所有歌曲的详情
  ///[id]必选参数 : id : 歌单 id
  ///可选参数 : s : 歌单最近的 s 个收藏者,默认为 8
  static Future<SongPlayDetails ?> getSongPlayDetailsInfo(int id) async{
    var result = await DioUtils().get("/playlist/detail", {"id":id});

    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result)['playlist'];
      var songPlayDetails = SongPlayDetails.fromJson(json);
      return songPlayDetails;
    }catch(e){
      Global.logger.e(e);
    }
    return null;
  }



  ///调用此接口,可获取歌单分类,包含 category 信息
  static Future<SongPlayAllCategoryModel ?> getSongPlayCategory() async{
    if(CacheGlobalData.songPlayAllCategoryModel!=null){
      return CacheGlobalData.songPlayAllCategoryModel;
    }
    var result = await DioUtils().get("/playlist/catlist", {});
    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var songPlayAllCategoryModel = SongPlayAllCategoryModel.fromJson(jsonDecode(result));
      CacheGlobalData.songPlayAllCategoryModel=songPlayAllCategoryModel;
      return songPlayAllCategoryModel;
    }catch(e){
      Global.logger.e(e);
    }
    return null;
  }

  /// 调用此接口,可获取热门歌单分类,包含 category 信息
  static Future<List<SongPlayHotCategoryModel> ?> getSongPlayHotCategory() async{
    if(CacheGlobalData.songPlayHotCategoryList.isNotEmpty){
      return CacheGlobalData.songPlayHotCategoryList;
    }
    var result = await DioUtils().get("/playlist/hot", {});
    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result)['tags'];
      var songPlayDetails = List<SongPlayHotCategoryModel>.from(json.map((e)=> SongPlayHotCategoryModel.fromJson(e)));
      CacheGlobalData.songPlayHotCategoryList=songPlayDetails;
      return songPlayDetails;
    }catch(e){
      Global.logger.e(e);
    }
    return null;
  }

  /// 调用此接口 , 可获取精品歌单标签列表
  static Future<List<HighQualityTagsModel> ?> getHighQualityTags() async{
    if(CacheGlobalData.highQualityTagsModelList.isNotEmpty){
      return CacheGlobalData.highQualityTagsModelList;
    }
    var result = await DioUtils().get("/playlist/highquality/tags", {});
    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result)['tags'];
      var songPlayDetails = List<HighQualityTagsModel>.from(json.map((e)=> HighQualityTagsModel.fromJson(e)));
      CacheGlobalData.highQualityTagsModelList=songPlayDetails;
      return songPlayDetails;
    }catch(e){
      Global.logger.e(e);
    }
    return null;
  }

  /// 调用此接口 , 可获取精品歌单
  ///
  /// limit: 取出歌单数量 , 默认为 50
  ///
  /// cat: tag, 比如 " 华语 "、" 古风 " 、" 欧美 "、" 流行 ", 默认为 "全部",可从精品歌单标签列表接口获取(/playlist/highquality/tags)
  ///
  /// before: 分页参数,取上一页最后一个歌单的 updateTime 获取下一页数据
  static Future<List<SongPlayDetails> ?> getHighQualitySongPlays({int ? before,int ? limit,String ? cat}) async{
    limit ??= 50;
    limit>100?100:limit;

    Map <String, dynamic> map ={
      "limit":limit,
    };
    if(before!=null){
      map['before'] =before;
    }
    if(cat!=null){
      map['cat'] =cat;
    }
    var result = await DioUtils().get("/top/playlist/highquality",map);
    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result)['playlists'];
      var songPlayDetails = List<SongPlayDetails>.from(json.map((e)=> SongPlayDetails.fromJson(e)));
      return songPlayDetails;
    }catch(e){
      Global.logger.e(e);
    }
    return null;
  }

  //获取每日推荐专辑
  static Future<List<AlbumDetailsModel> ?> getEveryDayAlbum() async{
    var result = await DioUtils().get("/album/newest", {});
    Global.logger.d(result);
    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result)['albums'];
      var list = List<AlbumDetailsModel>.from(json.map((x) => AlbumDetailsModel.fromJson(x)));
      return list;
    }catch(e){
      Global.logger.e(e);
    }

    return null;

  }



  //获取歌单详情
  ///[id]必选参数 : id : 歌单 id
  ///[limit]可选参数 : limit : 限制获取歌曲的数量，默认值为当前歌单的歌曲数量
  ///[offset]可选参数 : offset : 默认值为0
  static Future<List<song.Song> ?> getSongListDetails({required int id ,int ? limit, int ? offset}) async{
    var result = await DioUtils().get("/playlist/track/all", {"id":id});

    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var songList = song.SongListDetails.fromJson(jsonDecode(result));
      if(songList.code!=200){
        return null;
      }
      return songList.songs;
    }catch(e){
      Global.logger.e(e);
    }

    return null;

  }


  //获取歌曲歌词
  ///[id]必选参数 : id : 歌单 id
  static Future<SongLrcModel ?> getSongLrc({required int id}) async{
    var indexWhere = CacheGlobalData.cacheSongLrcInfo.indexWhere((element) => element['id']==id);
    if(indexWhere!=-1){
        return CacheGlobalData.cacheSongLrcInfo[indexWhere]['lrc'];
    }
    var result = await DioUtils().get("/lyric", {"id":id});

    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var songList = SongLrcModel.fromJson(jsonDecode(result));
      if(songList.code!=200){
        return null;
      }
      CacheGlobalData.cacheSongLrcInfo.add({
        "id":id,
        "lrc":songList
      });
      return songList;
    }catch(e){
      Global.logger.e(e);
    }

    return null;

  }


  ///说明 : 调用此接口 , 可获取 banner( 轮播图 ) 数据
  ///[type] 0: pc  1: android  2:iphone  3: ipad
  static Future<List<String> ?> getBanner({required int ? type}) async{
    type ?? 0;
    var result = await DioUtils().get("/banner", {"type":type});

    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      List<String> resultList =[];
      var list = jsonDecode(result)['banners'];
      for(var i=0;i<list.length;i++){
        if(type==0){
          if(list[i]['imageUrl']!=null){
            resultList.add(list[i]['imageUrl']);
          }
        }
        if(type==3){
          if(list[i]['pic']!=null){
            resultList.add(list[i]['pic']);
          }
        }

      }
      return resultList;
    }catch(e){
      Global.logger.e(e);
    }
    return null;
  }


  ///[ids]必选参数 : id : 音乐 id,传入的音乐 id( 可多个 , 用逗号隔开 ), 可以获取对应的音乐的 url
  /// [level] 播放音质等级, 分为 standard => 标准,higher => 较高, exhigh=>极高, lossless=>无损, hires=>Hi-Res
  static Future<List<SongUrlDetails> ?> getSongListUrl({required List<int> ids ,String ? level}) async{
    if(level==null){
      settingModel.playMusicLevel ==0?level="standard":level="standard";
      settingModel.playMusicLevel ==1?level="higher":level="higher";
      settingModel.playMusicLevel ==2?level="exhigh":level="exhigh";
      settingModel.playMusicLevel ==3?level="lossless":level="lossless";
    }
    String id ="";
    if(ids.isEmpty){
      return null;
    }
    for(var i=0;i<ids.length;i++){
      id+="${ids[i]},";
    }
    var lastIndexOf = id.lastIndexOf(",");
    id =id.substring(0,lastIndexOf);
    var result = await DioUtils().get("/song/url/v1", {"id":id,"level":level});
    var map = jsonDecode(result);
    if(map['code']!=200){
      return null;
    }
    try{
      var list = List<SongUrlDetails>.from(
          map['data'].map((x) => SongUrlDetails.fromJson(x)));
      return  list;
    }catch(e){
      Global.logger.e(e);
    }
    return null;
  }
}