
import 'package:qq_music/model/down/down_model.dart';

class DownDelControllerModel{

  ///正在下载的列表{“id：2”，"song":song,"progress ":"进度"}
  static List<Map> downIngList=[];
  ///下载失败的列表{“id：2”，"song":song,"error":"错误描述"}
  static List<Map> downErrorList=[];
  ///下载完成的列表
  static List<DownModel> downOverList=[];

  static int index =0;
}