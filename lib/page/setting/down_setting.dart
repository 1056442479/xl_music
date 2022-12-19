

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:qq_music/const/global.dart';
import 'package:qq_music/controller/system_controller.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class DownSetting extends StatelessWidget {
  const DownSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemController systemController = Get.put(SystemController());
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "下载设置", style: TextStyle(color: Colors.white, fontSize: 18),),
          const SizedBox(
            height: 5,
          ),
          const Divider(),

          const  SizedBox(height: 5,),
          ///音质选择
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text("下载音质选择:", style: TextStyle(color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),),
              ),
              const SizedBox(height: 2,),
              // 下载音质选择
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
                        groupValue: systemController.downMusicLevel.value,
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
            ],
          ),
          const  SizedBox(height: 20,),

          ///下载目录
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Padding(
                padding: const EdgeInsets.only(left: 8),
                child: RichText(
                  text: const TextSpan(
                    text:"下载目录: ",
                    style: TextStyle(color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(text: " 默认将音乐文件下载在该文件夹中",style: TextStyle(color: Colors.blueGrey,fontSize: 12))
                    ]
                  ),
                ),
              ),
              const SizedBox(height: 2,),
              Obx(() {
                return  Container(
                  margin: const EdgeInsets.only(left: 30,top: 10,),
                  child: Row(
                    children: [
                        Text(systemController.defaultDownUrl.value,style: const TextStyle(color: Colors.white,fontSize: 14),),
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Colors.white)
                          ),
                          child: TextButton(onPressed: (){

                            updateDownDirectory(systemController);
                          },
                          child:const Text("更改目录",style:  TextStyle(color: Colors.white,fontSize: 13),)),

                        )
                    ],
                  ),
                );
              })
            ],
          ),
          const  SizedBox(height: 20,),

          ///缓存目录
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: RichText(
                  text: const TextSpan(
                      text:"缓存目录: ",
                      style: TextStyle(color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(text: " 系统缓存文件",style: TextStyle(color: Colors.blueGrey,fontSize: 12))
                      ]
                  ),
                ),
              ),
              const SizedBox(height: 2,),
              Obx(() {
                return  Container(
                  margin: const EdgeInsets.only(left: 30,top: 10,),
                  child: Row(
                    children: [
                      Text(systemController.defaultCacheUrl.value,style: const TextStyle(color: Colors.white,fontSize: 14),),
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Colors.white)
                        ),
                        child: TextButton(onPressed: (){

                          updateCacheDirectory(systemController);
                        },
                            child:const Text("更改目录",style:  TextStyle(color: Colors.white,fontSize: 13),)),

                      )
                    ],
                  ),
                );
              })
            ],
          ),
          const  SizedBox(height: 20,),

          ///缓存最大占用
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text("缓存最大占用:", style: TextStyle(color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),),
              ),
              const SizedBox(height: 2,),
              Obx(() {
                return  Row(
                  children: [
                    const SizedBox(width: 20,),
                    SfSliderTheme(
                      data: SfSliderThemeData(
                        activeTrackHeight: 5,
                        inactiveTrackHeight: 5,
                        thumbRadius: 5,
                        activeDividerRadius: 15,
                        overlayRadius: 15,
                        //放上去的圆点大小
                        inactiveTrackColor: Colors.grey,
                        thumbColor: const Color.fromRGBO(
                            31, 210, 169, 1),
                        activeTrackColor: const Color.fromRGBO(
                            31, 210, 169, 1),
                      ),
                      child: SfSlider(value: systemController.cacheSize.value.toDouble(), max: 1024*10,min: 512,
                          onChanged: (e){
                            systemController.cacheSize.value= e.floor();
                      },onChangeEnd: (e){
                        settingModel.cacheSize =e.floor();
                        },
                      ),
                    ),
                    Text("${(systemController.cacheSize.value/1024).toStringAsFixed(2)}GB"),
                    Container(
                      margin: const EdgeInsets.only(left: 15),

                      child: TextButton(onPressed: (){

                      },
                          child:const Text("清除缓存",style:  TextStyle(color: Colors.white,fontSize: 13),)),
                    )
                  ],
                );
              })
            ],
          ),
          const  SizedBox(height: 20,),

          ///音乐命名格式
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text("音乐|MV命名格式:", style: TextStyle(color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),),
              ),
              const SizedBox(height: 2,),
              Obx(() {
                return  Column(
                  children: [
                    //歌曲名
                    RadioListTile(
                      value: 0,
                      groupValue: systemController.musicDownName.value,
                      onChanged: (value) {
                        systemController.musicDownName.value=value ?? 0;
                        settingModel.musicDownName =0;
                      },
                      title: const Text("歌曲名", style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),),
                      selected: systemController.musicDownName.value == 0,
                    ),
                    //歌手-歌曲名
                    RadioListTile(
                      value: 1,
                      groupValue: systemController.musicDownName.value,
                      onChanged: (value) {
                        systemController.musicDownName.value=value ?? 1;
                        settingModel.musicDownName =1;
                      },
                      title: const Text("歌手-歌曲名", style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),),
                      selected: systemController.musicDownName.value == 1,
                    ),
                    //歌曲名
                    RadioListTile(
                      value: 2,
                      groupValue: systemController.musicDownName.value,
                      onChanged: (value) {
                        systemController.musicDownName.value=value ?? 2;
                        settingModel.musicDownName =2;
                      },
                      title: const Text("歌曲名-歌手", style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),),
                      selected: systemController.musicDownName.value == 2,
                    ),
                  ],
                );
              })
            ],
          ),
          const  SizedBox(height: 20,),

        ],
      ),
    );
  }

  ///更改下载目录
  void updateDownDirectory(SystemController systemController) async {
    final String? path = await getDirectoryPath();
    if (path == null) {
      EasyLoading.showToast("取消选择");
    }else{
      systemController.defaultDownUrl.value =path;
      settingModel.downUrl =path;
    }
  }

  void updateCacheDirectory(SystemController systemController) async{
    final String? path = await getDirectoryPath();
    if (path == null) {
      EasyLoading.showToast("取消选择");
    }else{
      systemController.defaultCacheUrl.value =path;
      settingModel.cacheUrl =path;
    }
  }
}
