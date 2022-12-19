import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:qq_music/model/event/event_model.dart';
import 'package:qq_music/page/audio_play.dart';
import 'package:qq_music/page/ce_bian.dart';
import 'package:qq_music/page/dao_hang.dart';
import 'package:qq_music/page/music_full/music_full_play.dart';
import 'package:qq_music/page/zai_xian_music/recommend/recomed.dart';
import 'package:qq_music/utils/Global.dart';
import 'package:qq_music/utils/commutils.dart';
import 'package:window_manager/window_manager.dart';
import 'package:windows_single_instance/windows_single_instance.dart';

void main(List<String> args) async {
  //后面的插件操作必须的
  WidgetsFlutterBinding.ensureInitialized();

  //单实例启动
  await WindowsSingleInstance.ensureSingleInstance(
      args,
      "xl_music",
      onSecondWindow: (args) async{
        if (await windowManager.isMinimized()) {
          windowManager.restore();
        }
        windowManager.focus();
      });
  // 对于热重载，`unregisterAll()` 需要被调用。
  await hotKeyManager.unregisterAll();


  // 弹窗管理。
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    size: Size(1100, 750),
    minimumSize: Size(1100, 750),
    fullScreen: false,
    alwaysOnTop: false,
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    //是否在状态栏隐藏
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();

    await windowManager.focus();
  });
  //VLC播放器初始化
  DartVLC.initialize();
  ///初始化数据
  ThisProjectUtils.globalMethod(init: true);

  runApp(
    const MyApp(),
  );
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int indexPage =0;

  @override
  void initState() {
    super.initState();

    Global.getInstance()!.on<ChangeMusicFullIndex>().listen((event) {
      if(event.index!=indexPage){
        setState(() {
          indexPage =event.index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return  Directionality(

      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
           const Directionality(
            textDirection: TextDirection.ltr,
            child:  MusicFullPage(),
          ),
          Offstage(
            offstage: indexPage==0?false:true,
            child: SizedBox(
              child: Row(
                textDirection: TextDirection.ltr,
                children: [
                  const CeBian(),
                  Expanded(child: Column(
                    children: [
                      const SizedBox(
                        height: 80,
                        width: double.infinity,
                        child: MaterialApp(
                          home: DaoHang(),
                          debugShowCheckedModeBanner: false,
                          title: "xl_music",
                          locale: Locale('zh_CH'),
                          localizationsDelegates: [
                            GlobalMaterialLocalizations.delegate,
                            GlobalWidgetsLocalizations.delegate,
                            GlobalCupertinoLocalizations.delegate,
                          ],
                          supportedLocales: [
                            //此处
                            Locale('zh', 'CH'),
                            Locale('en', 'US'),
                          ],
                        ),
                      ),
                      Expanded(child: GetMaterialApp(
                        home: const Recommend(),
                        title: "xl_music",
                        debugShowCheckedModeBanner: false,
//          translations: Transition.rightToLeft,
                        theme: ThemeData(
                          colorScheme: const ColorScheme.dark(
                            primary: Color.fromRGBO(30, 30, 31, 1),
                            brightness: Brightness.dark,
                          ),
                          //全局去掉水波纹
//        highlightColor: Colors.transparent,
//        splashFactory: NoSplash.splashFactory,
                          primaryColor: const Color.fromRGBO(30, 30, 31, 1),
//            colorScheme: const ColorScheme.light(
//              primary: Colors.white, //顶部栏栏颜色
//              brightness: Brightness.light,
//            ),
//                  brightness: Brightness.light,
                        ),
                        themeMode: ThemeMode.system,
                        builder: EasyLoading.init(),
                        //以下配置是将复制粘贴该为中文
                        locale: const Locale('zh_CH'),
                        localizationsDelegates: const [
                          GlobalMaterialLocalizations.delegate,
                          GlobalWidgetsLocalizations.delegate,
                          GlobalCupertinoLocalizations.delegate,
                        ],
                        supportedLocales: const [
                          //此处
                          Locale('zh', 'CH'),
                          Locale('en', 'US'),
                        ],
                      )
                      ),
                      const AudioPlayPage()
                    ],
                  )),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



