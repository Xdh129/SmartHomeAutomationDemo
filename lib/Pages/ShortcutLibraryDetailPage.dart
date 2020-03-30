import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/ApplicationState.dart';
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

class ShortcutLibraryDetailPage extends StatelessWidget{

  final String mapValueJson;
  ShortcutLibraryDetailPage(this.mapValueJson);

  @override
  Widget build(BuildContext context) {
    var list = List<int>();
    jsonDecode(mapValueJson).forEach(list.add);
    final String mapValueString=Utf8Decoder().convert(list);
    var mapValue=json.decode(mapValueString);
    final String shortcutName=mapValue['shortcutName'];
    final String hash=mapValue['hash'];

    return Scaffold(
      appBar: AppBar(
        title: Text("快捷操作详情页",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(child: Text('设备名称:${shortcutName}')),
            Container(
              height: 300.0,
              child: Hero(
                tag: '${hash}ShortcutLibrary',
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
                                    Text("快捷操作:${shortcutName}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0,color: Colors.white))
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

            SizedBox(height: 40.0),
            Padding(
              padding: EdgeInsets.only(left: 16.0,right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,//rowtop
                children: <Widget>[
                  Text("操作",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
                  SizedBox(height: 10.0),
                  Container(
                    height: 200.0,
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.add_circle,size: 23.0),
                          title: Text("添加此快捷操作"),
                          onTap: (){
                            Toast.toast(context, "尚未实现此功能");
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.settings,size: 23.0),
                          title: Text("修改"),
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