
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:qq_music/const/global.dart';
import 'package:qq_music/controller/page_controller.dart';
import 'package:qq_music/model/album/album_model.dart';
import 'package:qq_music/model/dj/dj_banner.dart';
import 'package:qq_music/model/dj/dj_cateory.dart';
import 'package:qq_music/model/dj/dj_details.dart';
import 'package:qq_music/model/mv/mv_details.dart';
import 'package:qq_music/model/search_key/search_hot.dart';
import 'package:qq_music/model/song/rec_play_song_model.dart';
import 'package:qq_music/model/song_play/high_quality_tags.dart';
import 'package:qq_music/model/song_play/song_play_all_category.dart';
import 'package:qq_music/model/song_play/song_play_hot_category%20.dart';
import 'package:qq_music/model/system/sysetm_setting_model.dart';
import 'package:qq_music/model/video/video_group_model.dart';
import '../model/recommend/recommend_play_song.dart';
import 'package:qq_music/model/song/song_list_model.dart';
import 'package:qq_music/model/song/song_list_details.dart';

class CacheGlobalData{
  //缓存的每日歌单推荐
 static List<RecommendPlaySongModel> cacheSongList =[];

 //缓存的每日专辑推荐
 static List<AlbumDetailsModel> cacheEveryDayAlbumList =[];
 static PageController pageController=PageController();

 ///常规音乐后缀
 static List<String>  musicRule = ['mp3', 'ape','m4a'];

 ///推荐详情页传入时的id
 static RecommendModel ? recommendModel;

 ///歌单歌曲获取的历时记录
 ///{"id":1,"song":song}
 static List<Map> cacheSongDetailsList =[];

 ///歌单的信息
 ///{"id":1,"song":song}
 static List<Map> cacheSongDetailsInfo =[];

 ///歌词的信息
 ///{"id":1,"lrc":lrc}
 static List<Map> cacheSongLrcInfo =[];

 ///歌单收藏着的信息
 ///{"id":1,"collect":song}
 static List<Map> cacheSongCollectList =[];

 ///歌手专辑信息
 ///{"id":1,"al":song,"des":album}
 static List<Map> cacheAlbumDetailsList =[];

 ///歌手专辑歌曲信息
 ///{"id":1,"al":song,"des":album}
 static List<Map> cacheAlbumSongsDetailsList =[];

 ///专辑描述
 static String albumDesc ="暂无介绍";

 ///mv数组信息
 ///{"id":1,"mv":mv}
 static List<Map> cacheMvDetailsList =[];


 ///缓存热门歌单的标签
 static List<SongPlayHotCategoryModel> songPlayHotCategoryList =[];

 ///精品歌单标签缓存
 static List<HighQualityTagsModel> highQualityTagsModelList =[];

 ///全部歌单分类的标签
 static SongPlayAllCategoryModel ? songPlayAllCategoryModel ;

 ///电台banner缓存
 static List<DjBannerModel> djBannerList =[];

 ///电台分类标签
 static List<DjCateListModel> cateList =[];


 ///视频分类
 static List<VideoGroupModel> videoGroupList =[];

 ///视频标签
 static List<VideoGroupModel> videoCategoryList =[];

 ///电台个性推荐雷彪
 static List<DjDetailsModel> personalizeRecommendList =[];

 ///更多操作列表
 static List<Song> delMoreList =[];

 ///热门搜索列表
 static List<SearchHotModel> searchHotList =[];

 ///最近播放音乐列表
 static List<RecPlaySongModel> recPlayMusicList =[];
 ///最近播放视频列表
 static List<MvDetailsModel> recPlayVideoList =[];

 static BuildContext ? context;

 static String errorImg ="https://minio.xlxl.ltd/app/2.111232m.png";
 static String errorVideoUrl ="https://minio.xlxl.ltd/app/2.111232m.png";
 static String errorMp3 ="https://minio.xlxl.ltd/app/2.111232m.mp3";




 ///正在播放的音乐
 static Song? songIng;

 ///音量大小（步骤按100来,最大100）
 static double globalVolume = 50;

 ///当前音乐播放的毫秒数
 static double nowPlayMs = 0;

 static SystemSettingModel systemSettingModel =settingModel;
 static MusicPageController ? musicPageController;


 ///搜索的关键字
 static String keyword="";

 ///查询到的总数
 static int total=0;
 static int songTotal=0;
 static int mvTotal=0;
 static int albumsTotal=0;
 static int playlistCount=0;
 static int artistCount=0;
 static int userCount=0;

 //创建StreamController
 static final StreamController<dynamic> streamDownIngController = StreamController<dynamic>.broadcast();
}