import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/layout/home_layout.dart';
import 'package:movie_app/ui/screens/full_movie_screen/full_movie_screen.dart';
import 'package:movie_app/ui/screens/movie_%20discover/movies_discover.dart';

import 'firebase_options.dart';

// ...



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,


  );
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
            MovieDiscoverScreen.routName:(context) => MovieDiscoverScreen()
          }),
    );
  }
}
