import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ApplicationState.dart';
import '../Route/ApplicationRouter.dart';
import 'dart:convert';

var lightGrey = Color(0xFF414350);
var lightBlue = Color(0xFF5157c2);
const TextStyle dropDownLabelStyle=TextStyle(color: Colors.white,fontSize: 16.0,fontWeight: FontWeight.bold);
const TextStyle dropDownMenuItemStyle=TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold);
var viewAllStyle=TextStyle(fontSize: 14.0,color: Color(0xFFF3791A));

class DeviceListDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(width: 16.0),
              Text("我的设备",style: dropDownMenuItemStyle),
              Spacer(),
              Text("查看全部",style: TextStyle(fontSize: 14.0,color: Color(0xFFF3791A)))
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: appState.getResponseJson() != null
              ? GridView.builder(
              primary:false,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 2.0,crossAxisSpacing: 8.0,mainAxisSpacing: 8.0),
              itemCount: AppState.currentDevice.length,
              itemBuilder: (context,index){
                //return DeviceCard('2', 'HomePodX', 'Running', '60%', 'https://s3.amazonaws.com/uifaces/faces/twitter/calebogden/128.jpg');
                return DeviceCard(AppState.currentDevice[index]['icon'],AppState.currentDevice[index]['name'], AppState.currentDevice[index]['status'], AppState.currentDevice[index]['cardColor'], AppState.currentDevice[index]['progressBar'],AppState.currentDevice[index]['imagePath'],AppState.currentDevice[index]['hash']);
              })
              : Text("当前尚未添加设备~"),
        ),
      ],
    );
  }
}

class DeviceCard extends StatelessWidget{

  final icon,name,status,cardColor,progressBar,imagePath,hash;

  DeviceCard(this.icon,this.name,this.status,this.cardColor,this.progressBar,this.imagePath,this.hash);

  @override
  Widget build(BuildContext context) {

    Map<String,Object> mapValue={"deviceName":name,"status":status,"imagePath":imagePath,"hash":hash};
    String mapValueString=json.encode(mapValue);
    var mapValueJson = jsonEncode(Utf8Encoder().convert(mapValueString));

    return InkWell(
      onTap: (){
        ApplicationRouter.router.navigateTo(context, '/detail?mapValueJson=${mapValueJson}',transition: TransitionType.cupertino);
      },
      child: Hero(
        tag: '${hash}DeviceControl',
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
          elevation: 6.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              height: 40.0,
              color: cardColor,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                icon,
                                color: Colors.white,
                                size: 25.0,
                              ),
                              SizedBox(
                                width: 18.0,
                              ),
                              Text(
                                status,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            name,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                letterSpacing: 1.2),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 4.0,
                      width: progressBar,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [lightBlue, Colors.purple],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}