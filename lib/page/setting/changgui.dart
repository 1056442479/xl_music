import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qq_music/const/global.dart';
import 'package:qq_music/controller/system_controller.dart';

class ChangGuiSetting extends StatelessWidget {
  const ChangGuiSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemController systemController = Get.put(SystemController());
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "常规设置", style: TextStyle(color: Colors.white, fontSize: 18),),
          const SizedBox(
            height: 5,
          ),
          const Divider(),

          ///启动
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text("启动:", style: TextStyle(color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),),
              ),
              const SizedBox(height: 2,),
              Obx(() {
                return   CheckboxListTile(value: systemController.starts.value,
                    onChanged: (e) {
                      systemController.starts.value = e ?? false;
                      settingModel.autoStartUp = e ?? false;
                    },title:  const Text("开机自动运行",
                      style: TextStyle(color: Colors.grey, fontSize: 14),),controlAffinity:ListTileControlAffinity.leading);
              })
            ],
          ),

          const  SizedBox(height: 20,),

          ///GPU加速
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text("GPU加速:", style: TextStyle(color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),),
              ),
              const SizedBox(height: 2,),
              Obx(() {
                return   CheckboxListTile(value: systemController.gpu.value,
                    onChanged: (e) {
                      systemController.gpu.value= e ?? false;
                    },title:  const Text("禁用GPU加速",
                      style: TextStyle(color: Colors.grey, fontSize: 14),),controlAffinity:ListTileControlAffinity.leading);
              })
            ],
          ),
          const  SizedBox(height: 20,),

          ///关闭主面板
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text("关闭主面板:", style: TextStyle(color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),),
              ),
              const SizedBox(height: 2,),
              // 组合选择项1
              Obx(() {
                return RadioListTile(

                  value: false,
                  groupValue: systemController.exitExe.value,
                  onChanged: (value) {
                    systemController.exitExe.value=value ?? false;
                    settingModel.exitExe =false;
                  },
                  title: const Text("最小化到托盘，不退出程序", style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),),
                  selected: systemController.exitExe.value == false,
                );
              }),

              // 组合选择项2
              Obx(() {
                return RadioListTile(
                  value: true,
                  groupValue: systemController.exitExe.value,
                  onChanged: (value) {
                    systemController.exitExe.value=value ?? true;
                    settingModel.exitExe =true;
                  },
                  title: const Text("退出程序", style: TextStyle(color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),),
                  selected: systemController.exitExe.value == true,
                );
              }),
            ],
          ),
          const  SizedBox(height: 20,),


        ],
      ),
    );
  }
}
