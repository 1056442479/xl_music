


import 'package:card_swiper/card_swiper.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:qq_music/service/song/song_service.dart';



///每日新碟推荐
class SelectBannerPage extends StatefulWidget {
  const SelectBannerPage({Key? key}) : super(key: key);

  @override
  _EveryDayNewSongState createState() => _EveryDayNewSongState();
}

class _EveryDayNewSongState extends State<SelectBannerPage> with AutomaticKeepAliveClientMixin{
  List<String> newSongList=[];

  @override
  void initState() {
    super.initState();
    getEveryDayNewBanner();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: const EdgeInsets.only(top: 0,bottom: 10),
      child:   Container(
          height:150,
          width: double.infinity*0.5,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 20,left: 20,right: 20),
          child:Swiper(
            itemBuilder: (BuildContext context, int index) {
              return ExtendedImage.network(
                newSongList[index],
                fit: BoxFit.cover,
              );
            },
            controller: SwiperController(),
            itemCount: newSongList.length,
             viewportFraction: 0.4,// 当前视窗展示比例 小于1可见上一个和下一个视窗
                  scale: 0.6, // 两张图片之间的间隔
            index: 1,
            autoplay: true,
            loop: true,
            autoplayDisableOnInteraction: true, // 用户进行操作时停止自动翻页

          )),
    );
  }

  ///获取轮播图
  getEveryDayNewBanner() async{
    var getList = await SongService.getBanner(type: 3);
    if(getList!=null){
      setState(() {
        newSongList =getList;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;

}
