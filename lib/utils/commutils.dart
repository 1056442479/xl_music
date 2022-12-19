import 'dart:convert';
import 'dart:ui';


import 'package:audioplayers/audioplayers.dart';
import 'package:dart_tags/dart_tags.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'hide MenuItem;
import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qq_music/const/const_model.dart';
import 'package:qq_music/const/global.dart';
import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/controller/audio_list_controller.dart';
import 'package:qq_music/controller/down_del/down_del_model.dart';
import 'package:qq_music/controller/page_controller.dart';
import 'package:qq_music/model/event/event_model.dart';
import 'package:qq_music/model/mv/mv_play_url.dart';
import 'package:qq_music/model/song/song_list_details.dart';
import 'package:qq_music/model/song/song_url_detail.dart';
import 'package:qq_music/model/system/sysetm_setting_model.dart';
import 'package:qq_music/model/system/system_song_save.dart';
import 'package:qq_music/page/my_music/download/download.dart';
import 'package:qq_music/page/setting/system_setting.dart';
import 'package:qq_music/service/mv/mv_service.dart';
import 'package:qq_music/service/song/song_service.dart';
import 'package:qq_music/utils/HttpUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

import '../model/down/down_model.dart';
import 'Global.dart';

class ScreenUtils {
  static double getScreenHeight() {
    return MediaQueryData.fromWindow(window).size.height;
  }

  static double getScreenWidth() {
    return MediaQueryData.fromWindow(window).size.width;
  }
}



class CommUtils {

  ///将网易云的歌曲毫秒数转为分秒
  static String formatMinSec(int millSeconds){
    var truncate = (millSeconds/1000).truncate();
    var min = (truncate/60).truncate();
    if(min==0){
      return "00:${truncate<10?"0$truncate":"$truncate"}";
    }
    var sec =truncate-(min*60);

    return "${min<10?"0$min":"$min"} : ${sec<10?"0$sec":"$sec"}";
  }
  ///将网易云的歌词 转为具体的毫秒数
  ///列子：02:1.080 | 02:01.080 | 02:1.08 | 2:1.080
  static int  parseMusicLrcToSec(String str){
    var haoMiao =int.parse(str.split(".")[1].trim()) ;

    var miao =int.parse( str.substring(str.indexOf(":")+1,str.indexOf(".")));
    var fen = int.parse(str.split(":")[0]);
    int total =haoMiao+(miao*1000)+(fen*60*1000);

    return total;
  }
  ///组装歌词信息 {time:"000","lrc":"歌词内容"}
  static  Future <List<Map>> parseLrcStr(String lrc) async{
    List<Map> list =[];
    var split = lrc.split("\n");
    if(split.isEmpty){
      return list;
    }
    for(var i=0;i<split.length;i++){
      ///获取时间
      if(split[i].contains("]")){
        var map ={

        };
        var start = split[i].indexOf('[')+1;
        var end = split[i].indexOf(']');
        var parseMusicLrcToSec = CommUtils.parseMusicLrcToSec(split[i].substring(start,end));
        map['time']=parseMusicLrcToSec;

        //获取歌词
        var lrc = split[i].split(']')[1];
        map['lrc']=lrc.trim();
        list.add(map);
      }
    }
    return list;
  }

 static  String formatDuration(Duration duration) {
    String hours = duration.inHours.toString().padLeft(2, '0');
    String minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }
  ///关闭应用
  static void closeApp() {
    SystemChannels.platform.invokeMethod("SystemNavigator.pop");
  }


  /// 随机颜色
  static Color randomRGB() {
    return Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255),
        Random().nextInt(255));
  }

  ///验证用户名是否合法
  static bool regUsername(String username) {
    RegExp regExp = RegExp(r'^([a-zA-Z]|[0-9])[a-zA-Z0-9_]{6,15}$');
    bool isAbc = regExp.hasMatch(username);
    return isAbc;
  }

  ///匹配字符中间的字符(不包含特殊字符)
  static String? regMiddleStr(String start,String end,String str) {

    // ignore: prefer_interpolation_to_compose_strings
    RegExp regExp = RegExp(r'(?<='+start+':).*?(?='+end+')');
    var match  = regExp.firstMatch(str);
    return match?.group(0);
  }




  ///验证密码是否合法
  static bool regPassword(String password) {
    RegExp regExp = RegExp(r'^([a-zA-Z]|\w){6,15}$');
    bool isAbc = regExp.hasMatch(password);
    return isAbc;
  }

  ///验证邮箱是否合法
  static bool regEmail(String email) {
    RegExp regExp = RegExp(r'^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$');
    bool isAbc = regExp.hasMatch(email);
    return isAbc;
  }

  ///对象属性去重
  static duplication(List<dynamic> list, String? property) {
    final ids = list.map((e) => e.bookInfoUrl).toSet();
    list.retainWhere((x) => ids.remove(x.bookInfoUrl));
    return list;
  }



  ///根据路径创建目录
  static File createFile(String path) {
    final file = File(path);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    return file;
  }

 ///保存数据到本地
 ///[key] 键
 ///[value] 值
 static Future<bool> setLocalStorage(String key, String value) async {
   SharedPreferences sp = await SharedPreferences.getInstance();
   return await sp.setString(key, value);
 }

 ///该值是否存在
 ///[key] 键
 static Future<bool> containsKey(String key) async {
   SharedPreferences sp = await SharedPreferences.getInstance();
   return sp.containsKey(key);
 }

 ///根据key移除
 ///[key] 键
 static Future<bool> removeLocalStorageByKey(String key) async {
   SharedPreferences sp = await SharedPreferences.getInstance();
   return sp.remove(key);
 }

 ///移除全部值
 static Future<bool> removeLocalStorageAll() async {
   SharedPreferences sp = await SharedPreferences.getInstance();
   return sp.clear();
 }

 ///获取所有key
 static Future<dynamic> getLocalStorageAll() async {
   SharedPreferences sp = await SharedPreferences.getInstance();
   return sp.getKeys();
 }

 ///根据key获取
 ///[key] 键
 static Future<String> getLocalStorageByKey(String key) async {
   SharedPreferences sp = await SharedPreferences.getInstance();
   return sp.getString(key).toString();
 }




  ///创建目录
  Future<bool> folderExists(String filepath) async {
    bool flag = true;

    var file = Directory(filepath);
    try {
      bool exists = await file.exists();
      if (!exists) {
        await file.create();
        if (kDebugMode) {
          print("目录创建成功---$filepath");
        }
      }
    } catch (e) {
      flag = false;
      if (kDebugMode) {
        print("目录创建失败---$filepath");
      }
    }
    return flag;
  }

  ///递归删除目录和目录下的索引文件
  static Future<bool> deleteRecursiveFile(String path) async {
    Directory dir = Directory(path);
    await dir.delete(recursive: true)
        // ignore: avoid_print
        .then((value) {
      if (kDebugMode) {
        print(value);
      }
      return true;
    }).catchError((err) {
      if (kDebugMode) {
        print(err);
      }
      return false;
    });
    return true;
  }
}

class CacheUtil {
  /// 获取缓存大小
  static Future<int> total() async {
    Directory tempDir = await getTemporaryDirectory();
    // ignore: unnecessary_null_comparison
    if (tempDir == null) return 0;
    int total = await reduce(tempDir);
    return total;
  }

  /// 清除缓存
  static Future<void> clear() async {
    Directory tempDir = await getTemporaryDirectory();
    // ignore: unnecessary_null_comparison
    if (tempDir == null) return;
    await _delete(tempDir);
  }

  /// 递归缓存目录，计算缓存大小
  static Future<int> reduce(final FileSystemEntity file) async {
    /// 如果是一个文件，则直接返回文件大小
    if (file is File) {
      int length = await file.length();
      return length;
    }

    /// 如果是目录，则遍历目录并累计大小
    if (file is Directory) {
      int total = 0;
      var existsSync = file.existsSync();
      if (existsSync) {
        final List<FileSystemEntity> children = file.listSync();

        if (children.isNotEmpty)
          // ignore: curly_braces_in_flow_control_structures
          for (final FileSystemEntity child in children) {
            total += await reduce(child);
          }
      }

      return total;
    }

    return 0;
  }

  /// 递归删除缓存目录和文件
  static Future<void> _delete(FileSystemEntity file) async {
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      for (final FileSystemEntity child in children) {
        await _delete(child);
      }
    } else {
//      await file.delete();
    }
  }
}

// ignore: camel_case_types
class deviceUtils {
  ///获取设备信息
  static get deviceInfo async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    Map<String, dynamic> deviceData = <String, dynamic>{};
    AndroidDeviceInfo? androidInfo;
    IosDeviceInfo? iosInfo;
    if (Platform.isIOS) {
      iosInfo = await deviceInfoPlugin.iosInfo;
    } else {
      androidInfo = await deviceInfoPlugin.androidInfo;
    }
    deviceData = _readDeviceInfo(androidInfo, iosInfo);
    return deviceData;
  }

  static _readDeviceInfo(
      AndroidDeviceInfo? androidInfo, IosDeviceInfo? iosInfo) {
    Map<String, dynamic> data = <String, dynamic>{
      //手机品牌加型号
      "brand": Platform.isIOS
          ? iosInfo?.name
          : "${androidInfo?.brand} ${androidInfo?.model}",
      //当前系统版本
      "systemVersion": Platform.isIOS
          ? iosInfo?.systemVersion
          : androidInfo?.version.release,
      //系统名称
      "Platform": Platform.isIOS ? iosInfo?.systemName : "Android",
      //是不是物理设备
      "isPhysicalDevice": Platform.isIOS
          ? iosInfo?.isPhysicalDevice
          : androidInfo?.isPhysicalDevice,
      //用户唯一识别码
      "uuid": Platform.isIOS
          ? iosInfo?.identifierForVendor
          : androidInfo?.id,
      //手机具体的固件型号/Ui版本
      "incremental": Platform.isIOS
          ? iosInfo?.systemVersion
          : androidInfo?.version.incremental,
    };
    return data;
  }
}



class ThisProjectUtils{

  ///获取MV的url
  ///[id] id: mv id
  Future<MvPlayUrlModel ?> getMvPlayUrl({required int id}) async{
    MvPlayUrlModel ? mvPlayUrlModel =  await MvService.getMvPlayUrl(id: id);
    return mvPlayUrlModel;
  }



  ///处理快捷键
  ///[init] 是否初始化调用
  static   globalMethod({required bool init,bool ? key}) async{
    if(init){
      var localStorageByKey = await CommUtils.getLocalStorageByKey("globalSet");
      if(localStorageByKey!="null"){
        settingModel =SystemSettingModel.fromJson( jsonDecode(localStorageByKey));
      }else{
        if (kDebugMode) {
          print("设置参数获取为NULL");
        }
      }
      getHistorySong();
      parseDownMusicInfo();
      delErrorDownDataToSys();
      startSystem();
    }


    //暂停播放的
    dealGlobalKeyPlayOrPause(key ?? settingModel.globalKey);

    //上下首歌的
    dealGlobalKeyDownSong(key ??settingModel.globalKey);
    dealGlobalKeyUpSong(key ??settingModel.globalKey);

    //音量的
    dealGlobalKeyVolumeUpSong(key ??settingModel.globalKey);
    dealGlobalKeyVolumeDownSong(key ??settingModel.globalKey);
  }

  ///开机自启动
static  startSystem() async{
    try{
      launchAtStartup.setup(
        appName: "xl_music",
        appPath: Platform.resolvedExecutable,
      );
      var autoStartUp = settingModel.autoStartUp;
      if(autoStartUp){
         launchAtStartup.enable();
      }else{
         launchAtStartup.disable();
      }
    }catch(e){
      Global.logger.e("开机自启设置出错");
    }

//    bool isEnabled = await launchAtStartup.isEnabled(); //查看是否启动成功
  }

 ///设置托盘菜单
static Future<Menu> setMenu() async{
    Menu menu = Menu(items: [
      MenuItem(label: '播放|暂停',onClick: (e){
        if(AudioListController.playIndex!=-1){
          var  musicPageController=  Get.put(MusicPageController());
          if(Global.audioPlayer.state==PlayerState.playing){
            musicPageController.playIng.value=false;
            Global.audioPlayer.pause();
          }else{
            musicPageController.playIng.value=true;
            Global.audioPlayer.resume();
          }
        }
      }),
      MenuItem(label: '上一首',onClick: (e){
        if(AudioListController.playIndex!=-1){
          Global.getInstance()!.fire(AudioPlayEvent(playUp: true));
        }
      }),
      MenuItem(label: '下一首',onClick: (e){
        if(AudioListController.playIndex!=-1){
          Global.getInstance()!.fire(AudioPlayEvent(playDown: true));
        }
      }),
      MenuItem.separator(),
      MenuItem(label: '设置',onClick: (e){
        Get.to(()=>const SystemSetting(),transition: Transition.rightToLeft);
        windowManager.show(); // 该方法来自window_manager插件
      }),
      MenuItem(label: '退出',onClick: (e){
        ///保存设置历时
        CommUtils.setLocalStorage("globalSet", jsonEncode(settingModel));
        ///保存听歌历史
        ThisProjectUtils.saveHistorySong();
        windowManager.destroy();
      }),
      //      MenuItem.submenu(
//        key: 'science',
//        label: '理科',
//        submenu: Menu(items: [
//          MenuItem(label: '物理'),
//          MenuItem(label: '化学'),
//          MenuItem(label: '生物'),
//        ]),
//      ),
//      MenuItem.separator(),
//      MenuItem.submenu(
//        key: 'arts',
//        label: '文科',
//        submenu: Menu(items: [
//          MenuItem(label: '政治'),
//          MenuItem(label: '历史'),
//          MenuItem(label: '地理'),
//        ]),
//      ),
    ]);
    await trayManager.setContextMenu(menu);
    return menu;
  }

  ///处理全局的播放暂停快捷键
 static dealGlobalKeyPlayOrPause(bool globalKey) async{
    var hotKey =HotKey(
      KeyCode.numpad1,
      modifiers: [KeyModifier.alt],
      // 设置热键范围（默认为 HotKeyScope.system）
      scope: globalKey? HotKeyScope.system:HotKeyScope.inapp, // 设置为应用范围的热键。
    );
    ConstModel.hotKey[0]['hot_key'] =hotKey;
    if (hotKeyManager.registeredHotKeyList.contains(hotKey)) {
      await hotKeyManager.unregister(hotKey);
      debugPrint('play的快捷键注销成功');
    }
    hotKeyManager.register(
      hotKey,
      keyDownHandler: (hotKey) {
        debugPrint('onKeyDown+${hotKey.toJson()}');
        try{
          if(AudioListController.playIndex!=-1){
            var  musicPageController=  Get.put(MusicPageController());
            if(Global.audioPlayer.state==PlayerState.playing){
              musicPageController.playIng.value=false;
              Global.audioPlayer.pause();
            }else{
              musicPageController.playIng.value=true;
              Global.audioPlayer.resume();
            }
          }
        }catch(e){
          Global.logger.e(e);
        }
      },
      // 只在 macOS 上工作。
      keyUpHandler: (hotKey){
        debugPrint('onKeyUp+${hotKey.toJson()}');
      } ,
    );
  }


  ///处理全局的上一首快捷键
 static dealGlobalKeyUpSong(bool globalKey) async{
    var hotKey = HotKey(
      KeyCode.arrowUp,
      modifiers: [KeyModifier.alt],
      // 设置热键范围（默认为 HotKeyScope.system）
      scope: globalKey? HotKeyScope.system:HotKeyScope.inapp, // 设置为应用范围的热键。
    );
    if (hotKeyManager.registeredHotKeyList.contains(hotKey)) {
      await hotKeyManager.unregister(hotKey);
      debugPrint('up的快捷键注销成功');
    }
    ConstModel.hotKey[1]['hot_key'] =hotKey;
    hotKeyManager.register(
      hotKey,
      keyDownHandler: (hotKey) {
        debugPrint('上一首+${hotKey.toJson()}');
        try{
          if(AudioListController.playIndex!=-1){
            Global.getInstance()!.fire(AudioPlayEvent(playUp: true));
          }
        }catch(e){
          Global.logger.e(e);
        }
      },
      // 只在 macOS 上工作。
      keyUpHandler: (hotKey){
        debugPrint('onKeyUp+${hotKey.toJson()}');
      } ,
    );
  }

  ///处理全局的下一首快捷键
  static dealGlobalKeyDownSong(bool globalKey) async{

    var hotKey = HotKey(
      KeyCode.arrowDown,
      modifiers: [KeyModifier.alt],
      // 设置热键范围（默认为 HotKeyScope.system）
      scope: globalKey? HotKeyScope.system:HotKeyScope.inapp, // 设置为应用范围的热键。
    );
    ConstModel.hotKey[2]['hot_key'] =hotKey;

    if (hotKeyManager.registeredHotKeyList.contains(hotKey)) {
      await hotKeyManager.unregister(hotKey);
      debugPrint('down的快捷键注销成功');
    }
    ConstModel.hotKey[2]['hot_key'] =hotKey;

    hotKeyManager.register(
      hotKey,
      keyDownHandler: (hotKey) {
        debugPrint('下一首+${hotKey.toJson()}');
        try{
          if(AudioListController.playIndex!=-1){
            Global.getInstance()!.fire(AudioPlayEvent(playDown: true));
          }
        }catch(e){
          Global.logger.e(e);
        }
      },
      // 只在 macOS 上工作。
      keyUpHandler: (hotKey){
        debugPrint('onKeyUp+${hotKey.toJson()}');
      } ,
    );
  }

  ///处理全局的音量增加快捷键
  static  dealGlobalKeyVolumeUpSong(bool globalKey) async{
    var hotKey =HotKey(
      KeyCode.numpad8,
      modifiers: [KeyModifier.alt],
      // 设置热键范围（默认为 HotKeyScope.system）
      scope:globalKey? HotKeyScope.system:HotKeyScope.inapp, // 设置为应用范围的热键。
    );
    ConstModel.hotKey[3]['hot_key'] =hotKey;

    if (hotKeyManager.registeredHotKeyList.contains(hotKey)) {
      await hotKeyManager.unregister(hotKey);
      debugPrint('down的快捷键注销成功');
    }
    hotKeyManager.register(
      hotKey,
      keyDownHandler: (hotKey) {
        debugPrint('音量加+${hotKey.toJson()}');
        try{
          if(AudioListController.playIndex!=-1){
            var d = CacheGlobalData.globalVolume+=5;
           Global.audioPlayer.setVolume(d>100?100/100:d/100);
          }
        }catch(e){
          Global.logger.e(e);
        }
      },
      // 只在 macOS 上工作。
      keyUpHandler: (hotKey){
        debugPrint('onKeyUp+${hotKey.toJson()}');
      } ,
    );
  }

  ///处理全局的音量减少快捷键
  static dealGlobalKeyVolumeDownSong(bool globalKey) async{
    var hotKey =HotKey(
      KeyCode.numpad2,
      modifiers: [KeyModifier.alt],
      // 设置热键范围（默认为 HotKeyScope.system）
      scope:globalKey? HotKeyScope.system:HotKeyScope.inapp, // 设置为应用范围的热键。
    );
    ConstModel.hotKey[4]['hot_key'] =hotKey;
    if (hotKeyManager.registeredHotKeyList.contains(hotKey)) {
      await hotKeyManager.unregister(hotKey);
      debugPrint('down的快捷键注销成功');
    }
    hotKeyManager.register(
      hotKey,
      keyDownHandler: (hotKey) {
        debugPrint('音量减+${hotKey.toJson()}');
        try{
          if(AudioListController.playIndex!=-1){
            var d = CacheGlobalData.globalVolume-=5;
            Global.audioPlayer.setVolume(d<0?0:d/100);
          }
        }catch(e){
          Global.logger.e(e);
        }
      },
      // 只在 macOS 上工作。
      keyUpHandler: (hotKey){
        debugPrint('onKeyUp+${hotKey.toJson()}');
      } ,
    );
  }



  ///保存听歌历史
  static  saveHistorySong() async{
    if(AudioListController.playIndex!=-1){

      SystemSongSaveModel saveModel =SystemSongSaveModel(playIndex:  AudioListController.playIndex,
          recommendPlayId: AudioListController. recommendPlayId, nowTimeMs: CacheGlobalData.nowPlayMs,playList: AudioListController.playList,
          url: AudioListController.playList[AudioListController.playIndex].rtUrl);
      CommUtils.setLocalStorage("songHistory", jsonEncode(saveModel));
      debugPrint("历史歌曲保存成功----名字---${AudioListController.playList[AudioListController.playIndex].name}");
    }
  }

  ///必须等设置方法缓存调用结束再调用
  ///获取听歌历时，并更具设置进行处理
  static getHistorySong() async{
      var data = await  CommUtils.getLocalStorageByKey("songHistory");
      if(data!='null'){
        ///获取的退出时保存的歌曲信息
        var systemSongSaveModel = SystemSongSaveModel.fromJson(jsonDecode(data));

        var playIndex = systemSongSaveModel.playIndex;
        if(playIndex!=-1 && systemSongSaveModel.playList!=null && systemSongSaveModel.playList!.length>playIndex){
          AudioListController.playList =systemSongSaveModel.playList!;
          AudioListController.playIndex =systemSongSaveModel.playIndex;
          AudioListController.recommendPlayId =systemSongSaveModel.recommendPlayId;
          CacheGlobalData.nowPlayMs =systemSongSaveModel.nowTimeMs;

          String ? playUrl;
          if(systemSongSaveModel.playList![playIndex].id==-1){
            playUrl=systemSongSaveModel.playList![playIndex].rtUrl;
          }else{
            //获取网络url
            playUrl = await getSongUrl( systemSongSaveModel.playList![playIndex].id);
          }

          if(playUrl!=null){
            Global.getInstance()!.fire(AudioPlayEvent(showController: true,playMs: CacheGlobalData.nowPlayMs,
                showAutoPlay: settingModel.autoPlayIng,playUrl: playUrl));
          }else{
            Global.logger.e("初始化歌曲url获取失败----id-${systemSongSaveModel.playList![playIndex].id},--名字：---${systemSongSaveModel.playList![playIndex].name}");
          }
        }
      }else{
        debugPrint("历史歌曲获取为NULL");
      }
  }



  ///批量音乐下载
  ///pro是否页面显示转圈
 static downMoreMusic({required Song song,required String url}) async{
    //获取下载方式(音乐命名格式(0--歌曲名，1--歌手-歌曲名，2--歌曲名-歌手))
    var musicDownName = settingModel.musicDownName;
    String names = "${song.name}.mp3";
    if(musicDownName==1){
      names = "${song.ar.first.name} - ${song.name}.mp3";
    }
    if(musicDownName==1){
      names = "${song.name} - ${song.ar.first.name}.mp3";
    }
    DownModel downModel =DownModel(songId: song.id,songName: song.name,
        absolutePath: "${settingModel.downUrl}\\${song.name}",
        songUserId: song.ar.first.id,songUserName: song.ar.first.name, albumId: song.al.id,albumName: song.al.name,cover: song.al.picUrl ?? CacheGlobalData.errorImg,duration: song.dt);

    ///开始下载
    String ? path = await DioUtils().downMusicFile(url, names,downModel);
    Global.logger.d(path);


//    var downMusicInfo = await ThisProjectUtils.getDownMusicInfo(path: path!,song: song);
//    if(downMusicInfo['code']==200){
//      ThisProjectUtils. delOverDown(downMusicInfo['data'],dealController);
//    }else{
//      ThisProjectUtils. delErrorMsg(downMusicInfo['song'], downMusicInfo['msg'],dealController);
//    }

  }



  ///获取音乐url
  ///[id] 要获取的音乐的的id
  static Future<String ?> getSongUrl(int id) async {

    var getList = await SongService.getSongListUrl(
        ids: [id], level: null);

    if (getList != null && getList.isNotEmpty) {
      return getList[0].url;
    } else {
      Global.logger.e(
          "初始歌曲url获取失败------歌曲id----$id");
      return null;
    }
  }

  ///批量获取音乐url
  static Future<List<SongUrlDetails> ?> getSongListUrl(List<int> ids) async {

    var getList = await SongService.getSongListUrl(
        ids: ids, level: null);

    if (getList != null && getList.isNotEmpty) {
      return getList;
    } else {
      Global.logger.e("歌曲批量获取失败");
      return null;
    }
  }

  ///获取下载的本地音乐信息,并解析
 static parseDownMusicInfo() async{
    Directory dir= Directory("${settingModel.downUrl}\\");
    // recursive是否递归列出子目录 followLinks是否允许link
    await dir.list(recursive: true).toList().then((value){
      for(var i=0;i<value.length;i++){
        if(containsMusicRule(value[i].absolute.toString())){
          debugPrint( value[i].absolute.path);
          ThisProjectUtils.getDownMusicInfo(path: value[i].absolute.path);
        }
      }
    });
  }
  ///检测音乐匹配规则
 static bool containsMusicRule(String str){
    for(var i=0;i<CacheGlobalData.musicRule.length;i++){
      if(str.contains(CacheGlobalData.musicRule[i])){
        return true;
      }
    }
    return false;
  }

 ///获取下载后的音乐的源数据，根据id3规则
  ///[test] 是否只做为测试使用
static  Future<Map<String,dynamic>>  getDownMusicInfo({required String path,bool ? test}) async{
  Map<String,dynamic> map ={
        "code":200,
        "msg":"ok",
        "data":null
    };
    try{
      final f =  File(path);
      var isCun=await f.exists(); //返回真假
      if(isCun==false){
        Global.logger.e("路径文件不存在！----$path");
        map['code']==500;
        map['msg']=="路径文件不存在";
        return map;
      }
      final tp =  TagProcessor();
      var tagsFromByteArray = await tp.getTagsFromByteArray(f.readAsBytes());
      for(var i=1;i<tagsFromByteArray.length;i++){
        var tags = tagsFromByteArray[i].tags;
        if(tags['info']!=null){
          var json = jsonDecode(tags['info']);
          var downModel = DownModel.fromJson(json);
          if(test==null || test==false){
            Global.getInstance()!.fire(ChangeDownOver(downModel: downModel));
            DownDelControllerModel.downOverList.add(downModel);
          }
          map['data']=downModel;
        }else{
          if(test==null || test==false){
            getQQMusicInfo(tags,path);
          }
          Global.logger.d("不是本软件下载的歌曲");
        }
        return map;
      }
    }catch(e){
      Global.logger.e(e);
    }
    return map;
  }

  ///处理本地qq音乐的信息
static  getQQMusicInfo(Map map,String path) async{
    DownModel downModel =DownModel(songId: -1,songName: "未知",
        absolutePath: path,size: "未知",
        songUserId:-1,songUserName: "佚名", albumId: -1,albumName:"未知",cover:CacheGlobalData.errorImg,duration:0);

    if(map['title']!=null && map['artist']!=null && map['album']!=null){
      downModel.songName=map['title'];
      downModel.songUserName=map['artist'];
      downModel.albumName=map['album'];
      var file = File(path);
      if(file.existsSync()){
        var length = await file.length();
        var size = filesize(length);
        downModel. size =size;
      }
      Global.getInstance()!.fire(ChangeDownOver(downModel: downModel));
      DownDelControllerModel.downOverList.add(downModel);
    }else{
      getOtherMusicInfo(map,path,downModel);
    }
}
  ///处理其他音乐的信息
  static  getOtherMusicInfo(Map map,String path,DownModel downModel) async{
    String json = map.toString();
    if(CommUtils.regMiddleStr("album",",",json)!=null && CommUtils.regMiddleStr("title",",",json)!=null && CommUtils.regMiddleStr("artist",",",json)!=null){
      downModel.songName=CommUtils.regMiddleStr("title",",",json)!;
      downModel.songUserName=CommUtils.regMiddleStr("artist",",",json)!;
      downModel.albumName=CommUtils.regMiddleStr("album",",",json)!;
      var file = File(path);
      if(file.existsSync()){
        var length = await file.length();
        var size = filesize(length);
        downModel. size =size;
      }
    }
    Global.getInstance()!.fire(ChangeDownOver(downModel: downModel));
    DownDelControllerModel.downOverList.add(downModel);
  }

  ///处理错误数据
  static delErrorMsg(Song song,String errorMsg) async{
    Map map={
      "id":song.id,
      "song":song,
      "error":errorMsg
    };
    DownDelControllerModel.downIngList.removeWhere((element) => element['id']==song.id);
    Global.getInstance()!.fire(ChangeDownIng(deleteId: song.id));


    DownDelControllerModel.downErrorList.add(map);
    Global.getInstance()!.fire(ChangeErrorOver(errors: map));

  }

  ///处理完成数据
 static delOverDown(DownModel model) async{

    DownDelControllerModel.downIngList.removeWhere((element) => element['id']==model.songId);
    Global.getInstance()!.fire(ChangeDownIng(deleteId: model.songId));

    DownDelControllerModel.downOverList.add(model);
    Global.getInstance()!.fire(ChangeDownOver(downModel: model));
 }

  ///处理下载失败文件的保存
  static delErrorDownData() async{
    if(DownDelControllerModel.downErrorList.isNotEmpty){
      File file= File("${settingModel.cacheUrl}\\downError.txt");
      file.writeAsString(jsonEncode(DownDelControllerModel.downErrorList),
        mode: FileMode.append,// 写入的模式 append(追加写入) read(只读) write(读写) writeOnly(只写)  writeOnlyAppend(只追加)
        flush: true,    // 如果flush设置为`true` 则写入的数据将在返回之前刷新到文件系统
        encoding:utf8,  // 设置编码
      );
    }
  }
  ///处理下载失败文件进行展示
  static delErrorDownDataToSys() async{
    File file= File("${settingModel.cacheUrl}\\downError.txt");
    var existsSync = file.existsSync();
    if(existsSync){
      var s = await file.readAsString();
      var list = jsonDecode(s);
      DownDelControllerModel.downErrorList =list;
    }
  }

  ///清空下载失败文件缓存
  static deleteAllErrorDownCache() async{
    File file= File("${settingModel.cacheUrl}\\downError.txt");
    var existsSync = file.existsSync();
    if(existsSync){
      file.deleteSync();
    }
  }
  ///处理下载事件
 static void dealMoreDown(List<Song> selectList) async{

    for(int i=0;i<selectList.length;i++){
      Map map={
        "id":selectList[i].id,
        "song":selectList[i],
        "progress":0.0
      };
      DownDelControllerModel.downIngList.add(map);

    }
    var songListUrl =await ThisProjectUtils.getSongListUrl(selectList.map((e) => e.id).toList());
    if(songListUrl ==null || songListUrl.isEmpty){
      DownDelControllerModel.downIngList.length=0;
      EasyLoading.showError("下载列表的url全部获取失败");
      return;
    }

    Get.to(()=>const DownloadMusicPage(),transition: Transition.rightToLeft);

    for(int i=0;i<songListUrl.length;i++){
      if(songListUrl[i].url==null){
        ThisProjectUtils.delErrorMsg( selectList[i],"获取下载链接地址出错");
      }else{
        if(DownDelControllerModel.downOverList.indexWhere((element) => element.songId==selectList[i].id)!=-1){
          delJumpDown(selectList[i].id);
          debugPrint("已经下载过了");
        }else{
          ThisProjectUtils.downMoreMusic(song: selectList[i],url: songListUrl[i].url);
        }
      }
    }

  }

  ///处理下载列表存在的数据数据
 static delJumpDown(int id) async{
    DownDelControllerModel.downIngList.removeWhere((element) => element['id']==id);
  }
}





