
import 'dart:convert';
import 'dart:io';

import 'package:dart_tags/dart_tags.dart';
import 'package:dio/dio.dart';
import 'package:file_selector/file_selector.dart';
import 'package:filesize/filesize.dart';
import 'dart:math';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qq_music/const/global.dart';
import 'package:qq_music/controller/down_del/down_del_model.dart';
import 'package:qq_music/model/down/down_model.dart';
import 'package:qq_music/model/result.dart';
import 'package:qq_music/utils/Global.dart';
import 'package:qq_music/utils/commutils.dart';




class DioUtils {

//  static String baseUrl = "http://192.168.1.3:9095";

  static String baseUrl = "http://139.155.78.142:3000";
  static int sendTimeout = 5000;
  static int receiveTimeout = 5000;
  static int connectTimeout = 5000;

  // default options
  // ignore: non_constant_identifier_names
  static  String TOKEN = '';

  /// *********************************** 实例变量 ***********************************
  late Dio dio; // Dio 的实例对象
  late String dioManageID; // 网络管理类实例的随机id,不必关心

  final BaseOptions options = BaseOptions(
    /// 请求的Content-Type，默认值是"application/json; charset=utf-8".
    /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
    /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]就会自动编码请求体.
//        contentType: Headers.formUrlEncodedContentType, // 适用于post form表单提交
    responseType: ResponseType.plain,
    validateStatus: (status) {
// 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
      return true;
    },
    baseUrl: baseUrl,
    headers: {
//          "Content-Type": "application/json;charset=UTF-8",
//      "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8",
      'token': DioUtils.TOKEN
    },
    contentType: "application/x-www-form-urlencoded;charset=UTF-8",
    connectTimeout: connectTimeout,
    receiveTimeout: receiveTimeout,
    sendTimeout: sendTimeout,
  ); // Dio 基础配置

  /// [DioManager]持有的 - 静态的final实例对象, 并进行初始化
  static final DioUtils _dioManager = DioUtils._instance();

  DioUtils._instance() {
    // 创建Dio的实例对象
    dio = Dio(options);


    // 添加拦截器, 可以在其中进行一些公共的处理
    dio.interceptors.add(InterceptorsWrapper(
//        onRequest:(RequestOptions resOptions,RequestInterceptorHandler requestInterceptorHandler) {
//           print("请求前");
//           initToken(dio);
//          return requestInterceptorHandler.next(resOptions);
//        }
    ));
    // 验证一下是否是当前
    dioManageID = "看看ID是啥${Random().nextInt(1000)}";
  }

  /// 工厂化的主构造函数 - 返回私有的实例对象
  /// 返回的就是唯一的实例 _dioManager
  factory DioUtils() {
    return _dioManager;
  }

//  static initToken(Dio dio) async{
//    if(TOKEN==""){
//      var userInfo = await CommUtils.getLocalStorageByKey("userInfo");
//      if(userInfo!="null"){
//        Map<String, dynamic> user = jsonDecode(userInfo.toString());
//        var userModel = UserModel.fromJson(user);
//        TOKEN =userModel.tokenValue!;
//        dio.options.headers['token'] = TOKEN;
//      }
//    }else{
//      debugPrint("TOKEN不是空");
//    }
//  }


  /// *********************************** DioMananger 私有方法 ***********************************



  /// 消息返回前 - 拦截处理
  /// 目前提供一个Futrue的异步函数, 用于拦截器中处理异步操作,
  Future<Response> _beforResponse(Response response) async {
//    debugPrint('[Response----原始数据----> :' + response.toString());

    // 如果是登录api, 异步转同步执行一下token本地固化,
//    if (response.request.path == _EbankHomeURL.login) {
//      String token = response.data['token'] ?? '';
//      bool saveScuess = await SharePreferencesUtils.token(SharePreferencesUtilsWorkType.save, value: token);
//      saveScuess ? debugPrint('token 保存成功') : debugPrint('token 保存失败');
//    }
    return Future.value(response);
  }

  /*
  * error统一处理
  */
  Result formatError(DioError e) {
    debugPrint('-Error =====>:${e.error}');

    Result result = Result(500, "未知错误", null, -1);
    if (e.type == DioErrorType.connectTimeout) {
      debugPrint("连接超时");
      result.msg = '连接超时';
    } else if (e.type == DioErrorType.sendTimeout) {
      debugPrint("请求超时");
      result.msg = '请求超时';
    } else if (e.type == DioErrorType.receiveTimeout) {
      debugPrint("响应超时");
      result.msg = '响应超时';
    } else if (e.type == DioErrorType.response) {
      debugPrint("出现异常");
      result.msg = '出现异常';
    } else if (e.type == DioErrorType.cancel) {
      debugPrint("请求取消");
      result.msg = '请求取消';
    } else {
      if(e.error.toString().contains("Network is unreachable")){
        result.msg ="当前网络不可用";
      }else{
        result.msg="未知错误";
      }
      debugPrint("未知错误");
      EasyLoading.showToast(result.msg);
    }
    return result;
  }

  /// get 请求
  Future<dynamic> get(String url, Map<String, dynamic>? params) async {

    debugPrint("[START----发起get请求--->:${dio.options.baseUrl}$url----参数信息：--$params");
//    dio.options.contentType ="application/x-www-form-urlencoded;charset=UTF-8";
    Response res = await dio.get(baseUrl + url, queryParameters: params);
    return res.data.toString();
  }

  /// post 请求
  Future<Result> post(String url, Map<String, dynamic>? params,bool  json) async {
//    await initToken(dio);
    debugPrint("[START----发起post请求---->:${dio.options.baseUrl}$url-----------参数信息：--$params");

    Result result = Result(200, "OK", null, -1);

    try {
      dio.options.connectTimeout = 15 * 1000;
      dio.options.receiveTimeout = 15 * 1000;
      dio.options.sendTimeout = 15 * 1000;
      dio.options.contentType ="application/x-www-form-urlencoded;charset=UTF-8";
      Response res ;
      if(json){
        dio.options.contentType ="application/json;charset=UTF-8";
        res=  await dio.post(baseUrl  + url, data: params);
      }else{
        res=  await dio.post(baseUrl  + url, queryParameters: params);
      }
      Map<String, dynamic> userMap = jsonDecode(res.data.toString());
      if (userMap['status'] == 404) {
        return Result(500, "路径不存在", null, -1);
      }
      if (userMap['code'] != null) {
        if(userMap['code']!=200){
          EasyLoading.showToast(userMap['msg']);
          debugPrint(url);
        }
        return Result.fromJson(userMap);
      }
    } on DioError catch (e) {
      result = formatError(e);
    }
    return result;
  }

  /// 单文件上传 请求
  /// [url]请求地址
  /// [local] 选择打的本地图片的地址
  /// [suffix] 文件名后缀(png|jpg等)
  Future<Result> upFile(String url, String local, String suffix) async {
    Result result = Result(200, "OK", null, -1);
    try {
      dio.options.contentType = "multipart/form-data";
      dio.options.connectTimeout = 15 * 1000;
      dio.options.receiveTimeout = 15 * 1000;
      dio.options.sendTimeout = 15 * 1000;

      Map<String, dynamic> map = {};
      String  filename = DateTime.now().millisecondsSinceEpoch.toString();

      map["file"] = MultipartFile.fromFileSync(local, filename: "$filename.$suffix");

      ///通过FormData
      FormData formData = FormData.fromMap(map);

      ///发送post
      Response response = await dio.post(
        "$baseUrl/$url", data: formData,

        ///这里是发送请求回调函数
        ///[progress] 当前的进度
        ///[total] 总进度
        onSendProgress: (int progress, int total) {
          if (kDebugMode) {
            print("当前进度是 $progress 总进度是 $total");
          }
        },
      );

      Map<String, dynamic> userMap = jsonDecode(response.data.toString());
      if (userMap['code'] != null) {
        return Result.fromJson(userMap);
      }
    } on DioError catch (e) {
      result = formatError(e);
    }
    return result;
  }

  /// 单文件下载 请求
  /// [url]请求地址
  /// [filename] mp3|mp4
  /// [pro] 是否展示下载进度
  Future<String ?> downFile(String url, String filename,bool pro) async {
    ///去除非法字符
    filename.replaceAll("?", "");
    filename.replaceAll("|", "");
    filename.replaceAll("\\", "");
    filename.replaceAll("/", "");
    filename.replaceAll(":", "");
    filename.replaceAll("*", "");
    filename.replaceAll("<", "");
    filename.replaceAll(">", "");
    filename.replaceAll('"', "");
//    String ? savePath;
    ///当前进度进度百分比  当前进度/总进度 从0-1
    double currentProgress =0.0;

//    final String? path = await getSavePath(suggestedName: filename);
//    if (path == null) {
//      // Operation was canceled by the user.
//      return null;
//    }

    String path ="${settingModel.downUrl}\\$filename";

    if (kDebugMode) {
      print("路劲是-----$path");
    }
      ///创建DIO
      Dio dio =  Dio();
      dio.options.connectTimeout = 120 * 1000;
      dio.options.receiveTimeout = 120 * 1000;
      dio.options.sendTimeout = 120 * 1000;
      ///参数一 文件的网络储存URL
      ///参数二 下载的本地目录文件
      ///参数三 下载监听
      Response response = await dio.download(url, path, onReceiveProgress: (received, total) {
        if (total != -1) {
          ///当前下载的百分比例
          if(pro){
            EasyLoading.showProgress(received / total,status: "下载中 ${(received / total * 100).toStringAsFixed(0)}%");
          }
          if (kDebugMode) {
            print("${(received / total * 100).toStringAsFixed(0)}%");
          }
          // CircularProgressIndicator(value: currentProgress,) 进度 0-1
          currentProgress = received / total;
        }
      });

      EasyLoading.dismiss();
      return path;
  }



  /// 单文件下载 请求
  /// [url]请求地址
  /// [filename] mp3|mp4
  Future<String ?> downMusicFile(String url, String filename,DownModel downModel) async {
    ///去除非法字符
    filename.replaceAll("?", "");
    filename.replaceAll('|', "");
    filename.replaceAll("\\", "");
    filename.replaceAll("/", "");
    filename.replaceAll(":", "");
    filename.replaceAll("*", "");
    filename.replaceAll("<", "");
    filename.replaceAll(">", "");
    filename.replaceAll('"', "");


    ///当前进度进度百分比  当前进度/总进度 从0-1
    double currentProgress =0.0;


    String path ="${settingModel.downUrl}\\$filename";
    downModel.absolutePath=path;
    if (kDebugMode) {
      print("路劲是-----$path");
    }
    ///创建DIO
    Dio dio =  Dio();
    dio.options.connectTimeout = 120 * 1000;
    dio.options.receiveTimeout = 120 * 1000;
    dio.options.sendTimeout = 120 * 1000;
    ///参数一 文件的网络储存URL
    ///参数二 下载的本地目录文件
    ///参数三 下载监听
    Response response = await dio.download(url, path, onReceiveProgress: (received, total) {
      var where = DownDelControllerModel.downIngList.indexWhere((element) => element['id']==downModel.songId);
      if (total != -1) {
        ///当前下载的百分比例
        currentProgress = received / total;//0-1
        if(where!=-1){
          DownDelControllerModel.downIngList[where]['progress']=currentProgress;
//          dealController.downIngList[where]['progress']=currentProgress;

        }else{
          debugPrint("没找到---$where");
        }
//        if (kDebugMode) {
//          print("${(received / total * 100).toStringAsFixed(0)}%");
//        }
      }
    });
//    dealController.downIngList[where]['progress']=100;

    final f =  File(path);
    var length = await f.length();
    var size = filesize(length);
    downModel.size =size;
    debugPrint("文件大小是---------$size");

    ThisProjectUtils.delOverDown(downModel);

    ///重新编码，输入自己的数据规则然后保存
    try{
      var tag = Tag();
      tag.type="id3";
      tag.version='2.4.0';
      tag.tags={
        "info":jsonEncode(downModel)
      };
      final tp =  TagProcessor();
      var putTagsToByteArray = await tp.putTagsToByteArray(f.readAsBytes(),[tag]);
      final Uint8List fileData = Uint8List.fromList(putTagsToByteArray);
      final XFile textFile = XFile.fromData(fileData, name: filename);
      textFile.saveTo(path);
    }catch(e){
      Global.logger.e("id3赋值失败----");
    }
    return path;
  }

//
//  /// 单文件下载 请求
//  /// [url]请求地址
//  /// [filename] rk.apk
//  /// [suffix] 文件名后缀(png|jpg等)
//  void downFile(String url, String filename, String suffix) async {
//    ///当前进度进度百分比  当前进度/总进度 从0-1
//    double currentProgress =0.0;
//    /// 申请写文件权限
//    bool isPercuss = await checkPermissionStorage();
//
//    if(isPercuss) {
//      ///手机储存目录
//      String savePath = await Global.findLocalPath();
//      ///创建DIO
//      Dio dio =  Dio();
//      dio.options.connectTimeout = 20 * 1000;
//      dio.options.receiveTimeout = 20 * 1000;
//      dio.options.sendTimeout = 20 * 1000;
//      ///参数一 文件的网络储存URL
//      ///参数二 下载的本地目录文件
//      ///参数三 下载监听
//      Response response = await dio.download(
//          url, "$savePath$filename", onReceiveProgress: (received, total) {
//        if (total != -1) {
//          ///当前下载的百分比例
//          if (kDebugMode) {
//            print("${(received / total * 100).toStringAsFixed(0)}%");
//          }
//          // CircularProgressIndicator(value: currentProgress,) 进度 0-1
//          currentProgress = received / total;
//        }
//      });
//    }else{
//      EasyLoading.showError("请先开启您的存储权限");
//    }
//  }
}
