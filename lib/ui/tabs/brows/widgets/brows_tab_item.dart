import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/models/MoviesListResponsel.dart';

import '../../../screens/movie_ discover/movies_discover.dart';

class BrowsTabItem extends StatelessWidget {
  Genres genres;

  BrowsTabItem(this.genres);

  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, MovieDiscoverScreen.routName,
          arguments: genres),
      child: Stack(
        // fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child:Image.asset("assets/images/OIP.jpg",  height: 150.h,
              width: 218.w,
              fit: BoxFit.fill,),
          ),
          Text(
            genres.name ?? "",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 16.sp),
          )
        ],
      ),
    );
  }
}
