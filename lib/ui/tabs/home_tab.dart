import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shard/network/remote/api_manager.dart';
import '../../shard/style/colors.dart';
import '../screens/full_movie_screen.dart';

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
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.data?.success == false) {
                  return const Center(child: Text("error happened"));
                }
                var resultsList = snapshot.data?.results ?? [];
                return CarouselSlider.builder(
                  itemCount: resultsList.length,
                  itemBuilder: (context, index, realIndex) {
                    return Stack(
                      children: [
                        CachedNetworkImage(
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fitHeight,
                          imageUrl:
                              "https://image.tmdb.org/t/p/w500/${resultsList[index].backdropPath}",
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            color: AppColors.yellowColor,
                          ),
                        ),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // const VideoPlayerScreen(),
                              Stack(
                                // alignment: Alignment.topLeft,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          FullMovieScreen.routeName,
                                          arguments: resultsList[index],
                                        );
                                      },
                                      child: Image.network(
                                        "https://image.tmdb.org/t/p/w500/${resultsList[index].posterPath}",
                                        height: 199.h,
                                        width: 129.w,
                                        fit: BoxFit.fitWidth,
                                      )),
                                  isAddedToWatchList
                                      ? const Icon(
                                          Icons.bookmark_added,
                                          color: AppColors.yellowColor,
                                          size: 60,
                                        )
                                      : const Icon(
                                          Icons.bookmark_add_rounded,
                                          color: Colors.grey,
                                          size: 60,
                                        ),
                                ],
                              ),
                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      resultsList[index].title ?? "",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      resultsList[index].releaseDate ?? "",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ]),
                      ],
                    );
                  },
                  options: CarouselOptions(
                    scrollPhysics: const FixedExtentScrollPhysics(),
                    height: MediaQuery.of(context).size.height * 0.33,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: false,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  ),
                );
              }),
        ),
        SizedBox(height: 20.h),
        Container(
          width: double.infinity,
          color: AppColors.appBarBlack,
          child: const Padding(
            padding: EdgeInsets.only(left: 27.0),
            child: Text("New Releases",
                style: TextStyle(color: Colors.white, fontSize: 15)),
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
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.data?.success == false) {
                  return const Center(child: Text("error happened"));
                }
                var resultsList = snapshot.data?.results ?? [];
                return Padding(
                  padding: const EdgeInsets.only(left: 27),
                  child: GridView.builder(
                    itemCount: resultsList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Stack(
                        // alignment: Alignment.topLeft,
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  FullMovieScreen.routeName,
                                  arguments: resultsList[index],
                                );
                              },
                              child: Image.network(
                                "https://image.tmdb.org/t/p/w500/${resultsList[index].posterPath}",
                                // height: 127.74.h,
                                // width: 96.87.w,
                                fit: BoxFit.fitWidth,
                              )),
                          isAddedToWatchList
                              ? const Icon(
                                  Icons.bookmark_added,
                                  color: AppColors.yellowColor,
                                  size: 36,
                                )
                              : const Icon(
                                  Icons.bookmark_add_rounded,
                                  color: Colors.grey,
                                  size: 36,
                                ),
                        ],
                      );
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 127,
                            crossAxisCount: 1,
                            childAspectRatio: 100 / 127,
                            mainAxisSpacing: 15),
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(height: 15.h),
        Container(
          color: AppColors.appBarBlack,
          width: double.infinity,
          child: const Padding(
            padding: EdgeInsets.only(left: 27.0),
            child: Text("Top Rated",
                style: TextStyle(color: Colors.white, fontSize: 15)),
          ),
        ),
        Container(color: AppColors.appBarBlack, height: 7),
        Expanded(
          flex: 6,
          child: Container(
            color: AppColors.appBarBlack,
            child: FutureBuilder(
              future: ApiManager.getTopRated(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.data?.success == false) {
                  return const Center(child: Text("error happened"));
                }
                var resultsList = snapshot.data?.results ?? [];
                return Padding(
                  padding: const EdgeInsets.only(left: 27),
                  child: GridView.builder(
                    itemCount: resultsList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            // alignment: Alignment.topLeft,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    FullMovieScreen.routeName,
                                    arguments: resultsList[index],
                                  );
                                },
                                child: CachedNetworkImage(
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error,
                                    color: AppColors.yellowColor,
                                  ),

                                  imageUrl:
                                      "https://image.tmdb.org/t/p/w500/${resultsList[index].posterPath}",
                                  height: 177.74.h,
                                  width: 136.87.w,
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                    color: AppColors.yellowColor,
                                  )),
                                ),
                              ),
                              isAddedToWatchList
                                  ? const Icon(
                                      Icons.bookmark_added,
                                      color: AppColors.yellowColor,
                                      size: 36,
                                    )
                                  : const Icon(
                                      Icons.bookmark_add_rounded,
                                      color: Colors.grey,
                                      size: 36,
                                    ),
                            ],
                          ),
                          Flexible(
                            child: Row(
                              children: [
                                const Icon(Icons.star,
                                    color: AppColors.yellowColor),
                                SizedBox(width: 4.w),
                                Text(resultsList[index].voteAverage.toString(),
                                    style: const TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                          SizedBox(height: 1.h,),
                          Text(resultsList[index].title ?? "",
                              style: const TextStyle(color: Colors.white,overflow: TextOverflow.ellipsis),
                          maxLines: 1,
                          ),
                          Text(
                              resultsList[index].releaseDate?.substring(0, 4) ??
                                  "",
                              style: const TextStyle(color: Colors.white)),
                        ],
                      );
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 127,
                            crossAxisCount: 1,
                            mainAxisSpacing: 15),
                  ),
                );
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
