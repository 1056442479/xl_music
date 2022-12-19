

import 'dart:async';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/controller/search_controller.dart';
import 'package:qq_music/model/event/event_model.dart';
import 'package:qq_music/page/user/user_details_page.dart';
import 'package:qq_music/service/search/search_service.dart';
import 'package:qq_music/utils/Global.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../../model/search_key/search_key.dart';

///用户搜索结果页
class ResUserPage extends StatefulWidget {
  final SearchController searchController;
  const ResUserPage({Key? key,required this.searchController}) : super(key: key);

  @override
  State createState() => _ResUserPageState();
}

class _ResUserPageState extends State<ResUserPage> with AutomaticKeepAliveClientMixin{
  bool addList =false;
  bool play =false;
  int total =0;
  int page =1;
  ///请求是否结束
  bool dataRes=false;
  ///是否初始请求
  bool initRes =true;
  String keyword="";

  ScrollController scrollController =ScrollController();
  List<UserSearchModel> userList =[];
  late StreamSubscription stream;


  @override
  void initState() {
    super.initState();
    keyword =CacheGlobalData.keyword;



    stream=  Global.getInstance()!.on<StartSearch>().listen((event) {
      if(keyword!=CacheGlobalData.keyword){
        keyword =CacheGlobalData.keyword;
        getResUserList(init: true);
      }
    });



    scrollController.addListener(() {
      if (scrollController.offset+150>= scrollController.position.maxScrollExtent) {
        if(dataRes==false){
          dataRes=true;
          debugPrint("滚动到底部bottom了...");
          page+=1;
          getResUserList(init: false,);
        }
      }
    });
    getResUserList(init: true);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Material(
      color: const Color.fromRGBO(30, 30, 31, 1),
      child: Container(
        margin:const EdgeInsets.only(left: 20,right: 20,top: 20),
        child: initRes? const Center(
            child: SleekCircularSlider(
                appearance: CircularSliderAppearance(
                  spinnerMode: true,
                ))
        ): ListView.builder(itemBuilder: (context, index) {
          return InkWell(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor:Colors.transparent,
            onTap: (){
                Get.to(()=>UserDetailsPage(uid: userList[index].userId, username: userList[index].nickname),transition: Transition.rightToLeft);
            },
            child: Container(
              margin:const EdgeInsets.only(bottom: 20),
              height: 70,
              color: const Color.fromRGBO(36, 36, 37, 1),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(5),
                          child: ExtendedImage.network(
                            userList[index].avatarUrl,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(child:   Container(
                          margin: const EdgeInsets.only(left: 15),
                          constraints: const BoxConstraints(
                              maxWidth: 300,
                              minWidth: 100
                          ),
                          child: Text(userList[index].nickname,style: const TextStyle(color: Colors.white,fontSize: 14),maxLines: 1,overflow: TextOverflow.ellipsis,),
                        ),)
                      ],
                    ),
                  ),


                  Expanded(flex: 1,child: Container(),),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.only(right: 30),
                      alignment: Alignment.centerLeft,
                      child:  Text(userList[index].playlistCount >10000?"歌单${ (userList[index].playlistCount/10000).truncate()}万":"歌单${userList[index].playlistCount}" ,style:const TextStyle(
                          color: Colors.white,fontSize: 13
                      ),),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.only(right: 30),
                      alignment: Alignment.centerLeft,
                      child:  Text(userList[index].followeds >10000?"粉丝${ (userList[index].followeds/10000).truncate()}万":"粉丝${userList[index].followeds}" ,style:const TextStyle(
                          color: Colors.white,fontSize: 13
                      ),),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      EasyLoading.showToast("该操作需要登录");
                    },
                    child: Container(
                      width: 80,
                      height: 25,
                      padding:const EdgeInsets.only(left: 10,right: 10),
                      decoration:const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          color: Color.fromRGBO(52, 52, 52, 1)
                      ),
                      child: Row(
                        children:const [
                          FaIcon(Icons.add,color: Colors.white,size: 20,),
                          SizedBox(width: 5,),
                          Text("关注",style: TextStyle(color: Colors.white,fontSize: 15),)
                        ],
                      ),
                    ),
                  ),
                 const SizedBox(width: 30,)
                ],
              ),
            ),
          );
        },itemCount: userList.length,shrinkWrap: true,),
      ),
    );
  }




  ///获取数据
  getResUserList({required bool init}) async{
    if(mounted){
      setState(() {
        if(init){
          page=1;
          initRes=true;
          dataRes =true;
          total=0;
          userList.length=0;
        }
      });

      if(userList.length>=total && userList.isNotEmpty){
        EasyLoading.showToast("没有更多了");
        return;
      }
      try{
        var recSong = await SearchService.getSearchResult(keywords:keyword.trim(), page: page,limit: 50,type: 1002);
        if(recSong!=null ){
          if(recSong.result.userprofiles!=null){
            total =recSong.result.userprofileCount!;
            if(init){
              userList =recSong.result.userprofiles!;
              CacheGlobalData.userCount=total;
              widget.searchController.total.value=recSong.result.userprofileCount!;
            }else{
              userList.addAll(recSong.result.userprofiles!);
            }

            setState(() {
              initRes=false;
            });
          }
        }
      }catch(e){
        Global.logger.e(e);
      }

      dataRes =false;
    }

  }



  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    stream.cancel();
    scrollController.dispose();
  }
}
