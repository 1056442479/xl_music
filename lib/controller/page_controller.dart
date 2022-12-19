
import 'package:get/get.dart';

class MusicPageController extends GetxController{


  ///是否正在播放
  RxBool playIng =false.obs;

  ///每日推荐的歌单信息
  Map recommendSongPLay ={}.obs;

  RxString albumDesc="暂无介绍".obs;



  changeAlbumDesc(String desc){
    albumDesc.value =desc;
  }

  
}