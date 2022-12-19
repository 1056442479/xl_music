
import 'dart:convert';

import 'package:qq_music/model/mv/mv_details.dart';
import 'package:qq_music/model/mv/mv_du.dart';
import 'package:qq_music/model/mv/mv_simli_model.dart';
import 'package:qq_music/model/mv/mv_top_model.dart';
import 'package:qq_music/model/mv/mv_play_url.dart';
import 'package:qq_music/utils/Global.dart';
import 'package:qq_music/utils/HttpUtil.dart';

class MvService{

  /// 调用此接口 , 可获取推荐 mv
  static Future<List<MvDetailsModel> ?>  getMvPerRecommend() async{
    var result = await DioUtils().get("/personalized/mv",{});
    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result)['result'];
      var collect = List<MvDetailsModel>.from(
          json.map((x) => MvDetailsModel.fromJson(x)));
      return collect;
    }catch(e){
      Global.logger.e(e);
    }

    return null;
  }

  /// 调用此接口 , 传入歌手 id, 可获得歌手 mv 信息(不包含播放地址)
  ///[id] 歌手id
  static Future<List<MvDetailsModel> ?>  getMvListInfo({required int id}) async{
    var result = await DioUtils().get("/artist/mv", {"id":id});

    try{
      var json = jsonDecode(result)['mvs'];

      Global.logger.d(json);
      var collect = List<MvDetailsModel>.from(
          json.map((x) => MvDetailsModel.fromJson(x)));


      return collect;
    }catch(e){
      Global.logger.e(e);
    }

    return null;
  }

  /// 说明 : 调用此接口 , 传入 mv id,可获取 mv 播放地址
  /// 可选参数 : r: 分辨率,默认 1080,可从 /mv/detail 接口获取分辨率列表
  ///[id] id: mv id
  static Future<MvPlayUrlModel ?>  getMvPlayUrl({required int id}) async{
    var result = await DioUtils().get("/mv/url", {"id":id});
    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result)['data'];
      return MvPlayUrlModel.fromJson(json);
    }catch(e){
      Global.logger.e(e);
    }
    return null;
  }


  ///调用此接口 , 传入 mvid 可获取相似 mv
  ///[mvid]必选参数 : mvid: mv id
  static Future<List<SimilarMvModel> ?>  getSimilarMvInfo({required int mvid}) async{
    var result = await DioUtils().get("/simi/mv", {"mvid":mvid});
    try{
      var json = jsonDecode(result)['mvs'];
      var list = List<SimilarMvModel>.from(json.map((e)=>SimilarMvModel.fromJson(e)));
      return list;
    }catch(e){
      Global.logger.e(e);
    }
    return null;
  }
  /// 调用此接口 , 传入 mvid ( 在搜索音乐的时候传 type=1004 获得 ) , 可获取对应 MV 数据 , 数据包含 mv 名字 , 歌手 , 发布时间 , mv 视频地址等数据 , 其中 mv 视频 网易做了防盗链处理 , 可能不能直接播放 , 需要播放的话需要调用 ' mv 地址' 接口
  ///
  ///[mvid]必选参数 : mvid: mv id
  static Future<MvDetailsModel ?>  getMvDetailsInfo({required int mvid}) async{
    var result = await DioUtils().get("/mv/detail", {"mvid":mvid});
    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result)['data'];
      var list =MvDetailsModel.fromJson(json);
      return list;
    }catch(e){
      Global.logger.e(e);
    }
    return null;
  }

  ///说明 : 调用此接口 , 可获取最新 mv
  ///
  ///可选参数 : limit: 取出数量 , 默认为 30
  ///
  /// area: 地区,可选值为全部,内地,港台,欧美,日本,韩国,不填则为全部
  static Future<List<MvDetailsModel> ?>  getFirstMvList({ int ? limit,String ? area}) async{
    limit ??=30;
    area ??="全部";

    List<String> areaList =["全部","内地","港台","欧美","日本","韩国"];
    if(!areaList.contains(area)){
      return null;
    }

    var result = await DioUtils().get("/mv/first", {"limit":limit,"area":area});
    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result)['data'];
      var list = List<MvDetailsModel>.from(json.map((e)=>MvDetailsModel.fromJson(e)));
      return list;
    }catch(e){
      Global.logger.e(e);
    }
    return null;
  }

  ///说明 : 调用此接口 , 可获取 mv 排行
  ///
  ///可选参数 : limit: 取出数量 , 默认为 30 ,最多50
  ///
  /// area: 地区,可选值为内地,港台,欧美,日本,韩国,不填则为全部
  ///
  /// offset: 偏移数量 , 用于分页 , 如 :( 页数 -1)*30, 其中 30 为 limit 的值 , 默认 为 0
  static Future<List<MvTopModel> ?>  getTopMvList({ int ? limit,String ? area,required int  page}) async{
    limit ??=50;
    int offset =(page-1)*limit;
    Map<String,dynamic> map ={"limit":limit,"offset":offset, "area":area};

    if(area!=null){
      List<String> areaList =["内地","港台","欧美","日本","韩国"];
      if(!areaList.contains(area)){
        return null;
      }
      map['area']=area;
    }

    var result = await DioUtils().get("/top/mv", map);
    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result)['data'];
      var list = List<MvTopModel>.from(json.map((e)=>MvTopModel.fromJson(e)));
      Global.logger.d(list.length);
      return list;
    }catch(e){
      Global.logger.e(e);
    }
    return null;
  }


  ///说明 : 调用此接口 , 可获取 mv 排行
  ///
  ///可选参数 : limit: 取出数量 , 默认为 30
  ///
  ///order: 排序,可选值为上升最快,最热,最新,不填则为上升最快
  ///
  /// area地区,可选值为全部,内地,港台,欧美,日本,韩国,不填则为全部
  ///
  /// type: 类型,可选值为全部,官方版,原生,现场版,网易出品,不填则为全部
  ///
  /// offset: 偏移数量 , 用于分页 , 如 :( 页数 -1)*30, 其中 30 为 limit 的值 , 默认 为 0
  static Future<List<MvDetailsModel> ?>  getAllMvList({ int ? limit,String ? area,String ? order,String ? type,required int  page}) async{
    limit ??=30;
    int offset =(page-1)*limit;
    area ??="全部";
    order ??="上升最快";
    type ??="全部";


    var result = await DioUtils().get("/mv/all", {"limit":limit,"offset":offset, "area":area,"order":order,"type":type});
    Global.logger.d(result);
    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result)['data'];
      var list = List<MvDetailsModel>.from(json.map((e)=>MvDetailsModel.fromJson(e)));
      return list;
    }catch(e){
      Global.logger.e(e);
    }
    return null;
  }

  ///说明 : 调用此接口 , 可获取网易出品 mv
  ///
  /// 可选参数 : limit: 取出数量 , 默认为 30
  //
  //offset: 偏移数量 , 用于分页 , 如 :( 页数 -1)*30, 其中 30 为 limit 的值 , 默认 为 0
  static Future<List<MvDetailsModel> ?>  getExclusiveMvList({ int ? limit,required int  page}) async{
    limit ??=30;

    int offset =(page-1)*limit;

    var result = await DioUtils().get("/mv/exclusive/rcmd", {"limit":limit,"offset":offset});
    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result)['data'];
      var list = List<MvDetailsModel>.from(json.map((e)=>MvDetailsModel.fromJson(e)));
      return list;
    }catch(e){
      Global.logger.e(e);
    }
    return null;
  }






  ///说明 : 调用此接口 , 可获取独家放送列表
  ///
  /// 可选参数 : limit: 取出数量 , 默认为 60
  //
  //offset: 偏移数量 , 用于分页 , 如 :( 页数 -1)*30, 其中 30 为 limit 的值 , 默认 为 0
  static Future<List<MvDuModel> ?>  getPrivateContentMvList({ int ? limit,required int  page}) async{
    limit ??=30;

    int offset =(page-1)*limit;

    var result = await DioUtils().get("/personalized/privatecontent/list", {"limit":limit,"offset":offset});
    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result)['result'];
      var list = List<MvDuModel>.from(json.map((e)=>MvDuModel.fromJson(e)));
      return list;
    }catch(e){
      Global.logger.e(e);
    }
    return null;
  }

}