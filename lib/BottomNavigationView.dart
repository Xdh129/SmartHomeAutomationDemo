import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/ApplicationState.dart';
import 'Pages/HomePage.dart';
import 'Pages/DeviceLibraryPage.dart';
import 'Pages/ShortcutLibraryPage.dart';
import 'Pages/MyCenterPage.dart';

class BottomNavigationView extends StatefulWidget {
  @override
  _BottomNavigationViewState createState() => _BottomNavigationViewState();
}

class _BottomNavigationViewState extends State<BottomNavigationView> with SingleTickerProviderStateMixin {

  final _bottomNavigationColor = Colors.blue;
  int _currentIndex = 0;
  var _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return MaterialApp(
      //title: 'Flutter bottomNavigationBar',
        theme: appState.currentThemeData,//new ThemeData.dark(),
        //home: BottomNavigationWidget(),
        home: Scaffold(
          //backgroundColor: Color(0xFF323232),
          body: PageView(
            controller: _controller,
            children: <Widget>[
              HomePage(),
              DeviceLibraryPage(),
              ShortcutLibraryPage(),
              MyCenterPage()
            ],
            physics: NeverScrollableScrollPhysics(),
          ),
          bottomNavigationBar: BottomNavigationBar(
            //elevation: 150.0,
            currentIndex: _currentIndex,

            /*
          onTap: (index){
            //_controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
            return _controller.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.linearToEaseOut);
          },

           */

            onTap: (index) {
              _controller.jumpToPage(index);
              setState(() {
                _currentIndex = index;
              });
            },

            type: BottomNavigationBarType.shifting,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.grey,
                ),
                title: Text(
                  '首页',
                  style: TextStyle(color: _bottomNavigationColor,fontSize: 13.0),
                ),
                activeIcon: Icon(
                  Icons.home,
                  color: _bottomNavigationColor,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.laptop_mac,
                  color: Colors.grey,
                ),
                title: Text(
                  '设备库',
                  style: TextStyle(color: _bottomNavigationColor,fontSize: 13.0),
                ),
                activeIcon: Icon(
                  Icons.laptop_mac,
                  color: _bottomNavigationColor,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.touch_app,
                  color: Colors.grey,
                ),
                title: Text(
                  '快捷操作',
                  style: TextStyle(color: _bottomNavigationColor,fontSize: 13.0),
                ),
                activeIcon: Icon(
                  Icons.touch_app,
                  color: _bottomNavigationColor,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_box,
                  color: Colors.grey,
                ),
                title: Text(
                  '我的',
                  style: TextStyle(color: _bottomNavigationColor,fontSize: 13.0),
                ),
                activeIcon: Icon(
                  Icons.account_box,
                  color: _bottomNavigationColor,
                ),
              ),
            ],
          ),
        )
    );
  }
}
