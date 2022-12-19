
import 'package:bruno/bruno.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/model/album/album_model.dart';
import 'package:qq_music/page/song_user/album_details_page.dart';
import 'package:qq_music/service/user/user_service.dart';
import 'package:qq_music/utils/my_widget/CusBehavior.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class AlbumListPage extends StatefulWidget {
  final int id;
  const AlbumListPage({Key? key,required this.id}) : super(key: key);

  @override
  _AlbumPageState createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumListPage> with AutomaticKeepAliveClientMixin{

  List<AlbumDetailsModel> albumList =[];

  @override
  Widget build(BuildContext context) {
    super.build(context);


    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child:   MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: FutureBuilder(
            future:   getAlbumListListDetails(widget.id),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snap) {
              if (snap.connectionState == ConnectionState.done) {
                if (snap.hasError) {
                  return Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: BrnAbnormalStateWidget(
                      bgColor: Colors.transparent,
                      isCenterVertical: true,
                      themeData:BrnAbnormalStateConfig(
                          titleTextStyle:BrnTextStyle(color: Colors.red,fontSize: 18)
                      ),
                      title: "数据出错",
                    ),
                  );
                }
                return  albumList.isEmpty?const Center(child: Text("数据为空",style: TextStyle(color: Colors.white),),):   ScrollConfiguration(
                  behavior: CusBehavior(),
                  child: GridView.builder( shrinkWrap: false,

//                        padding: EdgeInsets.all(10.w),
                      itemCount: albumList.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        /// 纵轴间距
                        mainAxisSpacing: 20.0,
                        /// 横轴间距
                        crossAxisSpacing: 30.0,
                        /// 横轴元素个数
                        crossAxisCount: 4,
                        /// 宽高比
                        childAspectRatio: 0.9,
                      ), itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            Get.to(()=>AlbumDetailsPage(id: albumList[index].id, 
                              createTime: albumList[index].publishTime, name:albumList[index].name, picUrl: albumList[index].picUrl, username: albumList[index].artist?.name ?? "未知",
                              uid:  albumList[index].artist!.id,),transition: Transition.rightToLeft);
                          },
                          child: LayoutBuilder(
                            builder: (context , constraints ) {
                              return    Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width:double.infinity,
                                    height: constraints.biggest.height-50,
                                    child:      ExtendedImage.network(
                                        albumList[index].picUrl,
                                        fit: BoxFit.fill,
                                        cache: true,
                                        width: constraints.biggest.width,
                                        height: constraints.biggest.height-45,
                                    )),

                                  const SizedBox(height: 10,),
                                  SizedBox(
                                    height: 40,
                                    child: Text(albumList[index].name,style: const TextStyle(color: Colors.white,fontSize: 15),textScaleFactor: 1,),
                                  )
                                ],);
                            },
                          ),
                        );
                      }),
                );
              } else if (snap.connectionState == ConnectionState.active) {
                return   Container();
              } else if (snap.connectionState == ConnectionState.waiting) {
                return Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: const Center(
                      child: SleekCircularSlider(
                          appearance: CircularSliderAppearance(
                            spinnerMode: true,
                          ))
                  ),
                );
              } else if (snap.connectionState == ConnectionState.none) {
                return Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: BrnAbnormalStateWidget(
                    bgColor: Colors.transparent,
                    isCenterVertical: true,
                    themeData:BrnAbnormalStateConfig(
                        titleTextStyle:BrnTextStyle(color: Colors.white,fontSize: 18)
                    ),
                    title: "暂无数据",
                  ),
                );
              }
              return Container();
            },

          ),
        ))

      ],
    );
  }

  getAlbumListListDetails(int id) async{
    if(albumList.isEmpty){
      //先获取缓存
      var indexWhere = CacheGlobalData.cacheAlbumDetailsList.indexWhere((element) => element['id']==id);
      if(indexWhere>=0){
        albumList = CacheGlobalData.cacheAlbumDetailsList[indexWhere]['al'];
        return;
      }

      var list = await UserSerVice.getAlbumListInfo(id: id);
      if(list!=null && list.isNotEmpty){
        CacheGlobalData.cacheAlbumDetailsList.add({
          "id":id,
          "al":list
        });

        albumList =list;
      }
    }

  }

  @override
  bool get wantKeepAlive => true;


}
