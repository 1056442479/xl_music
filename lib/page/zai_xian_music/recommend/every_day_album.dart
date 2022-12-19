

import 'dart:convert';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qq_music/const/global_data.dart';
import 'package:qq_music/model/album/album_model.dart';
import 'package:qq_music/page/song_user/album_details_page.dart';
import 'package:qq_music/service/song/song_service.dart';
import 'package:qq_music/utils/commutils.dart';

///每日新碟推荐
class EveryDayAlbum extends StatefulWidget {
  const EveryDayAlbum({Key? key}) : super(key: key);

  @override
  _EveryDayAlbumState createState() => _EveryDayAlbumState();
}

class _EveryDayAlbumState extends State<EveryDayAlbum> with AutomaticKeepAliveClientMixin{
  List<AlbumDetailsModel> albumList=CacheGlobalData.cacheEveryDayAlbumList;

  @override
  void initState() {
    super.initState();
    getEveryDayAlbum();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         SizedBox(
            width: 200,
            child: Row(
              children: const [
                Text("新碟上架",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                SizedBox(width: 5,),
//                Icon(Icons.keyboard_arrow_right,color: Colors.white,)
              ],
            ),
          ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 20,),
          child: GridView.builder( shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
//                        padding: EdgeInsets.all(10.w),
              itemCount: albumList.length>10?10:albumList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                /// 纵轴间距
                mainAxisSpacing: 20.0,
                /// 横轴间距
                crossAxisSpacing: 7.0,
                /// 横轴元素个数
                crossAxisCount: 5,
                /// 宽高比
                childAspectRatio: 0.8,
              ), itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    Get.to(()=>AlbumDetailsPage(id:albumList[index]. id, username: albumList[index].artist?.name ?? "佚名",
                        createTime: albumList[index].publishTime, name:  albumList[index].name,
                        picUrl: albumList[index].picUrl, uid: albumList[index].artist?.id ?? 0),transition: Transition.rightToLeft);
                  },
                  child: LayoutBuilder(
                    builder: (context , constraints ) {
                      return    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width:double.infinity,
                              height: constraints.biggest.height-50,
                              child:      ExtendedImage.network(
                                albumList[index].picUrl,
                                fit: BoxFit.fill,
                                cache: true,
                                width: constraints.biggest.width,
                                height: constraints.biggest.height-45,
                              )),

                          const SizedBox(height: 10,),
                          SizedBox(
                            height: 40,
                            child: Text(albumList[index].name,style: const TextStyle(color: Colors.white,fontSize: 15),textScaleFactor: 1,),
                          )
                        ],);
                    },
                  ),
                );
              }),

        ),
        ],
      ),
    );
  }

  ///删除昨天的缓存数据
  deleteYesterday() async{
    var now = DateTime.now().subtract(const Duration(days: 1));
    CommUtils.removeLocalStorageByKey("${now.year}-${now.month}-${now.day}album");
  }

  getEveryDayAlbum() async{
    deleteYesterday();
    if(CacheGlobalData.cacheEveryDayAlbumList.isEmpty){
      var now = DateTime.now();
//      String t ="[{\"id\":3136952023,\"type\":1,\"name\":\"私人雷达 | 根据听歌记录为你打造\",\"copywriter\":\"\",\"picUrl\":\"https://p2.music.126.net/3I-73aQn3YCw-2cZdK1fQw==/109951166027478939.jpg\",\"playcount\":13550662656,\"createTime\":1577330551437,\"creator\":{\"avatarImgIdStr\":\"109951165005238078\",\"backgroundUrl\":\"http://p1.music.126.net/-7gz68N_fr_bikp_-Q3hjA==/109951165449481018.jpg\",\"avatarImgId\":109951165005238080,\"backgroundImgId\":109951165449481020,\"mutual\":false,\"remarkName\":null,\"detailDescription\":\"云音乐私人雷达官方账号\",\"defaultAvatar\":false,\"expertTags\":null,\"djStatus\":0,\"followed\":false,\"backgroundImgIdStr\":\"109951165449481018\",\"userId\":1287293193,\"accountStatus\":0,\"vipType\":0,\"province\":310000,\"avatarUrl\":\"https://p2.music.126.net/4ZjO1oj0WTeN5U19FpnQFw==/109951165005238078.jpg\",\"authStatus\":1,\"userType\":10,\"nickname\":\"云音乐私人雷达\",\"gender\":0,\"birthday\":0,\"city\":310101,\"description\":\"云音乐私人雷达官方账号\",\"signature\":\"喵~~~\",\"authority\":0},\"trackCount\":55,\"userId\":1287293193,\"alg\":\"alg_mgc_red\"},{\"id\":7228606210,\"type\":1,\"name\":\"[节奏控]【超好听的小众英文歌】\",\"copywriter\":\"有你喜欢的歌\",\"picUrl\":\"https://p2.music.126.net/isRPJ1dkRF4DSmvctGDvZQ==/109951167512612272.jpg\",\"playcount\":7037835,\"createTime\":1641698218014,\"creator\":{\"avatarImgIdStr\":\"109951168108011933\",\"backgroundUrl\":\"http://p1.music.126.net/PHPJLipW-QACxLrAbaGlcw==/109951165424649829.jpg\",\"avatarImgId\":109951168108011940,\"backgroundImgId\":109951165424649820,\"mutual\":false,\"remarkName\":null,\"detailDescription\":\"\",\"defaultAvatar\":false,\"expertTags\":null,\"djStatus\":10,\"followed\":false,\"backgroundImgIdStr\":\"109951165424649829\",\"userId\":5161102955,\"accountStatus\":0,\"vipType\":0,\"province\":1000000,\"avatarUrl\":\"https://p2.music.126.net/XNx0uyK6HjOocIyo8tIKPA==/109951168108011933.jpg\",\"authStatus\":0,\"userType\":0,\"nickname\":\"Gabelm\",\"gender\":2,\"birthday\":0,\"city\":1010000,\"description\":\"\",\"signature\":\"·平凡·\",\"authority\":0},\"trackCount\":278,\"userId\":5161102955,\"alg\":\"bysong_rt\"},{\"id\":7487493788,\"type\":1,\"name\":\"2022全网超好听热门歌曲\",\"copywriter\":\"你可能感兴趣\",\"picUrl\":\"https://p2.music.126.net/cOuDPDplbfimY6X9yuxJug==/109951167550576091.jpg\",\"playcount\":12626927,\"createTime\":1655186685200,\"creator\":{\"avatarImgIdStr\":\"109951167321216765\",\"backgroundUrl\":\"http://p1.music.126.net/2zSNIqTcpHL2jIvU6hG0EA==/109951162868128395.jpg\",\"avatarImgId\":109951167321216770,\"backgroundImgId\":109951162868128400,\"mutual\":false,\"remarkName\":null,\"detailDescription\":\"\",\"defaultAvatar\":false,\"expertTags\":null,\"djStatus\":0,\"followed\":false,\"backgroundImgIdStr\":\"109951162868128395\",\"userId\":3937312537,\"accountStatus\":0,\"vipType\":0,\"province\":330000,\"avatarUrl\":\"https://p2.music.126.net/P_xno1NNjH7PTnI9NKtTgg==/109951167321216765.jpg\",\"authStatus\":0,\"userType\":0,\"nickname\":\"圆嘟嘟小甜饼\",\"gender\":0,\"birthday\":0,\"city\":330100,\"description\":\"\",\"signature\":\"\",\"authority\":0},\"trackCount\":54,\"userId\":3937312537,\"alg\":\"bysong_rt\"},{\"id\":4860069866,\"type\":1,\"name\":\"超级治愈英文歌曲，温柔到心里，一秒沦陷\",\"copywriter\":\"十万收藏\",\"picUrl\":\"https://p2.music.126.net/syudgFoTv67EDagakcH5tw==/109951165003596216.jpg\",\"playcount\":26149982,\"createTime\":1581517924573,\"creator\":{\"avatarImgIdStr\":\"109951166718327233\",\"backgroundUrl\":\"http://p1.music.126.net/tgy_btP0siM9wN3o7lj9Vw==/109951166110049954.jpg\",\"avatarImgId\":109951166718327230,\"backgroundImgId\":109951166110049950,\"mutual\":false,\"remarkName\":null,\"detailDescription\":\"\",\"defaultAvatar\":false,\"expertTags\":null,\"djStatus\":0,\"followed\":false,\"backgroundImgIdStr\":\"109951166110049954\",\"userId\":1892163773,\"accountStatus\":0,\"vipType\":10,\"province\":710000,\"avatarUrl\":\"https://p2.music.126.net/16JQKrz0SnVjk8VGnd8aRw==/109951166718327233.jpg\",\"authStatus\":0,\"userType\":207,\"nickname\":\"烟雨任平生vv\",\"gender\":1,\"birthday\":0,\"city\":710900,\"description\":\"\",\"signature\":\"少研究别人，多塑造自己\",\"authority\":0},\"trackCount\":225,\"userId\":1892163773,\"alg\":\"bysong_rt\"},{\"id\":2829883282,\"type\":1,\"name\":\"[华语私人订制] 最懂你的华语推荐 每日更新35首\",\"copywriter\":\"\",\"picUrl\":\"https://p2.music.126.net/0VRN6GBaPibXxfKz2UbzdA==/109951165959686617.jpg\",\"playcount\":1490684928,\"createTime\":1559735469152,\"creator\":{\"avatarImgIdStr\":\"109951163951118282\",\"backgroundUrl\":\"http://p1.music.126.net/chlOFsm3eMrJGc4b9am18A==/109951165404950147.jpg\",\"avatarImgId\":109951163951118290,\"backgroundImgId\":109951165404950140,\"mutual\":false,\"remarkName\":null,\"detailDescription\":\"网易云音乐官方歌单\",\"defaultAvatar\":false,\"expertTags\":null,\"djStatus\":0,\"followed\":false,\"backgroundImgIdStr\":\"109951165404950147\",\"userId\":1463586082,\"accountStatus\":0,\"vipType\":11,\"province\":330000,\"avatarUrl\":\"https://p2.music.126.net/eHeoKe-NWVBMM8S3DCJfog==/109951163951118282.jpg\",\"authStatus\":1,\"userType\":10,\"nickname\":\"云音乐官方歌单\",\"gender\":0,\"birthday\":0,\"city\":330100,\"description\":\"网易云音乐官方歌单\",\"signature\":\"点击关注，一手掌握最新上线官方歌单！（有对官方歌单建议反馈欢迎私信）\",\"authority\":0},\"trackCount\":55,\"userId\":1463586082,\"alg\":\"alg_mgc_red_lan\"},{\"id\":7402057985,\"type\":1,\"name\":\"降速0.8x/低倍速慢节奏听觉盛宴\",\"copywriter\":\"\",\"picUrl\":\"https://p2.music.126.net/HvQi2mL_8zkTP9QGngFqtg==/109951167782817108.jpg\",\"playcount\":5697354,\"createTime\":1651200648581,\"creator\":{\"avatarImgIdStr\":\"109951167786656829\",\"backgroundUrl\":\"http://p1.music.126.net/2zSNIqTcpHL2jIvU6hG0EA==/109951162868128395.jpg\",\"avatarImgId\":109951167786656830,\"backgroundImgId\":109951162868128400,\"mutual\":false,\"remarkName\":null,\"detailDescription\":\"\",\"defaultAvatar\":false,\"expertTags\":null,\"djStatus\":0,\"followed\":false,\"backgroundImgIdStr\":\"109951162868128395\",\"userId\":3285089404,\"accountStatus\":0,\"vipType\":0,\"province\":330000,\"avatarUrl\":\"https://p2.music.126.net/QCsmLRQLTrc5YNBZIBCf_Q==/109951167786656829.jpg\",\"authStatus\":0,\"userType\":0,\"nickname\":\"空海间\",\"gender\":0,\"birthday\":0,\"city\":330700,\"description\":\"\",\"signature\":\"\",\"authority\":0},\"trackCount\":518,\"userId\":3285089404,\"alg\":\"byplaylist_play_profile_swing\"},{\"id\":7593107402,\"type\":1,\"name\":\"在谁的怀中会有感觉(降调08x)\",\"copywriter\":\"\",\"picUrl\":\"https://p2.music.126.net/zcthRDETXpj7iFBaNvQHfQ==/109951167883543094.jpg\",\"playcount\":2677157,\"createTime\":1660671047286,\"creator\":{\"avatarImgIdStr\":\"109951168087135354\",\"backgroundUrl\":\"http://p1.music.126.net/f6vstCEpOOAVJ6uV-x7aUA==/109951165395730790.jpg\",\"avatarImgId\":109951168087135360,\"backgroundImgId\":109951165395730780,\"mutual\":false,\"remarkName\":null,\"detailDescription\":\"\",\"defaultAvatar\":false,\"expertTags\":null,\"djStatus\":10,\"followed\":false,\"backgroundImgIdStr\":\"109951165395730790\",\"userId\":7837611657,\"accountStatus\":0,\"vipType\":11,\"province\":450000,\"avatarUrl\":\"https://p2.music.126.net/rw93eoIXo3qlkf894kmXTQ==/109951168087135354.jpg\",\"authStatus\":0,\"userType\":0,\"nickname\":\"新之助_08x\",\"gender\":1,\"birthday\":0,\"city\":450200,\"description\":\"\",\"signature\":\"启程值得期待\",\"authority\":0},\"trackCount\":159,\"userId\":7837611657,\"alg\":\"byplaylist_play_profile_swing\"},{\"id\":7458650080,\"type\":1,\"name\":\"2022网易云最火流行歌曲推荐(更新快)\",\"copywriter\":\"收藏过万\",\"picUrl\":\"https://p2.music.126.net/LO_92D4aKctPiUwfRJn7xw==/109951167654629882.jpg\",\"playcount\":5863154,\"createTime\":1653744467297,\"creator\":{\"avatarImgIdStr\":\"109951165149869789\",\"backgroundUrl\":\"http://p1.music.126.net/mqRgywqK0BQvxryUnU0odw==/109951165149874200.jpg\",\"avatarImgId\":109951165149869800,\"backgroundImgId\":109951165149874200,\"mutual\":false,\"remarkName\":null,\"detailDescription\":\"\",\"defaultAvatar\":false,\"expertTags\":[\"流行\"],\"djStatus\":0,\"followed\":false,\"backgroundImgIdStr\":\"109951165149874200\",\"userId\":403746215,\"accountStatus\":0,\"vipType\":11,\"province\":110000,\"avatarUrl\":\"https://p2.music.126.net/rpQMy-VH2R1xZKAJObm3MA==/109951165149869789.jpg\",\"authStatus\":0,\"userType\":200,\"nickname\":\"小乂怕疼\",\"gender\":2,\"birthday\":0,\"city\":110101,\"description\":\"\",\"signature\":\"\",\"authority\":0},\"trackCount\":195,\"userId\":403746215,\"alg\":\"bysong_rt\"},{\"id\":2568673678,\"type\":1,\"name\":\"［戏腔］[古风] 戏子多秋 可怜一处情深旧\",\"copywriter\":\"\",\"picUrl\":\"https://p2.music.126.net/-lchj0QP79nRFXiUyW13ng==/109951164606753936.jpg\",\"playcount\":9537946,\"createTime\":1545486720242,\"creator\":{\"avatarImgIdStr\":\"109951166216766691\",\"backgroundUrl\":\"http://p1.music.126.net/dBcRbagFDQ1jhCdgs5azFg==/109951166500467771.jpg\",\"avatarImgId\":109951166216766690,\"backgroundImgId\":109951166500467780,\"mutual\":false,\"remarkName\":null,\"detailDescription\":\"\",\"defaultAvatar\":false,\"expertTags\":null,\"djStatus\":0,\"followed\":false,\"backgroundImgIdStr\":\"109951166500467771\",\"userId\":1611229012,\"accountStatus\":0,\"vipType\":0,\"province\":510000,\"avatarUrl\":\"https://p2.music.126.net/8qMYUTzxXH8DO78oBu-gbw==/109951166216766691.jpg\",\"authStatus\":0,\"userType\":0,\"nickname\":\"小鱼小鱼小余\",\"gender\":2,\"birthday\":0,\"city\":510500,\"description\":\"\",\"signature\":\"\",\"authority\":0},\"trackCount\":124,\"userId\":1611229012,\"alg\":\"bysong_profile_ol\"},{\"id\":4977202709,\"type\":1,\"name\":\"伤感古风，慎入！极殇，催泪\",\"copywriter\":\"\",\"picUrl\":\"https://p2.music.126.net/TvWqa0FkTNtyoPJpdgmUJA==/109951164919937320.jpg\",\"playcount\":698055,\"createTime\":1587291775069,\"creator\":{\"avatarImgIdStr\":\"109951164983313143\",\"backgroundUrl\":\"http://p1.music.126.net/iBPRAP4MgVvcM9OhgAyVyA==/109951164702116792.jpg\",\"avatarImgId\":109951164983313140,\"backgroundImgId\":109951164702116800,\"mutual\":false,\"remarkName\":null,\"detailDescription\":\"\",\"defaultAvatar\":false,\"expertTags\":null,\"djStatus\":0,\"followed\":false,\"backgroundImgIdStr\":\"109951164702116792\",\"userId\":3218056538,\"accountStatus\":0,\"vipType\":0,\"province\":220000,\"avatarUrl\":\"https://p2.music.126.net/ejiuW5JSC_24-oEdHS3W8A==/109951164983313143.jpg\",\"authStatus\":0,\"userType\":0,\"nickname\":\"陌咿wyw\",\"gender\":2,\"birthday\":0,\"city\":220100,\"description\":\"\",\"signature\":\"\",\"authority\":0},\"trackCount\":92,\"userId\":3218056538,\"alg\":\"bysong_profile_ol\"},{\"id\":5026791151,\"type\":1,\"name\":\"『ACG/高燃/踩点』热门的漫剪配乐\",\"copywriter\":\"\",\"picUrl\":\"https://p2.music.126.net/8Gh0Vz7336YABfBxa_xTlw==/109951167445951779.jpg\",\"playcount\":7185211,\"createTime\":1589948043836,\"creator\":{\"avatarImgIdStr\":\"109951168098040464\",\"backgroundUrl\":\"http://p1.music.126.net/7ks1pblbLLC67QaJtJgnMA==/109951166007918683.jpg\",\"avatarImgId\":109951168098040460,\"backgroundImgId\":109951166007918690,\"mutual\":false,\"remarkName\":null,\"detailDescription\":\"\",\"defaultAvatar\":false,\"expertTags\":null,\"djStatus\":0,\"followed\":false,\"backgroundImgIdStr\":\"109951166007918683\",\"userId\":1491903409,\"accountStatus\":0,\"vipType\":11,\"province\":440000,\"avatarUrl\":\"https://p2.music.126.net/1SsDpmJZSBvF7pdElPkfBA==/109951168098040464.jpg\",\"authStatus\":0,\"userType\":0,\"nickname\":\"神里龟龟i\",\"gender\":1,\"birthday\":0,\"city\":445200,\"description\":\"\",\"signature\":\"自由\",\"authority\":0},\"trackCount\":119,\"userId\":1491903409,\"alg\":\"bytrack_rt\"},{\"id\":7505247922,\"type\":1,\"name\":\"2022上半年音乐榜单\",\"copywriter\":\"\",\"picUrl\":\"https://p2.music.126.net/I0xEXgDEWAFvs-TP-1hvnw==/109951168007916492.jpg\",\"playcount\":2897096,\"createTime\":1656139565672,\"creator\":{\"avatarImgIdStr\":\"109951168010975898\",\"backgroundUrl\":\"http://p1.music.126.net/V5KPKgr_NMi3wGZZXBzoFg==/109951166652886320.jpg\",\"avatarImgId\":109951168010975900,\"backgroundImgId\":109951166652886320,\"mutual\":false,\"remarkName\":null,\"detailDescription\":\"\",\"defaultAvatar\":false,\"expertTags\":null,\"djStatus\":10,\"followed\":false,\"backgroundImgIdStr\":\"109951166652886320\",\"userId\":610336824,\"accountStatus\":0,\"vipType\":11,\"province\":310000,\"avatarUrl\":\"https://p2.music.126.net/4MI3IZNSXqQ_5Pz3hu5dvQ==/109951168010975898.jpg\",\"authStatus\":1,\"userType\":4,\"nickname\":\"芳心收集人士\",\"gender\":1,\"birthday\":0,\"city\":310101,\"description\":\"\",\"signature\":\"//歌单商务v: graps_1027//\",\"authority\":0},\"trackCount\":368,\"userId\":610336824,\"alg\":\"bytrack_rt\"},{\"id\":2228795231,\"type\":1,\"name\":\"【旋律控】超好听的欧美热门歌曲\",\"copywriter\":\"\",\"picUrl\":\"https://p2.music.126.net/Dp8QSsP8xlU7yYIuo8pjCA==/109951167305112641.jpg\",\"playcount\":8144128,\"createTime\":1526468953507,\"creator\":{\"avatarImgIdStr\":\"109951167848711953\",\"backgroundUrl\":\"http://p1.music.126.net/PUXTHVCPlIsoML6U0J8HNg==/109951163601232926.jpg\",\"avatarImgId\":109951167848711950,\"backgroundImgId\":109951163601232930,\"mutual\":false,\"remarkName\":null,\"detailDescription\":\"\",\"defaultAvatar\":false,\"expertTags\":[\"电子\",\"轻音乐\",\"欧美\"],\"djStatus\":10,\"followed\":false,\"backgroundImgIdStr\":\"109951163601232926\",\"userId\":50255421,\"accountStatus\":0,\"vipType\":11,\"province\":220000,\"avatarUrl\":\"https://p2.music.126.net/9NwzD8O6vrWDHaP68AmiuA==/109951167848711953.jpg\",\"authStatus\":1,\"userType\":4,\"nickname\":\"HUMAN00\",\"gender\":1,\"birthday\":0,\"city\":220100,\"description\":\"\",\"signature\":\"以梦为马，不负韶华。\",\"authority\":0},\"trackCount\":333,\"userId\":50255421,\"alg\":\"bysong_rt\"}]";
//     await CommUtils.setLocalStorage("${now.year}-${now.month}-${now.day}album",t);
      var localStorageByKey = await CommUtils.getLocalStorageByKey("${now.year}-${now.month}-${now.day}album");
      if(localStorageByKey!="null"){
        var list = List<AlbumDetailsModel>.from(jsonDecode(localStorageByKey).map((x) => AlbumDetailsModel.fromJson(x)));
        if(list.isNotEmpty){
          setState(() {
            CacheGlobalData.cacheEveryDayAlbumList =list;
            albumList =list;
          });
          return;
        }
      }

      var getList = await SongService.getEveryDayAlbum();
      if(getList!=null){
        setState(() {
          CacheGlobalData.cacheEveryDayAlbumList =getList;
          albumList =getList;
        });
      }
    }

  }

  @override
  bool get wantKeepAlive => true;

}
