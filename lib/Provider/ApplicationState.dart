import 'package:flutter/material.dart';
import '../Provider/state_deviceListDisplay.dart';
import 'dart:math';



enum ThemesSet { light, dark }

class AppState with ChangeNotifier {


  bool isDarkTheme=false;

  static final List<ThemeData> themeData=[
    ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Color(0xFFF3F2F8),
        brightness: Brightness.light,
        backgroundColor: Color(0xFFF3F2F8),
        accentColor: Colors.black,
        accentIconTheme: IconThemeData(color: Colors.white),
        dividerColor: Colors.white54),
    ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.black,
        brightness: Brightness.dark,
        backgroundColor: Color(0xFF000000),
        accentColor: Colors.white,
        accentIconTheme: IconThemeData(color: Colors.black),
        dividerColor: Colors.black54
    )
  ];
//
  static int shapeGradientColorIndex=1;
  static final List<List<Color>> shapeGradientColor=[[Color(0xFFF47D15),Color(0xFFEF772C)],[Color(0xFFFB6800),Color(0xFFF9A337)],[Color(0xFF00153E),Color(0xFF00267E)]];

  ThemesSet _currentTheme = ThemesSet.light;
  ThemeData _currentThemeData = themeData[0];

  void switchTheme() => currentTheme == ThemesSet.light
      ? currentTheme = ThemesSet.dark
      : currentTheme = ThemesSet.light;


  void setDayTheme(){
    currentTheme=ThemesSet.light;
    isDarkTheme=false;
    shapeGradientColorIndex=1;
  }
  void setDarkTheme(){
    currentTheme=ThemesSet.dark;
    isDarkTheme=true;
    shapeGradientColorIndex=2;
  }


  set currentTheme(ThemesSet theme) {
    if (theme != null) {
      _currentTheme = theme;
      _currentThemeData =
      currentTheme == ThemesSet.light ? themeData[0] : themeData[1];
      notifyListeners();
    }
  }

  get currentTheme => _currentTheme;
  get currentThemeData => _currentThemeData;

  bool get isDarkModeState => isDarkTheme ? true : false;

  void changeDarkModeState(){
    if(isDarkTheme){
      isDarkTheme=false;
    }else{
      isDarkTheme=true;
    }
  }

  //get getDeviceList=>currentDevice;

  final lightTheme=ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Color(0xFFF2F2F7),
      brightness: Brightness.light,
      backgroundColor: Color(0xFFF2F2F7),
      accentColor: Colors.black,
      accentIconTheme: IconThemeData(color: Colors.white),
      dividerColor: Color(0xFFC8C8CA)
  );

  final darkTheme=ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Color(0xFF1C1C1E),
      brightness: Brightness.dark,
      backgroundColor: Color(0xFF1C1C1E),
      accentColor: Colors.white,
      accentIconTheme: IconThemeData(color: Colors.black),
      dividerColor: Color(0xFF3C3C3F)
  );

  static List<Text> todayInfo=[
    Text('客厅',style: TextStyle(fontSize: 30.0,color: Colors.white,fontWeight: FontWeight.bold)),
    Text('客厅的灯没关。',style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.bold))
  ];

  static String generateRandomString(){
    String alphabet='qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';
    int length = 30;
    String output = '';
    for (int i=0;i<length;++i) {
      output=output+alphabet[Random().nextInt(alphabet.length)];
    }
    return output;
  }

  void switchToLivingRoom(){
    todayInfo=[
      Text('客厅',style: TextStyle(fontSize: 30.0,color: Colors.white,fontWeight: FontWeight.bold)),
      Text('客厅的电视开着。',style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.bold))];
  }

  void switchToKitchen(){
    todayInfo=[
      Text('厨房',style: TextStyle(fontSize: 30.0,color: Colors.white,fontWeight: FontWeight.bold)),
      Text('厨房的抽油烟机开着。',style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.bold)),
    ];
  }

  void switchToBedroom(){
    todayInfo=[
      Text('卧室',style: TextStyle(fontSize: 30.0,color: Colors.white,fontWeight: FontWeight.bold)),
      Text('卧室的 PlayStation 4处于待机状态。',style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.bold))
    ];
  }

  static List<Map<String,Object>> currentDevice=[];
  //Map<String,Object> newDevice={"icon":Icons.devices,"name":"HomePodXT","status":"Running","battery":"60%","imagePath":"assets/images/devices/airconditionera.png","hash":generateRandomString()};

  //static List<Map<String,Object>> currentDevice=[{"deviceId":1,"name":"HomePod1","status":"Running","battery":"60%","image":"https://s3.amazonaws.com/uifaces/faces/twitter/calebogden/128.jpg"}];

  //AppState();
  AppState();

  String _jsonResonse = "";
  bool _isFetching = false;

  ThemeData get getThemeData => isDarkTheme ? lightTheme : darkTheme;

  set setThemeData(bool value){
    if(value){
      isDarkTheme=true;
    }else{
      isDarkTheme=false;
    }
    notifyListeners();
  }

  void addNewDevice(Map<String,Object> newDevice){
    currentDevice.add(newDevice);
    notifyListeners();
  }

  void addNewDevicebyScan(Map<String,Object> newDevice){
    Map<String,Object> temp={"icon":Icons.devices,"name":newDevice['name'],"status":newDevice['status'],"cardColor":lightGrey,"progressBar":42.0,"imagePath":newDevice['imagePath'],"hash":AppState.generateRandomString()};
    currentDevice.add(temp);
    notifyListeners();
  }

  void addNewDeviceTest(){
    currentDevice.add({"icon":Icons.devices,"name":"HomePodXTx","status":"已连接","cardColor":lightGrey,"progressBar":42.0,"imagePath":"assets/images/devices/airconditionera.png","hash":generateRandomString()});
    notifyListeners();
  }

  void addDeviceCleanRobot(){
    currentDevice.add({"icon":Icons.devices,"name":"HomePodXTx","status":"已连接","cardColor":lightGrey,"progressBar":42.0,"imagePath":"assets/images/devices/airconditionera.png","hash":generateRandomString()});
    notifyListeners();
  }

  void setTodayInfo(){
    todayInfo.add(Text('厨房',style: TextStyle(fontSize: 30.0,color: Colors.white,fontWeight: FontWeight.bold)));
    notifyListeners();
  }

  void refreshNow(){
    notifyListeners();
  }

  //String get getDisplayText => _displayText;

  //bool get isFetching => _isFetching;

  /*
  Future<void> fetchData() async {
    _isFetching = true;
    notifyListeners();

    /*
    var response = await http.get(_dataUrl);
    if (response.statusCode == 200) {
      _jsonResonse = response.body;
    }
    */

    _isFetching = false;
    notifyListeners();
  }

   */
  //String get getResponseText => currentDevice;

  List<dynamic> getResponseJson() {
    if (currentDevice.isNotEmpty) {
      //Map<String, dynamic> currentDevice = jsonDecode(_jsonResonse);
      //var testst=currentDevice.length;
      // print(json['data']['avatar']);
      //currentDevice.add({"id":1,"name":"HomePod","status":"Running","battery":"60%","image":"https://s3.amazonaws.com/uifaces/faces/twitter/calebogden/128.jpg"});
      return currentDevice;
    }
    return null;
  }
}
