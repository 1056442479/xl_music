
import 'package:animate_do/animate_do.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:qq_music/model/dj/dj_details.dart';
import 'package:qq_music/page/dj/dj_details_page.dart';
import 'package:qq_music/service/dj/dj_service.dart';
import 'package:styled_widget/styled_widget.dart';

///电台分类
///[id] 分类的id
class DjTypeListDetails extends StatefulWidget {
  final String titleName ;
  final int  id ;
    const DjTypeListDetails({super.key,required this.id,required this.titleName});

  @override
  State createState() => _DjUserSortState();
}

class _DjUserSortState extends State<DjTypeListDetails> {

  ///电台分类数据
  List<DjDetailsModel> typeList =[];


  @override
  void initState() {
    super.initState();
    getDjTypeRecommend();
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
             SliverToBoxAdapter(
              child: SizedBox(
                child:    Text(widget.titleName,style:const TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold),),
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
                          Get.to(()=>DjDetailsPage(id: typeList[index].id,
                          ),transition: Transition.rightToLeft);
                        },
                        child:  Styled.widget(child: Container(
                          decoration: const BoxDecoration(
//                          color: Color.fromRGBO(36, 36, 37, 1),
                              borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          child: Column(
                            children: [
                              Expanded(child: ExtendedImage.network(
                                typeList[index].picUrl,
                                fit: BoxFit.cover,
                                cache: true,
                                shape: BoxShape.circle,
                              )),
                              const SizedBox(height: 10,),
                              Text( typeList[index].name,style: const TextStyle(color: Colors.white,fontSize: 15),maxLines: 1,overflow: TextOverflow.ellipsis,),
                            ],
                          ),
                        )
                        )
                    ),
                  );
                },childCount:typeList.length)),
          ],
        ),
      ),
    );
  }


  ///可获得对应类型电台列表
  getDjTypeRecommend() async{
    var typeData = await DjService.getDjTypeRecommend(type: widget.id);
    if(typeData!=null && typeData.isNotEmpty){
      typeList =typeData;
      setState(() {

      });
    }else{
      EasyLoading.showToast("数据为空");
    }
  }

}
