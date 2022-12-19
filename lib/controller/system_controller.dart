

import 'package:get/get.dart';
import 'package:qq_music/const/global.dart';


class SystemController extends GetxController{
  ///开机自启动
  var starts =settingModel.autoStartUp.obs;
  ///关闭主面板
  var exitExe =settingModel.exitExe.obs;
  ///点击音乐，是否替换播放整个列表，还是只添加播放单曲到列表
  var playingList =settingModel.playingList.obs;
  ///程序启动时自动播放退出时的音乐
  var autoPlayIng =settingModel.autoPlayIng.obs;
  ///程序启动时记住音乐上次的播放进度
  var keepAudioProgress =settingModel.keepAudioProgress.obs;
  ///文件下载地址
  var defaultDownUrl =settingModel.downUrl.obs;

  ///文件缓存目录
  var defaultCacheUrl =settingModel.cacheUrl.obs;

  ///文件缓存目录最大值设定（512M-10G）
  var cacheSize =settingModel.cacheSize.obs;
  ///音乐命名格式(0--歌曲名，1--歌手-歌曲名，2--歌曲名-歌手)
  var musicDownName =settingModel.musicDownName.obs;

  ///播放音质等级, 分为 standard => 标准-0,higher => 较高-1, exhigh=>极高-2, lossless=>无损-3, hires=>Hi-Res-4
  var playMusicLevel =settingModel.playMusicLevel.obs;

  ///下载音质等级, 分为 standard => 标准-0,higher => 较高-1, exhigh=>极高-2, lossless=>无损-3, hires=>Hi-Res-4
  var downMusicLevel =settingModel.downMusicLevel.obs;

  ///禁用GPU加速(只做显示)
  var gpu =false.obs;

  ///是否启用全局快捷键
  var globalKey =settingModel.globalKey.obs;

}