
import 'dart:convert';

import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/model/video/video_details.dart';
import 'package:qq_music/model/video/video_group_model.dart';
import 'package:qq_music/utils/Global.dart';
import 'package:qq_music/utils/HttpUtil.dart';

class VideoService{
  ///说明: 调用此接口 , 可获取视频标签列表
  static Future<List<VideoGroupModel> ?>  getVideoGroup() async{

    if(CacheGlobalData.videoGroupList.isNotEmpty){
      return  CacheGlobalData.videoGroupList;
    }
    var result = await DioUtils().get("/video/group/list", {});
    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result)['data'];
      var list = List<VideoGroupModel>.from(json.map((e)=>VideoGroupModel.fromJson(e)));
      CacheGlobalData.videoGroupList=list;
      return list;
    }catch(e){
      Global.logger.e(e);
    }
    return null;
  }

  ///说明 : 调用此接口 , 可获取视频分类列表
  static Future<List<VideoGroupModel> ?>  getVideoCategory() async{

    if(CacheGlobalData.videoCategoryList.isNotEmpty){
      return  CacheGlobalData.videoCategoryList;
    }
    var result = await DioUtils().get("/video/category/list", {});

    if(jsonDecode(result)['code']!=200){
      Global.logger.e(result);
      return null;
    }
    try{
      var json = jsonDecode(result)['data'];
      var list = List<VideoGroupModel>.from(json.map((e)=>VideoGroupModel.fromJson(e)));
      CacheGlobalData.videoCategoryList=list;
      return list;
    }catch(e){
      Global.logger.e(e);
    }
    return null;
  }

  ///说明 : 调用此接口 , 传入标签/分类id,可获取到相关的视频,分页参数只能传入 offset
  ///
  /// 必选参数 : id: videoGroup 的 id
  ///
  /// 可选参数 : offset: 默认 0
  static Future<List<VideoDetailsModel> ?>  getVideoList({required int id,int ? offset}) async{
    offset ??=0;

    var result = await DioUtils().get("/video/group", {"id":id});

    if(jsonDecode(result)['code']!=200){
      Global.logger.e(result);
      return null;
    }
    try{
      var json = jsonDecode(result)['datas'];
      var list = List<VideoDetailsModel>.from(json.map((e)=>VideoDetailsModel.fromJson(e)));
      return list;
    }catch(e){
      Global.logger.e(e);
    }
    return null;
  }


  ///说明 : 调用此接口 , 传入标签/分类id,可获取到相关的视频,分页参数只能传入 offset
  ///
  /// 可选参数 : offset: 默认 0
  static Future<List<VideoDetailsModel> ?>  getAllVideoList({int ? offset}) async{
    offset ??=0;

    var result = await DioUtils().get("/video/timeline/all",{"offset":offset});

    if(jsonDecode(result)['code']!=200){
      Global.logger.e(result);
      return null;
    }
    try{
      var json = jsonDecode(result)['datas'];
      var list = List<VideoDetailsModel>.from(json.map((e)=>VideoDetailsModel.fromJson(e)));
      return list;
    }catch(e){
      Global.logger.e(e);
    }
    return null;
  }
}