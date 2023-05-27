import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hua_culture/entity/video_entity.dart';
import 'package:hua_culture/public/config.dart';
import 'package:hua_culture/widgets/my_video_player.dart';
import 'package:url_launcher/url_launcher.dart';

class ChineseCulture extends StatelessWidget {
  const ChineseCulture({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VideoEntity video = new VideoEntity();
    video.coverUrl = "static/T508Q(KPXQ`(}X%9%BWA%IX.jpg";
    video.url = "static/1472534631.mp4";
    return Container(
      padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
      child: Column(
        children: [
          Text("有关中华文化的软件安利："),
          Container(
            height: 200,
            child: Swiper(
              itemBuilder: (context,index)=>Image.network(globalUrl + "static/otherApp$index.jpg", fit: BoxFit.cover,),
              itemCount: 5,
              pagination: SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                  color: Colors.orange,
                  activeColor: Colors.green,
                ),
              ),
              control:SwiperControl(),
              scrollDirection: Axis.horizontal,
              autoplay: true,
              onTap: (index) async {
                if(index == 0){
                  await launch("http://www.962.net/azsoft/497197.html");
                } else if (index == 1){
                  await launch("http://mfy.7192.com/");
                } else if (index == 2){
                  await launch("https://www.cr173.com/soft/1005268.html");
                } else if (index == 3){
                  await launch("https://www.cr173.com/soft/680157.html");
                } else if (index == 4){
                  await launch("http://www.appchina.com/app/com.appchina.anpai.2019041604");
                }
                print('点击了第$index个');
              },
            )
          ),
          Text(
            "    中华文化，简写为“CCNGC”，亦称华夏文化，是指以中原文化为基础不断演化、发展而成的中国特有文化。历经千年以上的时间历史演变。中华文化，相传经历了有巢氏、燧人氏、伏羲氏、神农氏（炎帝）、黄帝（轩辕氏）、尧、舜、禹等时代，到中国第一个国家夏朝建立，发展至今，一个拥有灿烂文化的中国，带着丰富多彩的文化元素屹立在世界东方。",
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
            height: 200,
            child: Image.network(globalUrl + "static/@6S_[QZ]LD}(SOT3_JEX~ZW.jpg", fit: BoxFit.cover,),
          ),
          Text(
            "    对于中华民族宝贵的传统文化，中国现有的一切都是以传统为基础的。只有民族的才是世界的，当代很多外国思想家正在反思社会的运行模式和走向，并感觉到了其中的潜在危机。很多思想家反思的结果就是：把目光投向中国，而他们关注的焦点就是中庸思想。中庸精神随着时间的推移，其价值和重要性必将日益显现出来，这一点已经有所表现。中庸之道是世界上最具有连续性的文化，也是中国众多文化流派中最具有价值的核心精神和观念。以儒家思想为代表的中国传统领导哲学从阐释世界与人生最本源的规律出发，得到了对领导理论最精辟的阐述和分析，并且对领导的内涵做出了最为本质和精准的界定。“不考其源流，莫能通古今之变；不明其得失，无以获从入之途。”当代发展儒学思想主要用于企业的管理，应用儒学思想延伸出的领导力智慧是当代企业领导者的必修课，在企业管理方面的应用已经成了当代管理者核心理念。",
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
            ),
          ),
          VideoPlayerWithCover(video: video),
        ],
      )
    );
  }
}