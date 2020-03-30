import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../Pages/DeviceControlPage.dart';
import '../Pages/DeviceLibraryPage.dart';
import '../Pages/DeviceLibraryDetailPage.dart';
import '../Pages/ShortcutLibraryDetailPage.dart';

Handler deviceControlHandler=Handler(
    handlerFunc: (BuildContext context,Map<String,List<String>> params){
      String mapValueJson=params['mapValueJson']?.first;
      return DeviceControlPage(mapValueJson);
    }
);

Handler enterDeviceLibraryHandler=Handler(
    handlerFunc: (BuildContext context,Map<String,List<String>> params){
      return DeviceLibraryPage();
    }
);


Handler deviceLibraryHandler=Handler(
    handlerFunc: (BuildContext context,Map<String,List<String>> params){
      String mapValueJson=params['mapValueJson']?.first;
      return DeviceLibraryDetailPage(mapValueJson);
    }
);

Handler shortcutLibraryHandler=Handler(
    handlerFunc: (BuildContext context,Map<String,List<String>> params){
      String mapValueJson=params['mapValueJson']?.first;
      return ShortcutLibraryDetailPage(mapValueJson);
    }
);