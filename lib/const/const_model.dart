import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:qq_music/const/global.dart';





class ConstModel{

  static List<Map> hotKey =[
    {
      "id":1,
      "name":"播放/暂停",
      "inapp":"Alt + Nnm 1",
      "now_hot_key":Null,
      "hot_key":HotKey(
        KeyCode.numpad1,
        modifiers: [KeyModifier.alt],
        // 设置热键范围（默认为 HotKeyScope.system）
        scope: settingModel.globalKey? HotKeyScope.system:HotKeyScope.inapp, // 设置为应用范围的热键。
      )
    },  {
      "id":2,
      "name":"上一首",
      "inapp":"Alt + Up",
      "now_hot_key":Null,
      "hot_key":HotKey(
        KeyCode.arrowUp,
        modifiers: [KeyModifier.alt],
        // 设置热键范围（默认为 HotKeyScope.system）
        scope: settingModel.globalKey? HotKeyScope.system:HotKeyScope.inapp, // 设置为应用范围的热键。
      )
    },  {
      "id":3,
      "name":"下一首",
      "inapp":"Alt + Down",
      "now_hot_key":Null,
      "hot_key":HotKey(
        KeyCode.arrowDown,
        modifiers: [KeyModifier.alt],
        // 设置热键范围（默认为 HotKeyScope.system）
        scope: settingModel.globalKey? HotKeyScope.system:HotKeyScope.inapp, // 设置为应用范围的热键。
      )
    },  {
      "id":4,
      "name":"音量加",
      "inapp":"Alt + Nnm 8",
      "now_hot_key":Null,
      "hot_key":HotKey(
        KeyCode.numpad8,
        modifiers: [KeyModifier.alt],
        // 设置热键范围（默认为 HotKeyScope.system）
        scope: settingModel.globalKey? HotKeyScope.system:HotKeyScope.inapp, // 设置为应用范围的热键。
      )
    },  {
      "id":5,
      "name":"音量减",
      "inapp":"Alt + Nnm 2",
      "now_hot_key":Null,
      "hot_key":HotKey(
        KeyCode.numpad2,
        modifiers: [KeyModifier.alt],
        // 设置热键范围（默认为 HotKeyScope.system）
        scope: settingModel.globalKey? HotKeyScope.system:HotKeyScope.inapp, // 设置为应用范围的热键。
      )
    }
  ];

}