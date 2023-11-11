import 'package:flutter/material.dart';
import 'package:movie_app/shard/network/remote/api_manager.dart';
import 'package:movie_app/shard/style/colors.dart';
import 'package:movie_app/ui/tabs/search/search_tab.dart';
import 'package:movie_app/ui/tabs/watch_list_tab.dart';

import '../ui/tabs/brows/brows_tab.dart';
import '../ui/tabs/home/home_tab.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = 'homeLayout';

  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      const HomeTab(),
      SearchTab(),
      const BrowseTab(),
      const WatchListTab()
    ];
    return Scaffold(
        body: SafeArea(child: tabs[index]),
        extendBody: true,
        backgroundColor: Colors.black,
        bottomNavigationBar: Theme(
          data: ThemeData(canvasColor: AppColors.appBarBlack),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            elevation: 5,
            currentIndex: index,
            backgroundColor: Colors.transparent,
            selectedItemColor: const Color(0XFFFFBB3B),
            onTap: (value) {
              index = value;
              setState(() {});
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: "Search"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.movie_sharp), label: "Movies"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.save), label: "Watch List"),
            ],
          ),
        ));
  }
}
