import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../models/Results.dart';
import '../../../../shard/style/colors.dart';
import '../../../screens/full_movie_screen/full_movie_screen.dart';

class PopularWidget extends StatelessWidget {
  List<Results> resultsList;

  bool isAddedToWatchList;

  PopularWidget(this.resultsList, this.isAddedToWatchList, {super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: resultsList.length,
      itemBuilder: (context, index, realIndex) {
        return Stack(
          children: [
            CachedNetworkImage(
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator(color: AppColors.yellowColor)),
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
                          child: CachedNetworkImage(
                            placeholder: (context, url) =>
                                const Center(
                                  child: CircularProgressIndicator(
                                      color: AppColors.yellowColor),
                                ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            imageUrl:
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
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
