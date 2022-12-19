import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:qq_music/controller/down_del/down_del_model.dart';
import 'package:qq_music/model/event/event_model.dart';
import 'package:qq_music/utils/Global.dart';
import 'package:qq_music/utils/commutils.dart';
import 'package:text_scroll/text_scroll.dart';




class DownErrorPage extends StatefulWidget {
  const DownErrorPage({Key? key}) : super(key: key);

  @override
  _DownErrorPageState createState() => _DownErrorPageState();
}

class _DownErrorPageState extends State<DownErrorPage> with AutomaticKeepAliveClientMixin{

  List<Map<dynamic, dynamic>> downError = DownDelControllerModel.downErrorList;
  late StreamSubscription downErrorListen;

  @override
  void initState() {
    super.initState();

    downErrorListen =
        Global.getInstance()!.on<ChangeErrorOver>().listen((event) {
          if(mounted){
            setState(() {
              downError = DownDelControllerModel.downErrorList;
            });
          }
        });
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);


    return Material(
      color: const Color.fromRGBO(30, 30, 31, 1),
      child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              SizedBox(
                height: 80,
                child: Row(
                  children: [
                    Expanded(child: Container()),
                    InkWell(
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        if(downError.isEmpty){
                          EasyLoading.showToast("列表为空，无需清除");
                          return;
                        }
                        BrnDialogManager.showConfirmDialog(context,
                            title: "提示",
                            cancel: '取消',
                            confirm: '确定',
                            message: "您是否选择清空下载错误歌曲", onConfirm: () {
                              Get.back();
                              dealAllSong();
                            }, onCancel: () {
                              Get.back();
                            });

                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 130,
                        height: 35,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Color.fromRGBO(52, 52, 53, 1)
                        ),
                        child: const Text("清空全部",
                          style: TextStyle(color: Colors.white, fontSize: 15),),
                      ),
                    )
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text("歌曲",
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                            textScaleFactor: 1),
                      ),
                    ),

                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text("歌手",
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                            textScaleFactor: 1),
                      ),
                    ),

                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text("专辑",
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                            textScaleFactor: 1),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text("错误描述",
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                            textScaleFactor: 1),
                      ),
                    ),
                  ],
                ),
              ),

              //下载列表
              Expanded(child:
              ListView.builder(addAutomaticKeepAlives: true,
                itemCount:   downError.length,
                itemBuilder: (context, index) {
                  return StatefulBuilder(
                    builder: (BuildContext context,
                        void Function(void Function()) setStates) {
                      return Container(
                        height: 40,
                        margin: const EdgeInsets.only(
                            top: 5, bottom: 5, left: 15, right: 15),
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onDoubleTap: () {

                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //名称
                              Expanded(
                                  flex: 2,
                                  child:  Container(
                                    constraints: const BoxConstraints(
                                        minWidth: 50, maxWidth: 500),
                                    child: AutoSizeText(
                                      downError[index]['song'].name,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w200),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      minFontSize: 11,
                                    ),
                                  )
                              ),
                              const SizedBox(width: 10,),
                              // 歌手
                              Expanded(
                                flex: 2,
                                child: Container(
                                    margin: const EdgeInsets.only(right: 7),
                                    alignment: Alignment.centerLeft,
                                    child: AutoSizeText(downError[index]['song'].name
                                      , textScaleFactor: 1,
                                      minFontSize: 11,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 13),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,

                                    )
                                ),
                              ),
                              const SizedBox(width: 10,),
                              // 专辑
                              Expanded(
                                flex: 2,
                                child: Container(
                                    margin: const EdgeInsets.only(right: 7),
                                    alignment: Alignment.centerLeft,
                                    child: AutoSizeText(downError[index]['song'].al.name
                                      , textScaleFactor: 1,
                                      minFontSize: 11,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 13),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,

                                    )
                                ),
                              ),
                              const SizedBox(width: 10,),
                              //大小
                              Expanded(
                                flex: 3,
                                child: Container(
                                  margin: const EdgeInsets.only(right: 7),
                                  alignment: Alignment.centerLeft,
                                  child:  TextScroll(downError[index]['error'],style: const TextStyle(color: Colors.red)),
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
          )
      ),
    );
  }
  
  @override
  void dispose() {
    super.dispose();
    downErrorListen.cancel();
  }

  @override
  bool get wantKeepAlive => true;

  ///清理失败歌曲列表
  void dealAllSong() {
    setState(() {
      DownDelControllerModel.downErrorList.length=0;
      downError.length=0;
    });
    ThisProjectUtils.deleteAllErrorDownCache();
    EasyLoading.showToast("清理完毕");
  }
}
