import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/layout/home_layout.dart';
import 'package:movie_app/ui/screens/full_movie_screen.dart';

import 'layout/home_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 870),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: HomeLayout.routeName,
          routes: {
            HomeLayout.routeName: (context) => const HomeLayout(),
            FullMovieScreen.routeName: (context) => FullMovieScreen(),
          }),
    );
  }
}
