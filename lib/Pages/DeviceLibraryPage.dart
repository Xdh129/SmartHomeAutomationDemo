import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';
import '../Route/ApplicationRouter.dart';
import '../Provider/ApplicationState.dart';
import 'dart:convert';

Color firstColor=Color(0xFFF47D15);
Color secondColor=Color(0xFFEF772C);

final Color discountBackgroundColor=Color(0xFFFFE08D);
final Color flightBorderColor=Color(0xFFE6E6E6);
final Color chipBackgroundColor=Color(0xFFF6F6F6);

const TextStyle dropDownLabelStyle=TextStyle(color: Colors.white,fontSize: 16.0);
const TextStyle dropDownMenuItemStyle=TextStyle(color: Colors.black,fontSize: 16.0);

class DeviceLibraryPage extends StatefulWidget {
  @override
  _DeviceLibraryPageState createState() => _DeviceLibraryPageState();
}

class _DeviceLibraryPageState extends State<DeviceLibraryPage> with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {
    final appState=Provider.of<AppState>(context);
    //super.build(context);
    return Scaffold(

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
              Text("设备库",style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold)),
              SizedBox(
                height: 30.0,
              ),
              Text("智能硬件",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView(
                    primary:false,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1.1,crossAxisSpacing: 0.0,mainAxisSpacing: 0.0),
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: SmartHardwareList,
                  )
              ),
              Text("家电",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView(
                    primary:false,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1.1,crossAxisSpacing: 0.0,mainAxisSpacing: 0.0),
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: HomeHardwareList,
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<DeviceLibraryCard> SmartHardwareList=[
  DeviceLibraryCard("智能插线板", "现在可添加", "大米","assets/images/smartelectricboard.png",AppState.generateRandomString()),
  DeviceLibraryCard("滑板车", "现在可添加", "大米","assets/images/devices/electricskatecarwhite.png",AppState.generateRandomString()),
  DeviceLibraryCard("智能音箱","现在可添加", "大米","assets/images/smartsoundbarhd.png",AppState.generateRandomString()),
  DeviceLibraryCard("智能台灯","现在可添加", "大米","assets/images/devices/smarttablelamp.png",AppState.generateRandomString()),
];

List<DeviceLibraryCard> HomeHardwareList=[
  DeviceLibraryCard("冰箱", "现在可添加", "大米","assets/images/devices/fridge483l.png",AppState.generateRandomString()),
  DeviceLibraryCard("智能空调","现在可添加", "大米","assets/images/devices/airconditionera.png",AppState.generateRandomString()),
  DeviceLibraryCard("扫地机器人","现在可添加", "大米","assets/images/devices/cleanrobot1c.png",AppState.generateRandomString()),
];

class DeviceLibraryCard extends StatelessWidget{

  final String deviceName,status,brand,imagePath,hash;

  DeviceLibraryCard(this.deviceName,this.status,this.brand,this.imagePath,this.hash);



  @override
  Widget build(BuildContext context) {

    Map<String,Object> mapValue={"deviceName":deviceName,"imagePath":imagePath,"hash":hash};
    String mapValueString=json.encode(mapValue);
    var mapValueJson = jsonEncode(Utf8Encoder().convert(mapValueString));

    return InkWell(
      onTap: (){
        ApplicationRouter.router.navigateTo(context, '/detailDeviceLibrary?&mapValueJson=${mapValueJson}',transition: TransitionType.cupertino);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: '${hash}DeviceLibrary',
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                elevation: 6.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 180.0,
                        width: 180.0,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Color(0xFF00153E),Color(0xFF00267E)]
                          ),
                        ),
                        child: Image.asset(imagePath,fit: BoxFit.fill),
                      ),
                      Positioned(
                        left: 0.0,
                        bottom: 0.0,
                        width: 160.0,
                        height: 70.0,
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
                        left: 5.0,
                        bottom: 10.0,
                        right: 10.0,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(children: <Widget>[
                              Text(deviceName,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16.0),),
                              Text(status,style: TextStyle(fontWeight: FontWeight.normal,color: Colors.white,fontSize: 12.0),),
                            ],),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 6.0,vertical: 2.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Text('${brand}',style: TextStyle(fontSize: 10.0,color: Colors.black),),
                            ),


                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}