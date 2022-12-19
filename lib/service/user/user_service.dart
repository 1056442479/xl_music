
import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/model/album/album_model.dart';
import 'package:qq_music/model/album/album_song_list_model.dart';
import 'package:qq_music/model/dj/dj_details.dart';
import 'package:qq_music/model/dj/dj_user_create.dart';
import 'package:qq_music/model/song/rec_play_song_model.dart';
import 'package:qq_music/model/song/song_collect.dart';
import 'package:qq_music/model/song/song_fans_model.dart';
import 'package:qq_music/model/user/recommend_collect_user.dart';
import 'package:qq_music/model/user/song_user_details_info.dart';
import 'package:qq_music/model/user/song_user_model.dart';
import 'package:qq_music/model/user/user_details_model.dart';
import 'package:qq_music/utils/Global.dart';
import 'package:qq_music/utils/HttpUtil.dart';

class UserSerVice{
  /// 登录后调用此接口 , 传入用户 id, 可以获取用户详情
  /// gender: 性别 0:保密 1:男性 2:女性
  ///[uid] 用户id
  static Future<UserDetails ?> getUserInfo({required int uid}) async{
    var result = await DioUtils().get("/user/detail", {"uid":uid});
    Global.logger.d(result);

    try{
      var collect =  UserDetails.fromJson(jsonDecode(result));
      return collect;
    }catch(e){
      Global.logger.e(e);
    }
    return null;
  }




  ///调用此接口 , 传入歌单 id 可获取歌单的所有收藏者
  ///[id] 歌单id
  ///limit: 取出的数量 , 默认为 20
  static Future<List<RecommendCollectUser> ?> getPlaylistCollectUserInfo({required int id}) async{
    var result = await DioUtils().get("/playlist/subscribers", {"id":id,"limit":50});
    Global.logger.d(result);
    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var collect = jsonDecode(result)['subscribers'];
      var list = List<RecommendCollectUser>.from(
          collect.map((x) => RecommendCollectUser.fromJson(x)));
      return list;
    }catch(e){
      Global.logger.e(e);
    }
    return null;
  }

  /// 调用此接口 , 传入歌手 id, 可获得歌手部分信息和热门歌曲
  ///[id] 歌手id
  static Future<SongUserModel ?>  getArtistsInfo({required int id}) async{
    var result = await DioUtils().get("/artists", {"id":id});
    try{
      if(jsonDecode(result)['code']!=200){
        return null;
      }
      var user = SongUserModel.fromJson(jsonDecode(result));
      return user;
    }catch(e){
      Global.logger.e(e);
    }
    return null;
  }

  /// 调用此接口 , 传入歌手 id, 可获得获取歌手详情
  ///[id] 歌手id
  static Future<SongUserDetailsModel ?>  getSongDetailsInfo({required int id}) async{
    var result = await DioUtils().get("/artist/detail", {"id":id});
    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var songUserDetailsModel = SongUserDetailsModel.fromJson(jsonDecode(result)['data']);

      return songUserDetailsModel;
    }catch(e){
      Global.logger.e(e);
    }
    return null;
  }

  /// 调用此接口 , 传入歌手 id, 可获得歌手专辑内容
  /// 可选参数 : limit: 取出数量 , 默认为 30
  ///[id] 歌手id
  static Future<List<AlbumDetailsModel> ?>  getAlbumListInfo({required int id}) async{
    var result = await DioUtils().get("/artist/album", {"id":id,"limit":50});

    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result)['hotAlbums'];
          var collect = List<AlbumDetailsModel>.from(
        json.map((x) => AlbumDetailsModel.fromJson(x)));

          return collect;
    }catch(e){
      Global.logger.e(e);
    }

    return null;
  }


  /// 说明 : 调用此接口 , 传入专辑 id, 可获得专辑内容(包括专辑的描述等，和专辑的歌曲)
  ///[id] id: 专辑 id
  static Future<AlbumSongListModel ?>  getAlbumSongsListInfo({required int id}) async{
    var result = await DioUtils().get("/album", {"id":id});
    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
       var albumSongListModel = AlbumSongListModel.fromJson(jsonDecode(result)) ;

      return albumSongListModel;
    }catch(e){
      Global.logger.e(e);
    }

    return null;
  }

  ///说明 : 调用此接口, 传入用户 id 可获取用户创建的电台
  ///
  ///必选参数 : uid : 用户 id
  static Future<List<DjUserCreateModel> ?>  getUserCreateDjList({required int uid}) async{
    var result = await DioUtils().get("/user/audio", {"uid":uid});

    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result)['djRadios'];
      var collect = List<DjUserCreateModel>.from(
          json.map((x) => DjUserCreateModel.fromJson(x)));
      return collect;
    }catch(e){
      Global.logger.e(e);
    }

    return null;
  }

  ///登录后调用此接口 , 传入用户 id, 可以获取用户电台
  ///
  ///必选参数 : uid : 用户 id
  static Future<List<DjDetailsModel> ?>  getUserDjList({required int uid}) async{
    var result = await DioUtils().get("/user/dj", {"uid":uid});

    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result)['programs'];
      var collect = List<DjDetailsModel>.from(
          json.map((x) => DjDetailsModel.fromJson(x)));
      return collect;
    }catch(e){
      Global.logger.e(e);
    }

    return null;
  }

 /// 调用此接口 , 传入歌手 id, 可获取歌手粉丝数量
  ///[id] 歌手id
  static Future<SongFansModel ?>  getSongFns({required int id}) async{
    var result = await DioUtils().get("/artist/follow/count", {"id":id});
    try{
      if(jsonDecode(result)['code']!=200){
        return null;
      }
      var json = jsonDecode(result)['data'];
      return  SongFansModel.fromJson(json);
    }catch(e){
      Global.logger.e(e);
    }
    return null;
  }


  ///  登录后调用此接口 , 传入用户 id, 可以获取用户歌单和收藏
  ///[uid]必选参数 : uid : 用户 id
  ///limit : 返回数量 , 默认为 30
  //offset : 偏移数量，用于分页 , 如 :( 页数 -1)*30, 其中 30 为 limit 的值 , 默认为 0
  static Future<List<SongCollectModel> ?>  getSongCollect({required int uid}) async{
    var result = await DioUtils().get("/user/playlist", {"uid":uid});
    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result)['playlist'];


      var collect = List<SongCollectModel>.from(
          json.map((x) => SongCollectModel.fromJson(x)));

      return collect;
    }catch(e){
      Global.logger.e(e);
    }
    return null;
  }


  ///说明 : 调用此接口 , 可获得最近播放-歌曲
  ///可选参数 : limit : 返回数量 , 默认为 100
  static Future<List<RecPlaySongModel> ?>  getRecSong({ int ? limit}) async{
    limit ??=100;
    if(CacheGlobalData.recPlayMusicList.isNotEmpty){
      return CacheGlobalData.recPlayMusicList;
    }
    var result = await DioUtils().get("/record/recent/song",{"limit":limit});
    debugPrint(result);
    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result)['data']['list'];

//      List<Song> list =[];
//      for(var i=0;i<json.length;i++){
//
//      }

      var collect = List<RecPlaySongModel>.from(
          json.map((x) => RecPlaySongModel.fromJson(x)));
      CacheGlobalData.recPlayMusicList =collect;
      return collect;
    }catch(e){
      Global.logger.e(e);
    }
    return null;
  }
}