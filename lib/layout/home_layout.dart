import 'package:flutter/material.dart';
import 'package:movie_app/shard/network/remote/api_manager.dart';
import 'package:movie_app/shard/style/colors.dart';

class HomeLayout extends StatelessWidget {
  static const String routeName = 'homeLayout';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    extendBody: true,
    backgroundColor: Colors.black,
    bottomNavigationBar: BottomAppBar(
    color: Colors.black,
    child:
    BottomNavigationBar(
    backgroundColor: Colors.black,
    onTap: (value) {

    },
    items: [

    ],
    ),
    ),
 
    );
  }
}
