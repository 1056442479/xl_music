

import 'package:get/get.dart';
import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/model/song/song_list_details.dart';

class SearchController extends GetxController{
  //正在播放的专辑或者歌单的id
    RxInt  total =CacheGlobalData.total.obs;

  ///改变值
   changeTotal(int t){
    CacheGlobalData.total =t;
    total.value =t;
  }

}