
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qq_music/page/zai_xian_music/music_hall/song_play/select_detail_page.dart';
import 'package:qq_music/service/song/song_service.dart';

///全部歌单标签选择页面
class SelectAllPage extends StatefulWidget {
  const SelectAllPage({Key? key}) : super(key: key);

  @override
  _SelectAllPageState createState() => _SelectAllPageState();
}

class _SelectAllPageState extends State<SelectAllPage> {
  ///全部分类标签
 List<Map> allTagsList = [];

  ///"categories": {
  //        "0": "语种",
  //        "1": "风格",
  //        "2": "场景",
  //        "3": "情感",
  //        "4": "主题"
  //    }
  Map<String,String> categories = {};

  @override
  void initState() {
    super.initState();

    getSongPlayCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromRGBO(30, 30, 31, 1),
      child: Container(
        margin:const EdgeInsets.only(bottom: 30),
        child: ListView.builder(itemBuilder: (context, index) {
              return    Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: const Color.fromRGBO(68, 68, 69, 1)),
//                  color:  const Color.fromRGBO(48, 48, 49, 1)

                ),
              margin: const EdgeInsets.only(top: 30,left: 50,right: 50),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 100,
                      child: Text(allTagsList[index]['name'],style: const TextStyle(color: Colors.white,fontSize: 16),),
                    ),
                    Expanded(child:  GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int gridIndex)  {
                        return InkWell(
//                        splashColor: Colors.transparent,
//                        highlightColor: Colors.transparent,
                          focusColor: const Color.fromRGBO(48, 48, 49, 1),
                          hoverColor: const Color.fromRGBO(48, 48, 49, 1),
                          onTap: () {
                            Get.to(SelectDetailsPage(tagsName:allTagsList[index]['list'][gridIndex].name),transition: Transition.rightToLeft);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration:  BoxDecoration(
                              border: Border(
                                left:const BorderSide(
                                  width: 0.5,//宽度
                                    color: Color.fromRGBO(68, 68, 69, 1)),
                                right: gridIndex ==allTagsList[index]['list'].length-1? const BorderSide(
                                    width: 0.5,//宽度
                                    color: Color.fromRGBO(68, 68, 69, 1)): BorderSide.none,
                                bottom: gridIndex<= allTagsList[index]['list'].length-6?const BorderSide(
                                    width: 0.5,//宽度
                                    color: Color.fromRGBO(68, 68, 69, 1)): BorderSide.none,

                                ),

                              ),
                            padding: const EdgeInsets.only(top: 10,bottom: 10),
                            child: Text(
                              allTagsList[index]['list'][gridIndex].name,
                              style:
                              const TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        );
                      },
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        /// 纵轴间距
                        mainAxisSpacing: 0,

                        /// 横轴间距
                        crossAxisSpacing: 0,

                        /// 横轴元素个数
                        crossAxisCount: 6,

                        /// 宽高比
                        childAspectRatio: 2.8,
                      )
                      ,itemCount: allTagsList[index]['list'].length,
                    ))
                   ,
                  ],
                ),
              ) ;
        },itemCount: allTagsList.length,),
      ),
    );
  }

  getSongPlayCategory() async{
    var allTags = await SongService.getSongPlayCategory();
    if (allTags != null && allTags.code==200) {
      
      categories =allTags.categories;
      for(var i=0;i<categories.length;i++){
        allTagsList.add(
            {
              "name":categories["$i"],
              "list":allTags.sub.where((e) => e.category==i).toList()
            }
        );
      }
      setState(() {

      });
    }
  }
}
