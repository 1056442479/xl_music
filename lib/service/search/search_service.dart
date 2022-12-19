
import 'dart:convert';

import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/model/search_key/search_hot.dart';
import 'package:qq_music/model/search_key/search_key.dart';
import 'package:qq_music/utils/Global.dart';
import 'package:qq_music/utils/HttpUtil.dart';

class SearchService{

  ///调用此接口 , 传入搜索关键词可以搜索该音乐 / 专辑 / 歌手 / 歌单 / 用户 , 关键词可以多个 ,
  ///以空格隔开 , 如 " 周杰伦 搁浅 "( 不需要登录 ), 可通过 /song/url 接口传入歌曲 id 获取具体的播放链接
  ///
  /// 必选参数 : [keywords] : 关键词
  ///
  /// 可选参数 : limit : 返回数量 , 默认为 30
  ///
  /// offset : 偏移数量，用于分页 , 如 : 如 :( 页数 -1)*30, 其中 30 为 limit 的值 , 默认为 0
  ///
  /// type: 搜索类型；默认为 1 即单曲 , 取值意义 : 1: 单曲, 10: 专辑, 100: 歌手, 1000: 歌单, 1002: 用户, 1004: MV, 1006: 歌词, 1009: 电台, 1014: 视频, 1018:综合, 2000:声音(搜索声音返回字段格式会不一样)

  static Future<SearchResultModel?> getSearchResult({required String keywords,required int page,int ? limit,int ?type}) async{
    limit ??=30;
    type ??=1;

    int offset=(page-1)*limit;

    var result = await DioUtils().get("/cloudsearch", {"keywords":keywords,"limit":limit,"offset":offset,"type":type});

    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result);
      var res = SearchResultModel.fromJson(json);
      if(res.code!=200){
        return null;
      }
      return res;
    }catch(e){
      Global.logger.e(e);
    }
    return null;
  }



  ///说明 : 调用此接口,可获取热门搜索列表
  static Future<List<SearchHotModel>?> getHotSearchResult() async{
    if(CacheGlobalData.searchHotList.isNotEmpty){
      return CacheGlobalData.searchHotList;
    }
    var result = await DioUtils().get("/search/hot/detail", {});

    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result)['data'];
      var list = List<SearchHotModel>.from(json.map((x) => SearchHotModel.fromJson(x)));
      CacheGlobalData.searchHotList.addAll(list);
      return list;
    }catch(e){
      Global.logger.e(e);
    }
    return null;
  }
}