import 'package:hua_culture/entity/user_entity.dart';

class HConfig {
  static var debug = false;
  static var isLogAction = false;
  static var isLogApi = false;
  static var isMockApi = false;
}

//卡片的类型
const List types = ["全部", "视频", "音频", "图片", "文章"];

//卡片的类别
const List categories = [["中华文化"],
                         ["中华历史", "起源", "成就", "英雄"], 
                         ["语言与文学", "语言", "文字", "诗词", "对联", "灯谜", "小说", "著作", "寓言"],
                         ["思想与信仰", "道教", "易经", "儒学", "百家", "宗教", "家教"],
                         ["科学与技术", "四大发明", "科技成就", "中医"],
                         ["体育与竞技", "武术", "龙舟", "象棋", "围棋"],
                         ["节日与习俗", "历法", "节日", "节气", "婚丧习俗"],
                         ["饮食文化", "四大菜系", "酒文化", "茶文化"],
                         ["民族文化", "服装", "巴蜀文化", "巫蛊"],
                         ["艺术", "戏曲", "乐器", "手工艺", "书法", "美术", "建筑"],
                         ["其它", "常识"],];

int category = 0;
int categoryIndex = 0;

class ScreenSize{
  double height = 1080.0;
  double widght = 1920.0;
}

ScreenSize screenSize = new ScreenSize();

UserEntity globalUser = new UserEntity();

//Android虚拟机映射的IP地址为10.0.2.2，所以这里把IP地址改为10.0.2.2
//真机调试应把IP地址改为本机的IP地址，所以这里为
String globalUrl = "http://10.0.2.2:8080/";