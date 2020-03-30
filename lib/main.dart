import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';
import 'Route/ApplicationRouter.dart';
import 'Route/routes.dart';
import 'Provider/ApplicationState.dart';
import 'BottomNavigationView.dart';

void main() {
  Router router=Router();//imp
  Routes.configureRoutes(router);
  ApplicationRouter.router=router;
  runApp(HomeFragment());
}

class HomeFragment extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      //title: 'Flutter bottomNavigationBar',
      //home: BottomNavigationWidget(),
      home: ChangeNotifierProvider<AppState>(
        builder: (_) => AppState(),
        child: BottomNavigationView(),
      ),
    );
  }
}