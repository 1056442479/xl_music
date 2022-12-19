import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:event_bus/event_bus.dart';
import 'package:qq_music/model/app/sys_app.dart';

class Global{
  static EventBus ? eventBus;

  static EventBus? getInstance() {
    eventBus ??= EventBus();
    return eventBus;
  }

  static Logger logger = Logger();


  static FocusNode ? focusNode ;
  static final localNotifier = LocalNotifier.instance;

  static double top =0; //系统栏高度
  static double screenW =0; //屏幕宽度
  static double screenH =0; //屏幕高度

  static SysAppPo ? sysAppPo;

   static final List<Color> themeList = [
    Colors.lightBlue,
    Colors.green,
    Colors.black,
    Colors.red,
    Colors.purpleAccent,
    Colors.pinkAccent,
    Colors.lightGreen,
    Colors.brown,
     Colors.deepOrangeAccent,
     Colors.teal,
  ];

  static AudioPlayer audioPlayer = AudioPlayer(playerId: "1");

  ///获取接口的app信息
  static Future<dynamic>  getVersion() async{
//    Result result =  await CookService.getAppInfo();
//    if(result.code==200){
//      SysAppPo sysAppPo =   SysAppPo.fromJson(jsonDecode(jsonEncode(result.data)));
//      return sysAppPo;
//    }
    return "null";
  }





// 获取存储路径
 static Future<String> findLocalPath() async {
    // 因为Apple没有外置存储，所以第一步我们需要先对所在平台进行判断
    // 如果是android，使用getExternalStorageDirectory
    // 如果是iOS，使用getApplicationSupportDirectory
    final directory =Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationSupportDirectory();

    if(directory==null){
      return "null";
    }
    return directory.path;
  }
}
