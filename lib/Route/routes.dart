import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'router_handler.dart';

class Routes{
  static String root='/';
  static String detailsPage='/detail';
  static String enterDeviceLibrary='/enter';
  static String detailsLibraryPage='/detailDeviceLibrary';
  static String detailsShortcutPage='/detailShortcutLibrary';
  //static String Sydney='Sydney';
  static void configureRoutes(Router router){
    router.notFoundHandler=new Handler(
        handlerFunc: (BuildContext context,Map<String,List<String>> params){
          print('ERROR');
        }
    );
    router.define(detailsPage, handler: deviceControlHandler);
    router.define(enterDeviceLibrary, handler: enterDeviceLibraryHandler);
    router.define(detailsLibraryPage, handler: deviceLibraryHandler);
    router.define(detailsShortcutPage, handler: shortcutLibraryHandler);

    //router.define(detailsPage, handler: deviceLibraryHandler);
    //router.define(Sydney, handler: Handler(handlerFunc: (context,params)=>prefix0.Sydney()));

  }
}