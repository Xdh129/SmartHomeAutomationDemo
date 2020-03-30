import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/ApplicationState.dart';
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

class MyCenterPage extends StatefulWidget {
  @override
  _MyCenterPageState createState() => _MyCenterPageState();
}

class _MyCenterPageState extends State<MyCenterPage> with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  bool _isDarkModeChecked;

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
              Text("我的",style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold)),
              SizedBox(
                height: 30.0,
              ),
              Text("设置",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
              Container(
                height: 200.0,
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    SwitchListTile(
                      secondary: Icon(Icons.hotel,size: 23.0),
                      value: appState.isDarkModeState,
                      title: Text("夜间模式"),
                      onChanged: (isDarkModeChecked){
                        //_isDarkModeChecked=isDarkModeChecked;
                        appState.switchTheme();
                        appState.changeDarkModeState();
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.clear_all,size: 23.0),
                      title: Text("清除数据"),
                      onTap: (){

                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.exit_to_app,size: 23.0),
                      title: Text("退出"),
                      onTap: (){
                        exit(0);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

  }
}