
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';



class MyLovePage extends StatefulWidget {
  const MyLovePage({Key? key}) : super(key: key);

  @override
  _MyLovePageState createState() => _MyLovePageState();
}

class _MyLovePageState extends State<MyLovePage> {
  List<Color>  colorizeColors = [
    Colors.white,
    Colors.white
  ];

  TextStyle  colorizeTextStyle =  const TextStyle(
    fontSize: 50.0,
    fontFamily: 'Horizon',
  );
  int second =0;
  String lrc = "[00:00.000] 作词 : 无\n[00:00.020] 作曲 : 无\n[00:00.40]霞光\n[00:01.10]\n[00:01.55]作曲 : 陈欣若\n[00:02.05]\n[00:02.45]作词 : 高博\n[00:02.86]\n[00:03.37]原编曲：陈欣若 闫志强\n[00:03.82]\n[00:04.27]改编：李大白\n[00:04.77]\n[00:05.23]原唱：曲锦楠\n[00:06.14]\n[00:06.75]翻唱：小时\n[00:16.67]后期：漫漫\n[00:17.12]摄影：笑笑\n[00:18.53]封面：函数\n[00:20.78]月光把天空照亮\n[00:25.65]\n[00:26.05]洒下一片光芒点缀海洋\n[00:31.36]\n[00:31.82]每当流星从天而降\n[00:37.09]\n[00:37.54]心中的梦想都随风飘扬\n[00:42.93]\n[00:43.38]展开透明翅膀越出天窗\n[00:48.36]找寻一个最美丽的希望\n[00:54.46]\n[00:54.92]每当天空泛起彩色霞光\n[01:00.24]\n[01:00.70]带着回忆和幻想一起飞翔\n[01:07.82]\n[01:18.24]月光把天空照亮\n[01:13.64]\n[01:23.57]洒下一片光芒点缀海洋\n[01:23.12]\n[01:29.24]每当流星从天而降\n[01:28.84]\n[01:34.97]心中的梦想随风飘扬\n[01:34.51]\n[01:40.73]展开透明翅膀越出天窗\n[01:40.32]\n[01:46.58]找寻一个最美丽的希望\n[01:46.18]\n[01:52.36]每当天空泛起彩色霞光\n[01:51.91]\n[01:58.30]带着回忆和幻想一起飞翔\n[01:58.04]\n[02:05.27]啦啦 啦啦啦啦啦啦啦\n[02:04.87]\n[02:11.10]啦啦啦啦啦 啦啦啦啦啦\n[02:10.80]\n[02:16.80]啦啦啦啦啦啦啦啦啦\n[02:16.34]\n[02:22.52]啦啦啦啦啦啦啦啦啦啦 啦啦\n[02:22.12]\n";



  @override
  Widget build(BuildContext context) {

    return  SlideInDown(
      child:const Material(
        color:  Color.fromRGBO(30, 30, 31, 1),
        child: Center(child: Text("请先登录",style: TextStyle(color: Colors.white,fontSize: 18),)),

      ),
    );
  }




}


