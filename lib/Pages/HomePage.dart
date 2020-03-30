import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';
import '../Custom/ShapeClipper.dart';
import '../Custom/Toast.dart';
import '../Route/ApplicationRouter.dart';
import '../Provider/state_deviceListDisplay.dart';
import '../Provider/ApplicationState.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {

    //super.build(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            HomeScreenTopPart(),homeScreenBottomPart,DeviceListDisplay(),
          ],
        ),
      ),
    );
  }
}

Color firstColor=Color(0xFFF47D15);
Color secondColor=Color(0xFFEF772C);

//Color firstColor=Color(0xFFFA709A);
//Color secondColor=Color(0xFFFEE140);

const TextStyle dropDownLabelStyle=TextStyle(color: Colors.white,fontSize: 16.0,fontWeight: FontWeight.bold);
const TextStyle dropDownMenuItemStyle=TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold);
List<String> locations=['客厅','厨房','卧室'];

class HomeScreenTopPart extends StatefulWidget{
  @override
  _HomeScreenTopPartState createState() => _HomeScreenTopPartState();
}

class _HomeScreenTopPartState extends State<HomeScreenTopPart>{

  var selectedLocationIndex=0;
  var isSceneModeSelected=true;

  //String barcode = "";

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: ShapeClipper(),
          child: Container(
            height: 400.0,
            //color: Colors.orange,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: AppState.shapeGradientColor[AppState.shapeGradientColorIndex])
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.location_on,color: Colors.white),
                      SizedBox(width: 16.0),
                      PopupMenuButton(
                        onSelected: (index){
                          setState(() {
                            selectedLocationIndex=index;
                          });
                          switch(index){
                            case 0:{
                              appState.switchToLivingRoom();
                              break;
                            }
                            case 1:{
                              appState.switchToKitchen();
                              break;
                            }
                            case 2:{
                              appState.switchToBedroom();
                              break;
                            }
                          }
                        },
                        child: Row(
                          children: <Widget>[
                            Text(locations[selectedLocationIndex],style: dropDownLabelStyle),
                            Icon(Icons.keyboard_arrow_down,color: Colors.white,)
                          ],
                        ),
                        itemBuilder: (BuildContext context) {
                          return <PopupMenuItem<int>>[
                            PopupMenuItem(
                              child: Row(
                                children: <Widget>[
                                  Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),child: Icon(Icons.home)),
                                  Text(locations[0],style: dropDownMenuItemStyle,),
                                ],
                              ),
                              value: 0,
                            ),
                            PopupMenuItem(
                              child: Row(
                                children: <Widget>[
                                  Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),child: Icon(Icons.free_breakfast)),
                                  Text(locations[1],style: dropDownMenuItemStyle),
                                ],
                              ),
                              value: 1,
                            ),
                            PopupMenuItem(
                              child: Row(
                                children: <Widget>[
                                  Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),child: Icon(Icons.local_hotel)),
                                  Text(locations[2],style: dropDownMenuItemStyle),
                                ],
                              ),
                              value: 2,
                            ),
                          ];
                        },
                      ),
                      Spacer(

                      ),
                      /*
                      RaisedButton(
                        onPressed: ()async{
                          appState.addNewDeviceTest();
                          //AppState.currentDevice.removeAt(1);
                          //appState.switchTheme();
                          //appState.addNewTodayInfo();
                          Toast.toast(context, "已添加设备");
                        },
                        child: Text("test"),
                      ),
                       */
                      PopupMenuButton(
                          onSelected: (index){
                            if(index==0){
                              scanCode();
                            }else if(index==1){
                              ApplicationRouter.router.navigateTo(context, '/enter',transition: TransitionType.cupertino);
                            }
                          },
                          child: Icon(Icons.add_circle),
                          itemBuilder: (BuildContext context) {
                            return <PopupMenuItem<int>>[
                              PopupMenuItem(
                                child: Row(children: <Widget>[
                                  Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),child: Icon(Icons.fullscreen)),
                                  Text('扫码添加')
                                ],),
                                value: 0,
                              ),
                              PopupMenuItem(
                                child: Row(children: <Widget>[
                                  Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),child: Icon(Icons.add)),
                                  Text('手动添加')
                                ],),
                                value: 1,
                              ),
                            ];}
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 110.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    child: TextField(
                      //controller: TextEditingController(text: "1"),
                      style: dropDownMenuItemStyle,
                      cursorColor: Color(0xFFF3791A),
                      decoration: InputDecoration(
                        hintText: "请问需要什么帮助...",
                        contentPadding: EdgeInsets.symmetric(horizontal: 32.0,vertical: 14.0),
                        suffix: Material(
                          elevation: 2.0,
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          child: InkWell(
                              onTap: (){
                                //Navigator.push(context, MaterialPageRoute(builder: (context)=> FlightListingScreen()));
                              },
                              child: Icon(Icons.arrow_forward,color: Colors.blue)),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      child: ChoiceChip(Icons.wb_sunny,"日间状态",isSceneModeSelected),
                      onTap: (){
                        setState(() {
                          appState.setDayTheme();
                          isSceneModeSelected=true;
                        });
                      },),

                    SizedBox(width: 20.0,),
                    InkWell(
                      child: ChoiceChip(Icons.hotel,"夜间状态",!isSceneModeSelected),
                      onTap: (){
                        setState(() {
                          appState.setDarkTheme();
                          isSceneModeSelected=false;
                        });
                      },
                    )
                  ],
                )

              ],
            ),

          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 100.0,left: 30.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: AppState.todayInfo.length,
              itemBuilder: (context,index){
                return AppState.todayInfo[index];
              },
            ),
          ),
        )
        //Positioned(left: 25.0,top: 120.0,child: Text('客厅',style: TextStyle(fontSize: 30.0,color: Colors.white,fontWeight: FontWeight.bold))),
      ],
    );
  }

  Future scanCode() async {
    final appState = Provider.of<AppState>(context);
    try {
      String barcode=await BarcodeScanner.scan();
      //setState(() => this.barcode = barcode);
      //this.barcode=barcode;
      Map<String,Object> deviceInfo =jsonDecode(barcode);
      //String deviceName='${deviceInfo['deviceName']}';
      String name=deviceInfo['name'];
      String status=deviceInfo['status'];
      //String battery=deviceInfo['battery'];
      String imagePath=deviceInfo['imagePath'];
      //Map<String,Object> newDevice={"icon":Icons.devices,"name":deviceName,"status":"已连接","cardColor":lightGrey,"progressBar":42.0,"imagePath":imagePath,"hash":AppState.generateRandomString()};

      appState.addNewDevicebyScan(deviceInfo);
      Toast.toast(context, "已添加设备 ${deviceInfo['name']}");

      //ApplicationRouter.router.navigateTo(context, '/detail?name=${name}',transition: TransitionType.cupertino);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        /*
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
        */
      } else {
        //setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      //setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      //setState(() => this.barcode = 'Unknown error: $e');
    }
  }

}

class ChoiceChip extends StatefulWidget{

  IconData icon;
  String text;
  final bool isSelected;

  ChoiceChip(this.icon,this.text,this.isSelected);

  @override
  _ChoiceChipState createState()=> _ChoiceChipState();

}

class _ChoiceChipState extends State<ChoiceChip>{


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.0,vertical: 8.0),
      decoration: widget.isSelected ? BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.all(Radius.circular(20.0))) : null,
      child:Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(widget.icon,size: 20.0,color: Colors.white,),
          SizedBox(width: 8.0),
          Text(widget.text,style: TextStyle(color: Colors.white,fontSize: 15.0))
        ],
      ) ,
    );
  }
}

var viewAllStyle=TextStyle(fontSize: 14.0,color: Color(0xFFF3791A));

var homeScreenBottomPart=Column(
  children: <Widget>[
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(width: 16.0),
          Text("常用快捷操作",style: dropDownMenuItemStyle,),
          Spacer(),
          Text("查看全部",style: viewAllStyle,)
        ],
      ),
    ),
    Container(
      height: 120.0,//SizeRestart
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: currentShortcutList,
      ),
    ),
  ],
);



List<ShortcutCard> currentShortcutList=[
  ShortcutCard("日间模式", "已添加", "定时","自动执行","每天日出时",[Color(0xFFFB6800),Color(0xFFF9A337)],"assets/images/devices/electricskatecarwhite.jpg",AppState.generateRandomString()),
  ShortcutCard("夜间模式","已添加", "定时","自动执行","每天日落时",[Color(0xFFFB6800),Color(0xFFF9A337)],"assets/images/athens.jpg",AppState.generateRandomString()),
  ShortcutCard("播放音乐","现在可添加", "定时","自动执行","每天20:00",[Color(0xFFFB6800),Color(0xFFF9A337)],"assets/images/sydney.jpg",AppState.generateRandomString()),
];




class ShortcutCard extends StatelessWidget{

  final String shortcutName,status,automation,autoType,autoTime,imagePath,hash;
  final colors;

  ShortcutCard(this.shortcutName,this.status,this.automation,this.autoType,this.autoTime,this.colors,this.imagePath,this.hash);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        //ApplicationRouter.router.navigateTo(context, '/detail?cityName=${cityName}',transition: TransitionType.cupertino);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
              elevation: 6.0,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 80.0,
                      width: 160.0,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Color(0xFF00153E),Color(0xFF00267E)]
                          )
                      ),
                      //child: Image.asset(imagePath,fit: BoxFit.fitHeight),
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
                            Text(shortcutName,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18.0),),
                            Text(status,style: TextStyle(fontWeight: FontWeight.normal,color: Colors.white,fontSize: 14.0),),
                          ],),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.0,vertical: 2.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Text("$automation",style: TextStyle(fontSize: 10.0,color: Colors.black),),
                          ),


                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: 5.0),
                Text(autoType,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.0)),
                SizedBox(width: 5.0),
                Text(autoTime,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal,fontSize: 12.0)),
              ],
            )
          ],
        ),
      ),
    );
  }
}