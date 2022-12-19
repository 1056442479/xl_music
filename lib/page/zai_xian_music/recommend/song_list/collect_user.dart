
import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/model/user/recommend_collect_user.dart';
import 'package:qq_music/page/user/user_details_page.dart';
import 'package:qq_music/service/user/user_service.dart';
import 'package:qq_music/utils/Global.dart';
import 'package:qq_music/utils/my_widget/CusBehavior.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class CollectUserPage extends StatefulWidget {
  final int id;
  const CollectUserPage({Key? key,required this.id}) : super(key: key);



  @override
  State createState() => _CollectUserPageState();
}

class _CollectUserPageState extends State<CollectUserPage> with AutomaticKeepAliveClientMixin{
  List<RecommendCollectUser> collectList =[];



  @override
  void initState() {
    super.initState();
    Global.logger.d("歌曲列表创建了");
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return   MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: FutureBuilder(
        future:   getPlaylistCollectUserInfo(widget.id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snap) {
          if (snap.connectionState == ConnectionState.done) {
            if (snap.hasError) {
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
            return  collectList.isEmpty?const Center(child: Text("暂无数据",style: TextStyle(color: Colors.white,fontSize: 18),),):  ScrollConfiguration(
              behavior: CusBehavior(),
              child:   Container(
                padding: const EdgeInsets.only(left: 8,right: 8,top: 8,bottom: 0),
                child: GridView.builder(
                    itemCount: collectList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      /// 纵轴间距
                      mainAxisSpacing: 25,
                      /// 横轴间距
                      crossAxisSpacing: 20,
                      /// 横轴元素个数
                      crossAxisCount: 4,
                      /// 宽高比
                      childAspectRatio: 1.2,
                    ), itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      Get.to(UserDetailsPage(uid: collectList[index].userId, username: collectList[index].nickname));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 15,right: 15),
                      child: Column(
                        children: [
                          Expanded(child:   Container(
                              decoration:  BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image:NetworkImage(collectList[index].avatarUrl) ,
                                      fit: BoxFit.cover
                                  )
                              )
                          ))
                        ,
                          const SizedBox(width: 10,),
                          Text(
                            collectList[index].nickname,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textScaleFactor: 1,
                            style: const TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),

                        ],
                      ),
                    ),
                  );
                }),
              ),
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
    );
  }





  getPlaylistCollectUserInfo(int id) async{
    //先获取缓存
    var indexWhere = CacheGlobalData.cacheSongCollectList.indexWhere((element) => element['id']==id);
    if(indexWhere>=0){
      collectList = CacheGlobalData.cacheSongCollectList[indexWhere]['collect'];
      return;
    }
    var getList = await UserSerVice.getPlaylistCollectUserInfo(id: id);
    Global.logger.d("collect----获取的数据--$getList");
    if(getList!=null){
      if(getList.isNotEmpty) {
        CacheGlobalData.cacheSongCollectList.add({
          "id": id,
          "collect": getList
        });
        collectList = getList;
      }
    }
  }

  @override
  bool get wantKeepAlive =>true;

}
