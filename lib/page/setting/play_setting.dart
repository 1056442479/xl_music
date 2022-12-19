

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qq_music/const/global.dart';
import 'package:qq_music/controller/system_controller.dart';

class PlaySetting extends StatelessWidget {
  const PlaySetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemController systemController = Get.put(SystemController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "播放设置", style: TextStyle(color: Colors.white, fontSize: 18),),
        const SizedBox(
          height: 5,
        ),
        const Divider(),

        ///音质选择
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text("播放音质选择:", style: TextStyle(color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),),
            ),
            const SizedBox(height: 2,),
            // 播放音质选择
            Obx(() {
              return Row(
                children: [
                  const SizedBox(width: 8,),
                  //标准
                  SizedBox(
                    width:100,
                    child: RadioListTile(
                      contentPadding: const EdgeInsets.only(left: 8),
                      dense:true,
                      value: 0,
                      groupValue: systemController.playMusicLevel.value,
                      onChanged: (value) {
                        systemController.playMusicLevel.value=value ?? 0;
                        settingModel.playMusicLevel =0;
                      },
                      title: const Text("标准", style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),),
                      selected: systemController.playMusicLevel.value == 0,
                    ),
                  ),
                  // 较高
                  SizedBox(
                    width:100,
                    child: RadioListTile(
                      contentPadding: const EdgeInsets.only(left: 8),
                      dense:true,
                      value: 1,
                      groupValue: systemController.playMusicLevel.value,
                      onChanged: (value) {
                        systemController.playMusicLevel.value=value ?? 1;
                        settingModel.playMusicLevel =1;
                      },
                      title: const Text("较高", style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),),
                      selected: systemController.playMusicLevel.value == 1,
                    ),
                  ),
                  // 极高
                  SizedBox(
                    width:100,
                    child: RadioListTile(
                      contentPadding: const EdgeInsets.only(left: 8),
                      dense:true,
                      value: 2,
                      groupValue: systemController.playMusicLevel.value,
                      onChanged: (value) {
                        systemController.playMusicLevel.value=value ?? 2;
                        settingModel.playMusicLevel =2;
                      },
                      title: const Text("极高", style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),),
                      selected: systemController.playMusicLevel.value == 2,
                    ),
                  ),
                  // 无损
                  SizedBox(
                    width:100,
                    child: RadioListTile(
                      contentPadding: const EdgeInsets.only(left: 8),
                      dense:true,
                      value: 3,
                      groupValue: systemController.playMusicLevel.value,
                      onChanged: (value) {
                        systemController.playMusicLevel.value=value ?? 3;
                        settingModel.playMusicLevel =3;
                      },
                      title: const Text("无损", style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),),
                      selected: systemController.playMusicLevel.value == 3,
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
          ],
        ),
        const  SizedBox(height: 20,),
        ///播放列表
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text("播放列表:", style: TextStyle(color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),),
            ),
            const SizedBox(height: 2,),
            // 组合选择项1
            Obx(() {
              return RadioListTile(
                value: true,
                groupValue: systemController.playingList.value,
                onChanged: (value) {
                  systemController.playingList.value=value ?? true;
                  settingModel.playingList =true;
                },
                title: const Text("双击播放单曲时，用当前单曲所在列表替换播放列表", style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),),
                selected: systemController.playingList.value == true,
              );
            }),

            // 组合选择项2
            Obx(() {
              return RadioListTile(
                value: false,
                groupValue: systemController.playingList.value,
                onChanged: (value) {
                  systemController.playingList.value=value ?? false;
                  settingModel.playingList =false;
                },
                title: const Text("双击播放单曲时，仅把当前单曲添加进播放列表", style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),),
                selected: systemController.playingList.value == false,
              );
            }),
          ],
        ),
        const  SizedBox(height: 20,),

        ///自动播放
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text("自动播放:", style: TextStyle(color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),),
            ),
            const SizedBox(height: 2,),
            Obx(() {
              return   CheckboxListTile(
                  value: systemController.autoPlayIng.value,
                  onChanged: (e) {
                    systemController.autoPlayIng.value = e ?? false;
                    settingModel.autoPlayIng = e ?? false;
                  },title:  const Text("程序启动时自动播放",
                    style: TextStyle(color: Colors.grey, fontSize: 14),),controlAffinity:ListTileControlAffinity.leading);
            })
          ],
        ),
        const  SizedBox(height: 20,),

        ///程序启动时记住音乐上次的播放进度
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text("播放进度:", style: TextStyle(color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),),
            ),
            const SizedBox(height: 2,),
            Obx(() {
              return   CheckboxListTile(value: systemController.keepAudioProgress.value,
                  onChanged: (e) {
                    systemController.keepAudioProgress.value= e ?? true;
                    settingModel.keepAudioProgress =e ?? true;
                  },title:  const Text("程序启动时记住音乐上次的播放进度",
                    style: TextStyle(color: Colors.grey, fontSize: 14),),controlAffinity:ListTileControlAffinity.leading);
            })
          ],
        ),
        const  SizedBox(height: 20,),

      ],
    );
  }
  click() async{
    Directory dir= Directory("C:\\Music\\download");
    await dir.create(recursive: true);
  }
}
