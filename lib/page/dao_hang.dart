import 'dart:convert';
import 'dart:io';
import 'package:desktop_context_menu/desktop_context_menu.dart';
import 'package:flutter/material.dart'hide MenuItem;
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/model/event/event_model.dart';
import 'package:qq_music/page/search/search_home.dart';
import 'package:qq_music/page/setting/system_setting.dart';
import 'package:qq_music/service/search/search_service.dart';
import 'package:qq_music/utils/Global.dart';
import 'package:qq_music/utils/MyIcons.dart';
import 'package:qq_music/utils/commutils.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';
import '../const/global.dart';

///[full] 是否进入全屏界面了
class DaoHang extends StatefulWidget {
  final bool ? full;

  const DaoHang({Key? key,this.full}) : super(key: key);

  @override
  State createState() => _DaoHangState();
}

class _DaoHangState extends State<DaoHang> with AutomaticKeepAliveClientMixin ,TrayListener,WindowListener {
  String keyword = "";
  ///窗口是否最大化了
  bool isMaximized =false;
  late  StateSetter amxState;
  //关闭窗口时，是否退出程序
  bool exitExe =false;
  FocusNode focusNode=FocusNode();
  
  
  @override
  void initState() {
    super.initState();

//    _init();
    trayManager.addListener(this);
    windowManager.addListener(this);
    setSystemIcon();

    focusNode.addListener(() {
        if(focusNode.hasFocus){
        if (keyword.trim().isNotEmpty) {
          showMenu();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Global.logger.d("导航栏构建了");
    return  Localizations(
      locale: const Locale('en', 'US'),
      delegates: const <LocalizationsDelegate<dynamic>>[
        DefaultWidgetsLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,

      ],
      child:  Material(
        color:const Color.fromRGBO(30, 30, 31, 1),
        child: GestureDetector(
          behavior:HitTestBehavior.translucent,
          onTapDown: (e){
            if(Get.isOverlaysOpen){
              Get.back();
            }
            windowManager.startDragging();
          },
          child: Container(
            padding: const EdgeInsets.only(right: 15,left: 15),

            height: 80,
            child:  Row(
              textDirection: TextDirection.ltr,
              children: <Widget>[

                widget.full==null?  InkWell(
//                    behavior: HitTestBehavior.opaque,
                  onTap: (){
                    Get.back();
                  },
                  child:  Container(
                    padding: const EdgeInsets.all(10),
                    child: const Icon(
                        Icons.chevron_left_outlined,
                        size: 23,
                        color: Colors.greenAccent,
                        textDirection:TextDirection.ltr
                    ),
                  ),
                ):
                InkWell(
//                    behavior: HitTestBehavior.opaque,
                  onTap: (){
                    Global.getInstance()!.fire(ChangeMusicFullIndex(0));
                  },
                  child:  Container(
                    padding: const EdgeInsets.all(10),
                    child: const Icon(
                        Icons.keyboard_arrow_down,
                        size: 23,
                        color: Colors.white,
                        textDirection:TextDirection.ltr
                    ),
                  ),
                ),
                //   搜索框
                Offstage(
                  offstage: widget.full==null?false:true,
                  child: Container(
                    width: 150,
                    height: 30,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Color.fromRGBO(48, 48, 48, 1)
                    ),
                    child: TextField(
                      focusNode: focusNode,
                      textInputAction: TextInputAction.search,
                      //设置键盘右下角为搜索
                      onEditingComplete: () {
                        //onEditingComplete属性用于点击键盘的动作按钮时的回调，没有参数。
                      searchMusic();
                      },

                      style: const TextStyle(color: Colors.white,fontSize: 14),
                      keyboardType: TextInputType.multiline,
                      controller: TextEditingController.fromValue(//实现双向绑定
                          TextEditingValue(
                              text: keyword,
                              selection: TextSelection.fromPosition(TextPosition(
                                  //设置光标位置
                                  affinity: TextAffinity.downstream,
                                  offset: keyword.length)))),
                      onChanged: (e) {
                        keyword = e;

                      },
//                textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.left,
                      //文本对齐方式
                      autocorrect: true,
                      //是否自动更正
                      autofocus: false,
                      //是否自动对焦
                      decoration: const InputDecoration(
                          hintText: "搜索音乐",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 14),
                          contentPadding:
                              EdgeInsets.only(bottom: 5), //这里是关键
                          border: InputBorder.none,
                        prefixIcon: Icon(Icons.search,size: 16,color: Colors.grey,)
                      ),
                    ),
                  ),
                ),

                Expanded(child: Container()),

                Offstage(
                  offstage: widget.full==null?false:true,
                  child: Row(
                    children: [
                      ///任务信息
                      InkWell(
                        onTap: login,
                        child: Row(
                          textDirection: TextDirection.ltr,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage("http://p1.music.126.net/1kMN9xCDyFUMYmGR5Dns4A==/109951163291322812.jpg"),
                                      fit: BoxFit.cover
                                  ) ,
                                  shape: BoxShape. circle
                              ),
                            ),
                            const  SizedBox(width: 5,),
                            const  Text("点击登录",textScaleFactor: 1,style: TextStyle(color: Colors.white70,fontSize: 14),textDirection: TextDirection.ltr,),
                          ],
                        ),
                      ),
                      const SizedBox(width: 15,),

                      ///设置
                      InkWell(
                        onTap: (){
                          Get.to(()=>const SystemSetting(),transition: Transition.rightToLeft);
                        },
                        child:  Container(
                          padding: const EdgeInsets.all(10),
                          child: const Icon(
                              Icons.settings_outlined,
                              size: 23,
                              color: Colors.grey,
                              textDirection:TextDirection.ltr
                          ),
                        ),
                      ),
                      const SizedBox(width: 8,),
                      Container(
                        height: 20,
                        color: Colors.grey,
                        width: 2,
                      ),
                    ],
                  ),
                ),
                //最小按钮
                InkWell(
                  onTap: minScreen,
                  child:  Container(
                    padding: const EdgeInsets.all(10),
                    child:  Icon(
                        XlIcons.xl_zuixiaohua,
                        size: 23,
                        color:  widget.full==null? Colors.grey:Colors.white,
                        textDirection:TextDirection.ltr
                    ),
                  ),
                ),
//            //全屏按钮
                StatefulBuilder(
                  builder: (BuildContext context, void Function(void Function()) setState) {
                    amxState =setState;
                    return InkWell(
                      onTap:(){
                        fullScreen(setState);
                      } ,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                            isMaximized? Icons.fullscreen_exit:Icons.fullscreen,
                            size: 23,
                            color: widget.full==null? Colors.grey:Colors.white,
                            textDirection:TextDirection.ltr
                        ),
                      ),
                    );
                  },
                ),
//            //关闭按钮
                InkWell(
                  onTap: closeWindow,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child:  Icon(
                        Icons.close,
                        size: 23,
                        color: widget.full==null? Colors.grey:Colors.white,
                        textDirection:TextDirection.ltr
                    ),
                  ),
                ),
//
//                const  SizedBox(width: 15,)
              ],
            ),
          ),
        ),
      ),
    );
  }


  //搜索音乐
  void searchMusic() {
    if(keyword.trim().isEmpty){
      EasyLoading.showToast("请输入搜索内容");
      return ;
    }
    focusNode.unfocus();
    debugPrint(keyword);
    CacheGlobalData.keyword =keyword.trim();
    var currentRoute = Get.currentRoute;
    if(currentRoute=="/SearchHome"){
      Global.getInstance()!.fire(StartSearch(keyword: keyword));
    }else{
      Get.to(()=>SearchHome(keyword: keyword));
    }
  }

  setSystemIcon() async{
    //设置图标
    await  trayManager.setIcon(Platform.isWindows ? iconPathWin : iconPathOther);
    //设置提示信息🐾
    await  trayManager.setToolTip('时光不老，你我不散');

    ThisProjectUtils.setMenu();
  }

  ///展开热搜和历时记录
  showMenu() async{
    await SearchService.getHotSearchResult();
    if (Get.isOverlaysClosed) {
      Get.dialog(
          Stack(
            children: [
              Positioned(
                left: 50,
                top: 5,
                child: SizedBox(
                  width: 250,
                  height: 380,
                  child: Material(
                    color: const Color.fromRGBO(41, 41, 43, 1),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 25,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey
                                    )
                                )
                            ),
                            child: const Text("热门搜索"),
                          ),
                          Expanded(child: ListView.builder(itemBuilder: (context, index) {
                            return InkWell(
                              onTap: (){
                                setState(() {
                                  keyword = CacheGlobalData.searchHotList[index].searchWord;
                                });
                                Get.back();
                                searchMusic();
                              },
                              child: Container(
                                height: 30,
                                width: 100,
                                margin: const EdgeInsets.only(top: 5),
                                child: Row(
                                  children: [
                                    Text(CacheGlobalData.searchHotList[index].searchWord),
                                    Expanded(child: Container()),
                                    Text(
                                      CacheGlobalData.searchHotList[index].score > 10000
                                          ? "${(CacheGlobalData.searchHotList[index].score / 10000).truncate()}万"
                                          : CacheGlobalData.searchHotList[index].score.toString(),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 13),
                                    ),
                                    const SizedBox(width: 15,)
                                  ],
                                ),
                              ),
                            );
                          },itemCount: CacheGlobalData.searchHotList.length,))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          barrierColor: Colors.transparent
      );

    } else {
      Get.back();
    }
  }

  ///关闭按钮
  closeWindow() async{
    if(settingModel.exitExe==false){
      Global.logger.d("关闭时，隐藏窗口");
      windowManager.hide();
    }else{
      ///TODO 应该检查是否还有下载任务没完成，提示后关闭

      Global.logger.d("关闭时，退出程序");
      windowManager.close();
    }
  }


  ///最大化和换源窗口
  void fullScreen(setState) async{
    var bool = await windowManager.isMaximized();
    if(bool){
//      isMaximized= false;
      windowManager.unmaximize();
    }else{
//      isMaximized= true;
      windowManager.maximize();
    }
  }

  ///最小化和换源窗口
  void minScreen() async{
    var minimized = await windowManager.isMinimized();
    if(!minimized){
      await windowManager.minimize();
    }
  }



  void login() async{
    Get.snackbar("提示", "欢迎登录，仅做展示学习", icon: const Icon(Icons.info_outline_rounded,color: Colors.red,),
      shouldIconPulse: true, //弹出时图标是否闪烁，默认false
      backgroundGradient : const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(31, 212, 174, 1),
            Color.fromRGBO(30, 208, 163, 1),
            Color.fromRGBO(30, 204, 149, 1),

          ]
      ) ,

      barBlur: 20,
      isDismissible: true,
      colorText:Colors.white,
      maxWidth: 500,
      dismissDirection:DismissDirection.vertical,
      duration: const Duration(seconds: 2),);
//    // Add in main method.
//    await localNotifier.setup(
//      appName: 'qq_music',
//      // The parameter shortcutPolicy only works on Windows
//      shortcutPolicy: ShortcutPolicy.requireCreate,
//    );
//
//    LocalNotification notification = LocalNotification(
//      title: "通知",
//      body: "仅做展示",
//    );
//    notification.onShow = () {
//      debugPrint('onShow ${notification.identifier}');
//    };
//    notification.onClose = (closeReason) {
//      // Only supported on windows, other platforms closeReason is always unknown.
//      switch (closeReason) {
//        case LocalNotificationCloseReason.userCanceled:
//        // do something
//          break;
//        case LocalNotificationCloseReason.timedOut:
//        // do something
//          break;
//        default:
//      }
//      debugPrint('onClose  - $closeReason');
//    };
//    notification.onClick = () {
//      debugPrint('onClick ${notification.identifier}');
//    };
//    notification?.onClickAction = (actionIndex) {
//      debugPrint('onClickAction ${notification?.identifier} - $actionIndex');
//    };
//
//    notification.show();
  }





  @override
  bool get wantKeepAlive => true;

  @override
  void onTrayIconMouseDown() {
    debugPrint("点击了左键");
    windowManager.show(); // 该方法来自window_manager插件
  }

  ///设置右键单击事件
  @override
  void onTrayIconRightMouseDown() async {
    debugPrint("点击了右键");
    await trayManager.popUpContextMenu();
  }

  ///设置菜单选项点击事件
  @override
  void onTrayMenuItemClick(MenuItem  menuItem) {
    debugPrint('你选择了${menuItem.onClick}');
  }

  ///移除托盘区域
  removeTray() async{
    await trayManager.destroy();
  }



  @override
  void dispose() {
    super.dispose();
    trayManager.removeListener(this);
  }

  ///当窗口最大化时触发
  @override
  void onWindowMaximize() {
    amxState(() {
      isMaximized =true;
    });
    debugPrint("当窗口最大化时触发");
  }
  ///当窗口退出最大化时触发
  @override
  void onWindowUnmaximize() {
    amxState(() {
      isMaximized =false;
    });
    debugPrint("当窗口退出最大化时触发");
  }

  ///当窗口重新调整大小后触发
  @override
  void onWindowResize() {
//    debugPrint("当窗口重新调整大小后触发");
  }
//  void _init() async {
////    // 添加此行以覆盖默认关闭处理程序
////    await windowManager.setPreventClose(true);
////    setState(() {});
//  }

  ///当窗口关闭触发
  @override
  void onWindowClose()  {
    ///保存设置历时
    CommUtils.setLocalStorage("globalSet", jsonEncode(settingModel));
    ///保存听歌历史
    ThisProjectUtils.saveHistorySong();
    ///保存下载失败的任务
    ThisProjectUtils.delErrorDownData();
    debugPrint("当窗口关闭触发，保存设置");
  }
  ///当窗口全屏触发
  @override
  void onWindowEnterFullScreen() {
    debugPrint("当窗口全屏触发");
  }

  ///当窗口离开全屏触发
  @override
  void onWindowLeaveFullScreen() {
    debugPrint("当窗口离开全屏触发");
  }


  void _showContextMenu() async {
    final selectedItem = await showContextMenu(
      menuItems: [
        ContextMenuItem(
          title: 'Copy',
          onTap: () {},
          shortcut: SingleActivator(
            LogicalKeyboardKey.keyC,
            meta: Platform.isMacOS,
            control: Platform.isWindows,
          ),
        ),
        ContextMenuItem(
          title: 'Paste',
          onTap: () {},
          shortcut: SingleActivator(
            LogicalKeyboardKey.keyV,
            meta: Platform.isMacOS,
            control: Platform.isWindows,
          ),
        ),
        ContextMenuItem(
          title: 'Paste as values',
          onTap: () {},
          shortcut: SingleActivator(
            LogicalKeyboardKey.keyV,
            meta: Platform.isMacOS,
            control: Platform.isWindows,
            shift: true,
          ),
        ),
        const ContextMenuSeparator(),
        ContextMenuItem(
          title: 'Item number two',
          onTap: () {},
        ),
        const ContextMenuItem(title: 'Disabled item'),
        const ContextMenuItem(
          title: 'Disabled item with shortcut',
          shortcut: SingleActivator(
            LogicalKeyboardKey.keyV,
            meta: true,
            shift: true,
          ),
        ),
        const ContextMenuSeparator(),
        ContextMenuItem(
          title: 'Zoom in',
          shortcut: const SingleActivator(
            LogicalKeyboardKey.add,
            alt: true,
          ),
          onTap: () {},
        ),
        ContextMenuItem(
          title: 'Zoom out',
          shortcut: const SingleActivator(
            LogicalKeyboardKey.minus,
            alt: true,
          ),
          onTap: () {},
        ),
        const ContextMenuSeparator(),
        ContextMenuItem(
          title: 'Control shortcut',
          shortcut: const SingleActivator(
            LogicalKeyboardKey.keyJ,
            control: true,
          ),
          onTap: () {},
        ),
      ],
    );

    if (selectedItem == null) {
      return null;
    }
  }
}



