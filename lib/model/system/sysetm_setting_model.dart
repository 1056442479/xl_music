
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

SystemSettingModel systemSettingModelFromJson(String str) => SystemSettingModel.fromJson(json.decode(str));

String systemSettingModelToJson(SystemSettingModel data) => json.encode(data.toJson());

///[playingList] 点击音乐，是否播放整个列表，还是只播放单曲
///
///[playingType] 歌曲播放类别，0--列表循环，1---顺序播放，2---随机播放，3---单曲循环
///
///[exitExe] 点击x是否退出程序,true:退出，false：隐藏到托盘
///
///[musicDownName] 音乐命名格式(0--歌曲名，1--歌手-歌曲名，2--歌曲名-歌手)
///
/// [autoStartUp] 是否开机自启动
///
/// [autoPlayIng] 程序启动时自动播放退出时的音乐
///
/// [keepAudioProgress] 程序启动时记住音乐上次的播放进度
///
/// [downUrl] 文件下载目录
///
/// [cacheUrl] 文件缓存目录
///
/// [cacheSize] 文件缓存目录最大值设定（512M-10G）
class SystemSettingModel {
  SystemSettingModel({
    required this.playingList,
    required this.exitExe,
    required this.playingType,
    required this.autoStartUp,
    required this.autoPlayIng,
    required this.keepAudioProgress,
    required this.downUrl,
    required this.cacheUrl,
    required this.cacheSize,
    required this.musicDownName,
    required this.playMusicLevel,
    required this.downMusicLevel,
    required this.globalKey,
  });
  ///点击音乐，是否替换播放整个列表，还是只添加播放单曲到列表
  bool playingList;
  ///是否开机自启动
  bool autoStartUp;
  ///歌曲播放类别，0--列表循环，1---顺序播放，2---随机播放，3---单曲循环
  int playingType;
  ///程序启动时自动播放退出时的音乐
  bool autoPlayIng;
  ///点击x是否退出程序,true:退出，false：隐藏到托盘
  bool exitExe;
  ///程序启动时记住音乐上次的播放进度
  bool keepAudioProgress;
  ///是否启用全局快捷键
  bool globalKey;
  ///文件下载目录
  String  downUrl;
  ///文件缓存目录
  String  cacheUrl;
  ///文件缓存目录最大值设定（512M-10G）
  int  cacheSize;
  ///音乐命名格式(0--歌曲名，1--歌手-歌曲名，2--歌曲名-歌手)
  int  musicDownName;

  /// 播放音质等级, 分为 standard => 标准-0,higher => 较高-1, exhigh=>极高-2, lossless=>无损-3, hires=>Hi-Res-4
  int  playMusicLevel;

  /// 下载音质等级, 分为 standard => 标准-0,higher => 较高-1, exhigh=>极高-2, lossless=>无损-3, hires=>Hi-Res-4
  int  downMusicLevel;

  factory SystemSettingModel.fromJson(Map<String, dynamic> json) => SystemSettingModel(
    playingList: json["playingList"],
    exitExe: json["exitExe"],
    globalKey: json["globalKey"],
    autoStartUp: json["autoStartUp"],
    playingType: json["playingType"],
    autoPlayIng: json["autoPlayIng"],
    keepAudioProgress: json["keepAudioProgress"],
    downUrl: json["downUrl"],
    cacheUrl: json["cacheUrl"],
    cacheSize: json["cacheSize"],
    musicDownName: json["musicDownName"],
    playMusicLevel: json["playMusicLevel"],
    downMusicLevel: json["downMusicLevel"],
  );

  Map<String, dynamic> toJson() => {
    "playingList": playingList,
    "keepAudioProgress": keepAudioProgress,
    "autoPlayIng": autoPlayIng,
    "autoStartUp": autoStartUp,
    "cacheSize": cacheSize,
    "exitExe": exitExe,
    "playingType": playingType,
    "globalKey": globalKey,
    "downUrl": downUrl,
    "cacheUrl": cacheUrl,
    "musicDownName": musicDownName,
    "playMusicLevel": playMusicLevel,
    "downMusicLevel": downMusicLevel,
  };
}
