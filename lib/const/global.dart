import 'dart:async';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:qq_music/model/system/sysetm_setting_model.dart';

///歌单分享链接（后面加歌单的id）
String cloudShareMusicSong="https://music.163.com/#/playlist?id=";

///专辑分享连接（后面加专辑id）
String cloudShareMusicAlbum="https://music.163.com/#/album?id=";

///电台分享连接（后面加电台id）
String cloudShareMusicDj="https://music.163.com/#/djradio?id=";

const String iconPathWin = 'images/app_icon.ico';
const String iconPathOther = 'images/app_icon.png';
///默认下载地址
const String defaultDownUrl ="C:\\Music\\download";
const String defaultCacheUrl ="C:\\Music\\cache";

SystemSettingModel settingModel =SystemSettingModel(playingList: true, exitExe: false,
    playingType: 0,autoStartUp: false,autoPlayIng: false,keepAudioProgress: true,downUrl: defaultDownUrl, cacheUrl: defaultCacheUrl,
    cacheSize: 1024, musicDownName: 1, playMusicLevel: 0, downMusicLevel: 2, globalKey: false,);

///播放器的流
final StreamController<dynamic> streamController = StreamController<
    dynamic>.broadcast();

///视频播放器
final player = Player(id: 69420);