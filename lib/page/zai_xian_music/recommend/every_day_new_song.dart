
import 'package:card_swiper/card_swiper.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:qq_music/service/song/song_service.dart';

///每日新碟推荐
class EveryDayNewSong extends StatefulWidget {
  final int type;
  const EveryDayNewSong({Key? key,required this.type}) : super(key: key);

  @override
  _EveryDayNewSongState createState() => _EveryDayNewSongState();
}

class _EveryDayNewSongState extends State<EveryDayNewSong> with AutomaticKeepAliveClientMixin{
  List<String> newSongList=[];

  @override
  void initState() {
    super.initState();
    getEveryDayNewSong();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: const EdgeInsets.only(top: 0,bottom: 30),
      child:   Container(
          height:200,
          width: double.infinity*0.7,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 20,),
          child:Swiper(
            itemBuilder: (BuildContext context, int index) {
              return ExtendedImage.network(
                newSongList[index],
                fit: BoxFit.cover,
              );
            },
            controller: SwiperController(),
            itemCount: newSongList.length,
             viewportFraction: 0.6,// 当前视窗展示比例 小于1可见上一个和下一个视窗
                  scale: 0.6, // 两张图片之间的间隔

            index: 1,
            autoplay: true,
            loop: true,
            autoplayDisableOnInteraction: true, // 用户进行操作时停止自动翻页

          )),
    );
  }

  ///获取轮播图
  getEveryDayNewSong() async{
    var getList = await SongService.getBanner(type: widget.type);
    if(getList!=null){
      setState(() {
        newSongList =getList;
      });
    }
  }

//  ///获取每日推荐的mv
//  getEveryDayNewSong() async{
//      var getList = await SongService.getEveryDayNewSong();
//      if(getList!=null){
//        setState(() {
//          newSongList =getList;
//        });
//      }
//  }

  @override
  bool get wantKeepAlive => true;

}
