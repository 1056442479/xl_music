
import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:qq_music/page/setting/changgui.dart';
import 'package:qq_music/page/setting/down_setting.dart';
import 'package:qq_music/page/setting/hot_key_setting.dart';
import 'package:qq_music/page/setting/play_setting.dart';

class SystemSetting extends StatefulWidget {
  const SystemSetting({Key? key}) : super(key: key);

  @override
  _SystemSettingState createState() => _SystemSettingState();
}

class _SystemSettingState extends State<SystemSetting> with AutomaticKeepAliveClientMixin,TickerProviderStateMixin{

  late TabController tabController ;
  ScrollController scrollController =ScrollController();
  List<BadgeTab> tabs =[
    BadgeTab(text: "常规设置"),
    BadgeTab(text: "播放设置"),
    BadgeTab(text: "下载设置"),
    BadgeTab(text: "热键设置"),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);

    scrollController.addListener(() {
      scrollController.offset;
      if(scrollController.offset>0 && scrollController.offset<330){
        if(tabController.index!=0){
          setState(() {
            tabController.index =0;
          });
        }
      }
      if(scrollController.offset>330 && scrollController.offset<780){
        if(tabController.index!=1){
          setState(() {
            tabController.index =1;
          });
        }
      }
      if(scrollController.offset>780 && scrollController.offset<1100){
        if(tabController.index!=2){
          setState(() {
            tabController.index =2;
          });
        }
      }
      if(scrollController.offset>1280){
        if(tabController.index!=3){
          setState(() {
            tabController.index =3;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(30, 31, 30, 1),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 100,
            color: const Color.fromRGBO(36, 36,37,  1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children:  [
              Container(
                padding:const EdgeInsets.only(left: 30,right: 30),
                  margin: const EdgeInsets.only(top:20 ),
                  child: const Text(
                "设置",
                style: TextStyle(color: Colors.white, fontSize: 22,fontWeight: FontWeight.bold),
              ),),
                Expanded(child:
                    Container(
                      padding:const EdgeInsets.only(left: 20,right: 30),
                  alignment: Alignment.centerLeft,
                  child: BrnTabBar(
                    onTap: (state,index){
                      if(index==0){
                        scrollController.jumpTo(0);
                      }
                      if(index==1){
                        scrollController.jumpTo(340);
                      }
                      if(index==2){
                        scrollController.jumpTo(800);
                      }
                      if(index==3){
                        scrollController.jumpTo(1380);
                      }
                    },
                    backgroundcolor: Colors.transparent,
                    unselectedLabelColor: Colors.grey[100],
                    tabWidth:80,
                    unselectedLabelStyle: const TextStyle(fontSize: 12),
                    indicatorColor: Colors.greenAccent,
                    indicatorWeight:3,
                    controller: tabController,
                    labelColor:Colors.greenAccent,
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
                    tabs: tabs,
                  ),
                ),
                )
            ],
            ),
          ),
          const SizedBox(height: 20,),
          Expanded(child:  Container(
            padding:const EdgeInsets.only(left: 30,right: 30),
            child: ListView(
              controller: scrollController,
              children: const [
                ChangGuiSetting(),
                PlaySetting(),
                DownSetting(),
                HotKeySetting()
              ],
            ),
          ))
         ,
        ],
      )
    );
  }

  @override
  bool get wantKeepAlive => true;
}
