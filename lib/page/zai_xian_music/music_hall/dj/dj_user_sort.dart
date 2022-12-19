
import 'package:animate_do/animate_do.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qq_music/model/dj/dj_user_top.dart';
import 'package:qq_music/page/dj/dj_user_details.dart';
import 'package:qq_music/service/dj/dj_service.dart';
import 'package:styled_widget/styled_widget.dart';

///人气主播排行榜
class DjUserSort extends StatefulWidget {
  const DjUserSort({Key? key}) : super(key: key);

  @override
  _DjUserSortState createState() => _DjUserSortState();
}

class _DjUserSortState extends State<DjUserSort> {
  ///最热主播榜
  List<DjUserTopModel> topUserList =[];
  @override
  void initState() {
    super.initState();
    getDjUserPopularTop();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromRGBO(30, 30, 31, 1),
      child: Container(
        margin: const EdgeInsets.only(left: 20,right: 20),
        width: double.infinity,
        height: double.infinity,
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                child:    Text("人气主播",style: TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold),),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  /// 纵轴间距
                  mainAxisSpacing: 20.0,
                  /// 横轴间距
                  crossAxisSpacing: 10.0,
                  /// 横轴元素个数
                  crossAxisCount: 5,
                  /// 宽高比
                  childAspectRatio: 1,
                ),
                delegate:SliverChildBuilderDelegate((context, index) {
                  return FadeInLeft(
                    child: InkWell(
                        onTap: (){
                          Get.to(()=>DjUserDetailsPage(id: topUserList[index].id,));
                        },
                        child:  Styled.widget(child: Container(
                          decoration: const BoxDecoration(
//                          color: Color.fromRGBO(36, 36, 37, 1),
                              borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          child: Column(
                            children: [
                              Expanded(child: ExtendedImage.network(
                                topUserList[index].avatarUrl,
                                fit: BoxFit.cover,
                                cache: true,
                                shape: BoxShape.circle,
                              )),
                              const SizedBox(height: 10,),
                              Text(topUserList[index].nickName,style: const TextStyle(color: Colors.white,fontSize: 15),maxLines: 1,overflow: TextOverflow.ellipsis,),
                            ],
                          ),
                        )
                        )
                    ),
                  );
                },childCount:topUserList.length)),
          ],
        ),
      ),
    );
  }

  ///说明 : 调用此接口,可获取最热主播榜
  getDjUserPopularTop() async{
    var topData = await DjService.getDjUserPopularTop(limit: 100);
    if(topData!=null && topData.isNotEmpty){
      setState(() {
        topUserList =topData;
      });
    }
  }

}
