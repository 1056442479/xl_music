
import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:qq_music/const/global.dart';
import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/controller/system_controller.dart';
import 'package:qq_music/model/song/song_list_details.dart';
import 'package:qq_music/utils/commutils.dart';


class MoreDealDownPage extends StatefulWidget {
  const MoreDealDownPage({Key? key}) : super(key: key);

  @override
  _MoreDealDownPageState createState() => _MoreDealDownPageState();
}

class _MoreDealDownPageState extends State<MoreDealDownPage> {
  bool addList =false;
  ///更多操作列表
  List<Song> moreList =[];
  ///已选则的歌曲
  List<Song> selectList=[];

  late  StateSetter textSetState ;

  @override
  void initState() {
    super.initState();
    moreList.addAll(CacheGlobalData.delMoreList);
    selectList.addAll(CacheGlobalData.delMoreList);
  }


  @override
  Widget build(BuildContext context) {
    SystemController systemController = Get.put(SystemController());

    return Material(
      color: const Color.fromRGBO(30, 30, 31, 1),
      child: Column(
        children: [
          //操作按钮
          Container(
            padding:const EdgeInsets.only(left: 40,right: 40),
            color:const Color.fromRGBO(36, 36, 37, 1),
            height: 80,
            child: Row(
              children: [
                ///下载
                const SizedBox(width: 10,),
                InkWell(
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap:(){
                    if(selectList.isEmpty){
                      EasyLoading.showToast("请先选择下载内容");
                      return;
                    }
                    ThisProjectUtils.dealMoreDown(selectList);
                  },
                  child: Container(
                    width: 120,
                    height: 35,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Color.fromRGBO(52, 52, 53, 1)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(Icons.download_rounded,color: Colors.white,size: 17,),
                        SizedBox(width: 5,),
                        Text("下载",style: TextStyle(color: Colors.white,fontSize: 15),)
                      ],
                    ),
                  ),
                ),
                const   SizedBox(width: 10,),

                Text("下载到${settingModel.downUrl}",style:const TextStyle(color: Colors.grey,fontSize: 14),),
                const   SizedBox(width: 10,),

                TextButton(onPressed:(){
                  changeDirectory(systemController);
                } , child: const Text("更改目录",style: TextStyle(color: Color.fromRGBO(32, 158, 117, 1),fontSize: 14),)),


                ///退出
                Expanded(child: Container()),
                InkWell(
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap:(){
                    Get.back();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 120,
                    height: 35,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Color.fromRGBO(52, 52, 53, 1)
                    ),
                    child:  const Text("退出批量下载",style: TextStyle(color: Colors.white,fontSize: 13),),
                  ),
                )
              ],
            ),
          ),
          ///音质选择
          Container(
            padding:const EdgeInsets.only(left: 40,right: 40,top: 10,bottom: 10),
            child:     Obx(() {
              return Row(
                children: [
                  const Text("下载优先选择",style: TextStyle(color: Colors.grey,fontSize: 14),),
                  const SizedBox(width: 8,),
                  //标准
                  SizedBox(
                    width:100,
                    child: RadioListTile(
                      contentPadding: const EdgeInsets.only(left: 8),
                      dense:true,
                      value: 0,
                      groupValue: settingModel.downMusicLevel,
                      onChanged: (value) {
                        systemController.downMusicLevel.value=value ?? 0;
                        settingModel.downMusicLevel =0;
                      },
                      title: const Text("标准", style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),),
                      selected: systemController.downMusicLevel.value == 0,
                    ),
                  ),
                  // 较高
                  SizedBox(
                    width:100,
                    child: RadioListTile(
                      contentPadding: const EdgeInsets.only(left: 8),
                      dense:true,
                      value: 1,
                      groupValue: systemController.downMusicLevel.value,
                      onChanged: (value) {
                        systemController.downMusicLevel.value=value ?? 1;
                        settingModel.downMusicLevel =1;
                      },
                      title: const Text("较高", style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),),
                      selected: systemController.downMusicLevel.value == 1,
                    ),
                  ),
                  // 极高
                  SizedBox(
                    width:100,
                    child: RadioListTile(
                      contentPadding: const EdgeInsets.only(left: 8),
                      dense:true,
                      value: 2,
                      groupValue: systemController.downMusicLevel.value,
                      onChanged: (value) {
                        systemController.downMusicLevel.value=value ?? 2;
                        settingModel.downMusicLevel =2;
                      },
                      title: const Text("极高", style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),),
                      selected: systemController.downMusicLevel.value == 2,
                    ),
                  ),
                  // 无损
                  SizedBox(
                    width:100,
                    child: RadioListTile(
                      contentPadding: const EdgeInsets.only(left: 8),
                      dense:true,
                      value: 3,
                      groupValue: systemController.downMusicLevel.value,
                      onChanged: (value) {
                        systemController.downMusicLevel.value=value ?? 3;
                        settingModel.downMusicLevel =3;
                      },
                      title: const Text("无损", style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),),
                      selected: systemController.downMusicLevel.value == 3,
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                        borderRadius: const BorderRadius.all(Radius.circular(5))
                    ),
                    padding: const EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
                    child: const Text("VIP",style: TextStyle(color: Colors.red,fontSize: 14),),
                  ),
                  Expanded(child: Container())
                ],
              );
            }),
          ),
         
          Expanded(child: Container(
            margin:const EdgeInsets.only(left: 20,right: 20),
            child: Column(
              children: [
                //表头
                Container(
                  margin:  const EdgeInsets.only(left: 15,right: 15,top: 10),
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child:  Row(
                            children: [
                              Checkbox(value: selectList.length==moreList.length, onChanged: (e){
                                setState(() {
                                  if(e!){
                                    selectList.addAll(moreList);
                                  }else{
                                    selectList.length=0;
                                  }
                                });
                              }),
                              const SizedBox(width: 5,),
                              StatefulBuilder(
                                builder: (BuildContext context, void Function(void Function()) setState) {
                                  textSetState =setState;
                                  return Text("已选${selectList.length}首",style: const TextStyle(color: Colors.grey,fontSize: 13),textScaleFactor:1);
                                },)
                            ],
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("歌手",style: TextStyle(color: Colors.grey,fontSize: 13),textScaleFactor:1),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("专辑",style: TextStyle(color: Colors.grey,fontSize: 13),textScaleFactor:1),
                        ),
                      ),
                    ],
                  ),
                ),

                //歌曲列表
                Expanded(child:
                ListView.builder( addAutomaticKeepAlives: true,
                  itemCount: moreList.length,
                  itemBuilder: (context, index) {
                    return StatefulBuilder(
                      builder: (BuildContext context, void Function(void Function()) setStates) {
                        return Container(
                          height: 40,
                          margin: const EdgeInsets.only(top: 5,bottom: 5,left: 15,right: 15),
                          child: GestureDetector(
                            behavior:HitTestBehavior.translucent,
                            onDoubleTap:(){

                            } ,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //名称
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        //复选框
                                        Checkbox(value: selectList.contains(moreList[index]), onChanged: (e){
                                          setStates(() {
                                            if(e==false){
                                              selectList.removeWhere((element) => element.id==moreList[index].id);
                                            }else{
                                              selectList.add(moreList[index]);
                                            }
                                          });
                                          textSetState((){
                                            selectList;
                                          });
                                        }),
                                        const SizedBox(width: 10,),

                                        Expanded(
                                            child: Container(
                                              constraints: const BoxConstraints(
                                                  minWidth: 50, maxWidth: 500),
                                              child: AutoSizeText(
                                                moreList[index].name,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w200),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                minFontSize: 11,
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                                const  SizedBox(width: 10,),
                                // 歌手
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 7),
                                    alignment: Alignment.centerLeft,
                                    child:  ListView.builder(itemBuilder: (context,authorIndex){
                                      return Center(
                                        child: AutoSizeText("${
                                            authorIndex==moreList[index].ar.length-1?moreList[index].ar[authorIndex].name:"${moreList[index].ar[authorIndex].name}/"} "
                                          ,textScaleFactor: 1,minFontSize: 11,
                                          style:  const TextStyle(color: Colors.white,fontSize: 13),maxLines: 2,  overflow: TextOverflow.ellipsis,

                                        ),
                                      );
                                    },itemCount: moreList[index].ar.length,shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                //专辑
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 7),
                                    alignment: Alignment.centerLeft,
                                    child:  ListTile(
                                      contentPadding: const EdgeInsets.all(0),
                                      title:AutoSizeText(moreList[index].al.name.trim(),minFontSize: 11
                                        ,style:  const TextStyle(color:
                                        Colors.white,fontSize: 14,fontWeight: FontWeight.w200),maxLines: 2,  overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                )

                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },)
                )
              ],
            ),
          ),)


        ],
      ),
    );
  }

  ///更改目录
  void changeDirectory(SystemController systemController) async{
    final String? path = await getDirectoryPath();
    if (path == null) {
      EasyLoading.showToast("取消选择");
    }else{
      systemController.defaultDownUrl.value =path;
      settingModel.downUrl =path;
    }
  }
}
