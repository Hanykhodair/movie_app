import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shard/network/remote/api_manager.dart';
import 'package:movie_app/ui/tabs/home/widgets/new_releases_wiget.dart';
import 'package:movie_app/ui/tabs/home/widgets/popular_widget.dart';
import 'package:movie_app/ui/tabs/home/widgets/top_rated_widget.dart';
import '../../../shard/style/colors.dart';
import '../../screens/full_movie_screen.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool isAddedToWatchList = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: FutureBuilder(
              future: ApiManager.getPopular(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: AppColors.yellowColor,
                  ));
                } else if (snapshot.data?.success == false) {
                  return const Center(child: Text("error happened"));
                }
                var resultsList = snapshot.data?.results ?? [];
                return PopularWidget(resultsList, isAddedToWatchList);
              }),
        ),
        SizedBox(height: 20.h),
        Container(
          width: double.infinity,
          color: AppColors.appBarBlack,
          child: Padding(
            padding: const EdgeInsets.only(left: 27.0).r,
            child: Text("New Releases",
                style: TextStyle(color: Colors.white, fontSize: 17.sp)),
          ),
        ),
        Container(color: AppColors.appBarBlack, height: 7.h),
        Expanded(
          flex: 4,
          child: Container(
            color: AppColors.appBarBlack,
            child: FutureBuilder(
              future: ApiManager.getUpcoming(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: AppColors.yellowColor,));
                } else if (snapshot.data?.success == false) {
                  return const Center(child: Text("error happened"));
                }
                var resultsList = snapshot.data?.results ?? [];
                return NewReleasesWidget(resultsList, isAddedToWatchList);
              },
            ),
          ),
        ),
        SizedBox(height: 15.h),
        Container(
          color: AppColors.appBarBlack,
          width: double.infinity,
          child:   Padding(
            padding: const EdgeInsets.only(left: 27.0),
            child: Text("Top Rated",
                style: TextStyle(color: Colors.white, fontSize: 17.sp)),
          ),
        ),
        Container(color: AppColors.appBarBlack, height: 7.h),
        Expanded(
          flex: 6,
          child: Container(
            color: AppColors.appBarBlack,
            child: FutureBuilder(
              future: ApiManager.getTopRated(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: AppColors.yellowColor,));
                } else if (snapshot.data?.success == false) {
                  return const Center(child: Text("error happened"));
                }
                var resultsList = snapshot.data?.results ?? [];
                return TopRatedWidget(resultsList, isAddedToWatchList);
              },
            ),
          ),
        ),
        SizedBox(height: 10.h),
        // Expanded(flex: 2, child: Container())
      ],
    );
  }
}
