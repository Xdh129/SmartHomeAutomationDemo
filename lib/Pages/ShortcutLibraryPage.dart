import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';
import '../Provider/ApplicationState.dart';
import '../Route/ApplicationRouter.dart';
import '../Custom/ShapeClipper.dart';
import 'dart:convert';

Color firstColor=Color(0xFFF47D15);
Color secondColor=Color(0xFFEF772C);

final Color discountBackgroundColor=Color(0xFFFFE08D);
final Color flightBorderColor=Color(0xFFE6E6E6);
final Color chipBackgroundColor=Color(0xFFF6F6F6);

const TextStyle dropDownLabelStyle=TextStyle(color: Colors.white,fontSize: 16.0);
const TextStyle dropDownMenuItemStyle=TextStyle(color: Colors.black,fontSize: 16.0);

ThemeData appTheme=ThemeData(
    primaryColor: Color(0xFFF3791A),
    fontFamily: 'Oxygen'
);

class ShortcutLibraryPage extends StatefulWidget {
  @override
  _ShortcutLibraryPageState createState() => _ShortcutLibraryPageState();
}

class _ShortcutLibraryPageState extends State<ShortcutLibraryPage> with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {
    final appState=Provider.of<AppState>(context);
    //super.build(context);
    return Scaffold(
      //appBar: AppBar(
      //  title: Text('My Center Page'),
      //),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 50.0,
              ),
              Text("快捷操作",style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold)),
              SizedBox(
                height: 30.0,
              ),
              Text("日常",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView(
                    primary:false,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1.1,crossAxisSpacing: 8.0,mainAxisSpacing: 8.0),
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: ShortcutDailyRoutineList,
                  )
              ),
              Text("离家",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView(
                    primary:false,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1.1,crossAxisSpacing: 8.0,mainAxisSpacing: 8.0),
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: ShortcutLeavingHomeList,
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<ShortcutLibraryCard> ShortcutDailyRoutineList=[
  ShortcutLibraryCard("日间模式", "现在可添加", "定时","自动执行","每天日出时",[Color(0xFFFB6800),Color(0xFFF9A337)],AppState.generateRandomString()),
  ShortcutLibraryCard("夜间模式","现在可添加", "定时","自动执行","每天日落时",[Color(0xFFFB6800),Color(0xFFF9A337)],AppState.generateRandomString()),
  ShortcutLibraryCard("播放音乐","现在可添加", "定时","自动执行","每天20:00",[Color(0xFFFB6800),Color(0xFFF9A337)],AppState.generateRandomString()),
];

List<ShortcutLibraryCard> ShortcutLeavingHomeList=[
  ShortcutLibraryCard("关闭常用设备", "现在可添加", "单次","自动执行","每天20:00",[Color(0xFF00153E),Color(0xFF00267E)],AppState.generateRandomString()),
  ShortcutLibraryCard("检查设备状态","现在可添加", "单次","自动执行","每天20:00",[Color(0xFFFB6800),Color(0xFFF9A337)],AppState.generateRandomString()),
  ShortcutLibraryCard("离开模式","现在可添加", "单次","自动执行","每天20:00",[Color(0xFF00153E),Color(0xFF00267E)],AppState.generateRandomString()),
];


class ShortcutLibraryCard extends StatelessWidget{

  final String shortcutName,status,automation,autoType,autoTime,hash;
  final colors;

  ShortcutLibraryCard(this.shortcutName,this.status,this.automation,this.autoType,this.autoTime,this.colors,this.hash);

  @override
  Widget build(BuildContext context) {

    Map<String,Object> mapValue={"shortcutName":shortcutName,"status":status,"hash":hash};
    String mapValueString=json.encode(mapValue);
    var mapValueJson = jsonEncode(Utf8Encoder().convert(mapValueString));

    return InkWell(
      onTap: (){
        ApplicationRouter.router.navigateTo(context, '/detailShortcutLibrary?mapValueJson=${mapValueJson}',transition: TransitionType.cupertino);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: '${hash}ShortcutLibrary',
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                elevation: 6.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 136.0,
                        width: 160.0,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Color(0xFFFB6800),Color(0xFFF9A337)]
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0.0,
                        bottom: 0.0,
                        width: 160.0,
                        height: 80.0,
                        child: Container(
                          //color: Colors.black,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [Colors.black,Colors.black.withOpacity(0.1)])
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10.0,
                        bottom: 10.0,
                        right: 10.0,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(children: <Widget>[
                              Text(shortcutName,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16.0),),
                              Text(status,style: TextStyle(fontWeight: FontWeight.normal,color: Colors.white,fontSize: 13.0),),
                            ],),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 6.0,vertical: 2.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Text("$automation",style: TextStyle(fontSize: 7.0,color: Colors.black),),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: 12.0),
                Text(autoType,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.0),),
                SizedBox(width: 5.0),
                Text(autoTime,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal,fontSize: 12.0),),
              ],
            )
          ],
        ),
      ),
    );
  }
}