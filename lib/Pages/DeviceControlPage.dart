import 'package:flutter/material.dart';
import '../Provider/state_deviceListDisplay.dart';
import '../Custom/ShapeClipper.dart';
import 'dart:convert';
import '../Custom/Toast.dart';

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

class DeviceControlPage extends StatelessWidget{

  final String mapValueJson;
  DeviceControlPage(this.mapValueJson);

  @override
  Widget build(BuildContext context) {

    var list = List<int>();
    jsonDecode(mapValueJson).forEach(list.add);
    final String mapValueString=Utf8Decoder().convert(list);
    var mapValue=json.decode(mapValueString);
    final String deviceName=mapValue['deviceName'];
    final String hash=mapValue['hash'];

    return Scaffold(
      appBar: AppBar(
        title: Text("设备控制页",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(child: Text('设备名:${deviceName}')),
            Container(
              height: 470.0,
              child: Hero(
                tag: '${hash}DeviceControl',
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  elevation: 6.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Color(0xFF00153E),Color(0xFF00267E)]
                          ),
                          //color: lightGrey,
                          border: Border.all(color: Colors.grey.withOpacity(.3), width: .2)),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Image.asset(mapValue['imagePath'],height: 100.0,width: 100.0),
                                    Text("${deviceName}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0,color: Colors.white))
                                  ],
                                ),

                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 4.0,
                            width: 80.0,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [lightBlue, Colors.purple],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            DeviceDetailTopPart(),


            SizedBox(height: 40.0),
            Padding(
              padding: EdgeInsets.only(left: 16.0,right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,//rowtop
                children: <Widget>[
                  Text("管理",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
                  SizedBox(height: 10.0),
                  Container(
                    height: 240.0,
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.flash_off,size: 23.0),
                          title: Text("关闭此设备"),
                          onTap: (){
                            Toast.toast(context, "尚未实现此功能");
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.add_alarm,size: 23.0),
                          title: Text("定时开启"),
                          onTap: (){
                            Toast.toast(context, "尚未实现此功能");
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.remove_circle,size: 23.0),
                          title: Text("移除此设备"),
                          onTap: (){
                            Toast.toast(context, "尚未实现此功能");
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.devices,size: 23.0),
                          title: Text("远程控制"),
                          onTap: (){
                            Toast.toast(context, "尚未实现此功能");
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}

class DeviceDetailTopPart extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: ShapeClipper(),
          child: Container(
            height: 160.0,
            decoration: BoxDecoration(gradient: LinearGradient(colors: [firstColor,secondColor])),
          ),
        ),
        Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
              elevation: 10.0,
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 22.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('上次连接时间: 12:49',style: TextStyle(fontSize: 16.0)),
                          Divider(color: Colors.grey,height: 20.0),
                          Text('总用电量: 0.2kw/h',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}