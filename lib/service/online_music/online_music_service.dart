

import 'dart:convert';


import 'package:qq_music/model/top/top_sort.dart';
import 'package:qq_music/model/user/song_user_select.dart';

import 'package:qq_music/utils/Global.dart';
import 'package:qq_music/utils/HttpUtil.dart';

///音乐馆的接口
class OnlineMusicService{

  ///说明 : 调用此接口,可获取所有榜单内容摘要
  static Future<List<TopSortModel> ?>  getTopData() async{
    var result = await DioUtils().get("/toplist/detail",{});
    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result)['list'];
      var collect = List<TopSortModel>.from(
          json.map((x) => TopSortModel.fromJson(x)));
      return collect;
    }catch(e){
      Global.logger.e(e);
    }

    return null;
  }


  ///说明 : 调用此接口,可获取歌手分类列表
  ///[type] -1:全部 1:男歌手 2:女歌手 3:乐队
  ///[area ] -1:全部 7:华语 96:欧美 8:日本 16:韩国 0:其他
  ///[initial] (a-z | -1 |# 传 0)  按首字母索引查找参数, 返回内容将以 name 字段开头为 b 或者拼音开头为 b 为顺序排列,热门传-1
  ///limit : 返回数量 , 默认为 30
  //
  //offset : 偏移数量，用于分页 , 如 : 如 :( 页数 -1)*30, 其中 30 为 limit 的值 , 默认为 0 initial: 按首字母索引查找参数,如 /artist/list?type=1&area=96&initial=b 返回内容将以 name 字段开头为 b 或者拼音开头为 b 为顺序排列, 热门传-1,#传 0
  static Future<List<SongUserSelect> ?>  getGroupSongUser({ int ? type, int ? area ,dynamic  initial ,int ? limit,required int page}) async{
    if(page<1){
     return [];
    }
    type ?? -1;
    area ?? -1;
    initial ?? -1;
    limit ?? 28;
    int offset =(page-1)* limit!;

    var result = await DioUtils().get("/artist/list",{
      "type":type,"area":area,"limit":limit,"offset":offset,"initial":initial
    });
    if(jsonDecode(result)['code']!=200){
      return null;
    }
    try{
      var json = jsonDecode(result)['artists'];
      var collect = List<SongUserSelect>.from(
          json.map((x) => SongUserSelect.fromJson(x)));
      return collect;
    }catch(e){
      Global.logger.e(e);
    }
    return null;
  }
}