import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NavigatorUtils {
  ///普通打开页面
  ///[context] 上下文对象
  ///[targetPage] 目标页面
  ///[isReplace] 是否替换当前页面，也就是当前页面是否关闭
  ///[dismissCallBack] 返回函数
  static void pushPage(
      {required BuildContext context,
      required Widget targetPage,
      bool isReplace = false,
      Function(dynamic value)? dismissCallBack}) {
    //默认为安卓路由
    PageRoute pageRoute = MaterialPageRoute(builder: (context) {
      return targetPage;
    });

    //判断是否是安卓,先判断是否是web，不然web端报错 Platform._operatingSystem
    if(!kIsWeb){
      if (Platform.isIOS) {
        pageRoute = CupertinoPageRoute(builder: (context) {
          return targetPage;
        });
      }
    }


    //如果要销毁当前页面
    if (isReplace) {
      Navigator.of(context)
          // ignore: unnecessary_null_comparison
          .pushAndRemoveUntil(pageRoute, (route) => route == null)
          .then((value) {
        if (dismissCallBack != null) {
          dismissCallBack(value);
        }
      });
    } else {
      if (kDebugMode) {
        print("见来没");
      }
      Navigator.of(context).push(pageRoute).then((value) {
        if (dismissCallBack != null) {
          dismissCallBack(value);
        }
      });
    }
  }

  ///自定义开页面
  ///[context] 上下文对象
  ///[targetPage] 目标页面
  ///[isReplace] 是否替换当前页面，也就是当前页面是否关闭
  ///[dismissCallBack] 返回函数
  ///[chooseAnimation] 那种动画效果--0-3 选择
  static void pushPageByFade(
      {required BuildContext context,
      required Widget targetPage,
      bool isReplace = false,
      int chooseAnimation = 0,
      Function(dynamic value)? dismissCallBack}) {
    PageRoute pageRoute = PageRouteBuilder(pageBuilder: (BuildContext context,
            Animation animation, Animation<double> animationSecond) {
      return targetPage;
    },

        //动画
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
      if (chooseAnimation < 0 || chooseAnimation > 3) {
        return AnimationRoute.SlideTransitionAnimation(
            animation, context, secondaryAnimation, child);
      } else if (chooseAnimation == 1) {
        return AnimationRoute.GradualChangeRouteAnimation(
            animation, context, secondaryAnimation, child);
      } else if (chooseAnimation == 2) {
        return AnimationRoute.ZoomRoute(
            animation, context, secondaryAnimation, child);
      } else if (chooseAnimation == 3) {
        return AnimationRoute.RotateAndZoomRouteAnimation(
            animation, context, secondaryAnimation, child);
      }
      return AnimationRoute.SlideTransitionAnimation(
          animation, context, secondaryAnimation, child);
    });

    if (isReplace) {
      Navigator.of(context)
          // ignore: unnecessary_null_comparison
          .pushAndRemoveUntil(pageRoute, (route) => route == null)
          .then((value) {
        if (dismissCallBack != null) {
          dismissCallBack(value);
        }
      });
    } else {
      Navigator.of(context).push(pageRoute).then((value) {
        if (dismissCallBack != null) {
          dismissCallBack(value);
        }
      });
    }
  }
}

class AnimationRoute {
  AnimationRoute(
      {required Animation<double> animation,
      required Widget child,
      required BuildContext context,
      required Animation<double> secondaryAnimation});

  //左右滑动效果
  // ignore: non_constant_identifier_names
  static Widget SlideTransitionAnimation(animation, context, secondaryAnimation, child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),//-1,0:左到右 ，1,0右到左， 0，-1：上到下，0,1：下到上
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  //渐隐渐变效果
  // ignore: non_constant_identifier_names
  static Widget GradualChangeRouteAnimation(
      animation, context, secondaryAnimation, child) {
    return FadeTransition(
      opacity: Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
      child: child,
    );
  }

  //缩放效果
  // ignore: non_constant_identifier_names
  static Widget ZoomRoute(animation, context, secondaryAnimation, child) {
    return ScaleTransition(
      scale: Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
      child: child,
    );
  }

  //旋转加缩放效果
  // ignore: non_constant_identifier_names
  static Widget RotateAndZoomRouteAnimation(
      animation, context, secondaryAnimation, child) {
    return RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
        child: ScaleTransition(
          scale: Tween(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
          child: child,
        ));
  }
}
