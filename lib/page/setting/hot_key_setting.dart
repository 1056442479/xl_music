import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:qq_music/const/const_model.dart';
import 'package:qq_music/const/global.dart';
import 'package:qq_music/controller/system_controller.dart';
import 'package:qq_music/utils/Global.dart';
import 'package:qq_music/utils/commutils.dart';


class HotKeySetting extends StatelessWidget {
  const HotKeySetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemController systemController = Get.put(SystemController());
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "热键设置", style: TextStyle(color: Colors.white, fontSize: 18),),
          const SizedBox(
            height: 5,
          ),
          const Divider(),

          const SizedBox(height: 5,),

          ///音质选择
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text("快捷键:", style: TextStyle(color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),),
              ),
              const SizedBox(height: 2,),

              SizedBox(
                height: 280,
                child: ListView.builder(itemBuilder: (context, index) {
                  return Container(
                    height: 50,
                    margin: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Text(ConstModel.hotKey[index]['name'],
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),),
                        SizedBox(height: 30, width: index == 0 ? 60 : 80,),

                        Container(
                          width: 130,
                          padding: const EdgeInsets.only(
                              left: 5, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)
                          ),
                          child: Text(ConstModel.hotKey[index]['inapp'],
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),),
                        )
                      ],
                    ),
                  );
                }, itemCount: ConstModel.hotKey.length,),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text("全局设置:", style: TextStyle(color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),),
              ),
              const SizedBox(height: 2,),
              Obx(() {
                return SizedBox(
                  child: CheckboxListTile(
                    value: systemController.globalKey.value,
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (value) {
                      dealHotKey(value,systemController);

                    },
                    title: const Text("启动全局快捷键", style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),),
                    selected: systemController.globalKey.value == true,
                  ),
                );
              }),
            ],
          ),
          const SizedBox(height: 20,),

          const SizedBox(height: 20,),

        ],
      ),
    );
  }


  void dealHotKey(bool? value,SystemController systemController) {
    try{
      systemController.globalKey.value = value ?? false;
      settingModel.globalKey = value ?? false;
      ThisProjectUtils.globalMethod(init: false,key: value ?? false);
      EasyLoading.showToast("设置成功");
    }catch(e){
      Global.logger.e("热键全局失败---------$e");
      EasyLoading.showToast("设置失败");
    }

  }
}
