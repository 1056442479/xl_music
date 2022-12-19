
import 'dart:convert';

import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/model/dj/dj_banner.dart';
import 'package:qq_music/model/dj/dj_category_list_model.dart';
import 'package:qq_music/model/dj/dj_cateory.dart';
import 'package:qq_music/model/dj/dj_program_model.dart';
import 'package:qq_music/model/dj/dj_user_top.dart';
import 'package:qq_music/model/user/recommend_collect_user.dart';
import '../../model/dj/dj_details.dart';
import 'package:qq_music/utils/Global.dart';
import 'package:qq_music/utils/HttpUtil.dart';

///电台接口
class DjService{

  ///调用此接口,可获取电台 banner
  static Future<List<DjBannerModel> ?> getDjBanner() async{
   if(CacheGlobalData.djBannerList.isNotEmpty){
     return CacheGlobalData.djBannerList;
   }
   var result = await DioUtils().get("/dj/banner",{});
   if(jsonDecode(result)['code']!=200){
     return null;
   }

   try{
     var json = jsonDecode(result)['data'];
     var collect = List<DjBannerModel>.from(
         json.map((x) => DjBannerModel.fromJson(x)));
     CacheGlobalData.djBannerList =collect;
     return collect;
   }catch(e){
     Global.logger.e(e);
   }

   return null;
  }

  ///说明 :登录后调用此接口 , 可获得电台类型
  static Future<List<DjCateListModel> ?> getDjCateList() async{
    if(CacheGlobalData.cateList.isNotEmpty){
      return CacheGlobalData.cateList;
    }
    var result = await DioUtils().get("/dj/catelist",{});
    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result)['categories'];
      var collect = List<DjCateListModel>.from(
          json.map((x) => DjCateListModel.fromJson(x)));
      CacheGlobalData.cateList =collect;
      return collect;
    }catch(e){
      Global.logger.e(e);
    }

    return null;
  }

  ///调用此接口,可获取电台个性推荐列表
  ///
  ///[limit] : 返回数量,默认为 6,总条数最多 6 条
 static Future<List<DjDetailsModel> ?> getDjPersonalizeRecommend({int ? limit}) async{
    limit ??=6;
    if(CacheGlobalData.personalizeRecommendList.isNotEmpty){
      return CacheGlobalData.personalizeRecommendList;
    }

    var result = await DioUtils().get("/dj/personalize/recommend",{"limit":limit});
    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result)['data'];
      var collect = List<DjDetailsModel>.from(
          json.map((x) => DjDetailsModel.fromJson(x)));
      CacheGlobalData.personalizeRecommendList =collect;
      return collect;
    }catch(e){
      Global.logger.e(e);
    }

    return null;
  }

  ///登录后调用此接口 , 可获得推荐电台
  static Future<List<DjDetailsModel> ?> getDjRecommend() async{

    var result = await DioUtils().get("/dj/recommend",{});
    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result)['djRadios'];
      var collect = List<DjDetailsModel>.from(
          json.map((x) => DjDetailsModel.fromJson(x)));
      return collect;
    }catch(e){
      Global.logger.e(e);
    }

    return null;
  }


  ///说明 : 登录后调用此接口 , 可获得新晋电台榜/热门电台榜
  ///
  /// limit : 返回数量 , 默认为 100
  //
  //offset : 偏移数量，用于分页 , 如 :( 页数 -1)*100, 其中 100 为 limit 的值 , 默认为 0
  //
  //type: 榜单类型, new 为新晋电台榜,hot为热门电台榜
  static Future<List<DjDetailsModel> ?> getDjTopList({required String type,int ? limit}) async{
    limit ??=100;

    var result = await DioUtils().get("/dj/toplist",{"type":type,"limit":limit});
    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result)['toplist'];
      var collect = List<DjDetailsModel>.from(
          json.map((x) => DjDetailsModel.fromJson(x)));
      return collect;
    }catch(e){
      Global.logger.e(e);
    }

    return null;
  }
  ///说明 : 调用此接口,可获取电台订阅者列表 必选参数 : id: 电台 id
  ///limit : 返回数量,默认为 20
  //
  //offset : 偏移数量，用于分页 , 如 :( 页数 -1)*30, 其中 30 为 limit 的值 , 默认为 0 接口地址 : /dj/hot
  static Future<Map ?> getSubscriberDj({ int ? limit,required int id,int ? time}) async{
    limit ??=30;

    Map<String,dynamic> map ={
      "limit":limit,
      "id":id
    };
    if(time!=null){
      map['time'] =time;
    }
    var result = await DioUtils().get("/dj/subscriber",map);
    if(jsonDecode(result)['code']!=200){
      return null;
    }

    try{
      int time =jsonDecode(result)['time'];
      var json = jsonDecode(result)['subscribers'];
      var collect = List<RecommendCollectUser>.from(
          json.map((x) => RecommendCollectUser.fromJson(x)));
      Map res ={
        "time":time,
        "res":collect
      };
      return res;
    }catch(e){
      Global.logger.e(e);
    }

    return null;
  }




  ///说明 : 登录后调用此接口 , 传入分类,可获得对应类型电台列表
  ///
  ///必选参数 : [type]: 电台类型 , 数字 , 可通过/dj/catelist获取 , 对应关系为 id 对应 此接口的 type, name 对应类型
  static Future<List<DjDetailsModel> ?> getDjTypeRecommend({required dynamic type}) async{

    var result = await DioUtils().get("/dj/recommend/type",{"type":type});
    if(jsonDecode(result)['code']!=200){
      return null;
    }

    try{
      var json = jsonDecode(result)['djRadios'];
      var collect = List<DjDetailsModel>.from(
          json.map((x) => DjDetailsModel.fromJson(x)));
      return collect;
    }catch(e){
      Global.logger.e(e);
    }

    return null;
  }


  ///说明 : 登录后调用此接口, 可获得电台推荐类型
  static Future<List<DjCategoryListModel> ?> getDjRecommendList() async{

    var result = await DioUtils().get("/dj/category/recommend",{});
    if(jsonDecode(result)['code']!=200){
      return null;
    }

    try{
      var json = jsonDecode(result)['data'];
      var collect = List<DjCategoryListModel>.from(
          json.map((x) => DjCategoryListModel.fromJson(x)));
      return collect;
    }catch(e){
      Global.logger.e(e);
    }
    return null;
  }

  ///说明 : 登录后调用此接口 , 传入分类,可获得对应类型电台列表
  ///limit : 返回数量 , 默认为 30
  //
  //offset : 偏移数量，用于分页 , 如 :( 页数 -1)*30, 其中 30 为 limit 的值 , 默认为 0
  //
  //cateId: 类别 id,可通过 /dj/category/recommend 接口获取
  static Future<List<DjDetailsModel> ?> getDjHotTypeRecommend({required int cateId,int ? limit,required int page}) async{
    limit ??=30;

    int offset =(page-1)*limit;

    var result = await DioUtils().get("/dj/radio/hot",{"cateId":cateId,"limit":limit,"offset":offset});
    if(jsonDecode(result)['code']!=200){
      return null;
    }

    try{
      var json = jsonDecode(result)['djRadios'];
      var collect = List<DjDetailsModel>.from(
          json.map((x) => DjDetailsModel.fromJson(x)));
      return collect;
    }catch(e){
      Global.logger.e(e);
    }

    return null;
  }





  ///说明 : 调用此接口,可获取热门电台
  ///limit : 返回数量 , 默认为 30
  //
  //offset : 偏移数量，用于分页 , 如 :( 页数 -1)*30, 其中 30 为 limit 的值 , 默认为 0 接口地址 : /dj/hot
  static Future<List<DjDetailsModel> ?> getHotDj({ int ? limit,required int page}) async{
    limit ??=30;
    var offset =(page-1)*limit;

    var result = await DioUtils().get("/dj/hot",{"limit":limit,"offset":offset});
    if(jsonDecode(result)['code']!=200){
      return null;
    }

    try{
      var json = jsonDecode(result)['djRadios'];
      var collect = List<DjDetailsModel>.from(
          json.map((x) => DjDetailsModel.fromJson(x)));
      return collect;
    }catch(e){
      Global.logger.e(e);
    }

    return null;
  }



  ///说明 : 登录后调用此接口 , 传入rid, 可获得对应电台的详情介绍
  ///
  ///必选参数 : rid: 电台 的 id
  static Future<DjDetailsModel ?> getDjDetailInfo({required int  rid}) async{
    var result = await DioUtils().get("/dj/detail",{"rid":rid});
    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json =   DjDetailsModel.fromJson(jsonDecode(result)['data']);
       return json;
    }catch(e){
      Global.logger.e(e);
    }

    return null;
  }


  ///说明 :  登录后调用此接口 , 传入rid, 可查看对应电台的电台节目以及对应的 id, 需要 注意的是这个接口返回的 mp3Url 已经无效 ,
  ///都为 null, 但是通过调用 /song/url 这 个接口 , 传入节目 id 仍然能获取到节目音频 , 如 /song/url?id=478446370 获取代 码时间的一个节目的音频
  ///
  /// 必选参数 : rid: 电台 的 id
  ///
  ///limit : 返回数量 , 默认为 30
  //
  //offset : 偏移数量，用于分页 , 如 :( 页数 -1)*30, 其中 30 为 limit 的值 , 默认为 0
  //
  //asc : 排序方式,默认为 false (新 => 老 ) 设置 true 可改为 老 => 新
  static Future<List<DjProgramModel> ?> getListDjDetailInfo({required int  rid,int ? limit}) async{
    limit ??=100;

    var result = await DioUtils().get("/dj/program",{"rid":rid,'limit':limit});
    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result)['programs'];
      var collect = List<DjProgramModel>.from(
          json.map((x) => DjProgramModel.fromJson(x)));
      return collect;
    }catch(e){
      Global.logger.e(e);
    }

    return null;
  }


  ///说明 : 调用此接口,可获取最热主播榜
  ///
  ///limit : 返回数量 , 默认为 100 (不支持 offset)
  static Future< List<DjUserTopModel> ?> getDjUserPopularTop({ int ? limit}) async{
    limit ??=100;

    var result = await DioUtils().get("/dj/toplist/popular",{"limit":limit});
    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result)['data']['list'];
      var collect = List<DjUserTopModel>.from(
          json.map((x) => DjUserTopModel.fromJson(x)));
      return collect;
    }catch(e){
      Global.logger.e(e);
    }

    return null;
  }


  ///说明 : 调用此接口,可获取主播新人榜
  ///
  ///limit : 返回数量 , 默认为 100 (不支持 offset)
  static Future< List<DjUserTopModel> ?> getDjUserNewTop({ int ? limit}) async{
    limit ??=100;

    var result = await DioUtils().get("/dj/toplist/newcomer",{"limit":limit});
    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result)['data']['list'];
      var collect = List<DjUserTopModel>.from(
          json.map((x) => DjUserTopModel.fromJson(x)));
      return collect;
    }catch(e){
      Global.logger.e(e);
    }

    return null;
  }

  ///说明 : 调用此接口,可获取 24 小时主播榜
  ///
  ///limit : 返回数量 , 默认为 100 (不支持 offset)
  static Future< List<DjUserTopModel> ?> getDjUserHoursTop({ int ? limit}) async{
    limit ??=100;

    var result = await DioUtils().get("/dj/toplist/hours",{"limit":limit});
    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result)['data']['list'];
      var collect = List<DjUserTopModel>.from(
          json.map((x) => DjUserTopModel.fromJson(x)));
      return collect;
    }catch(e){
      Global.logger.e(e);
    }

    return null;
  }

}