import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../models/Results.dart';
import '../../../../shard/style/colors.dart';
import '../full_movie_screen.dart';

class MoreLikeThisWidget extends StatelessWidget {
  List<Results> resultsList;
  bool isAddedToWatchList;

  MoreLikeThisWidget(this.resultsList, this.isAddedToWatchList, {super.key});

  @override
  Widget build(BuildContext context) {
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
                      errorWidget: (context, url, error) => const Icon(
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
                    const Icon(Icons.star, color: AppColors.yellowColor),
                    SizedBox(width: 4.w),
                    Text(resultsList[index].voteAverage.toString(),
                        style: const TextStyle(color: Colors.white))
                  ],
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                resultsList[index].title ?? "",
                style: const TextStyle(
                    color: Colors.white, overflow: TextOverflow.ellipsis),
                maxLines: 1,
              ),
              Text(
                  resultsList[index].releaseDate == "" ||
                          resultsList[index].releaseDate == null
                      ? ""
                      : resultsList[index].releaseDate!.substring(0, 4),
                  style: const TextStyle(color: Colors.white)),
            ],
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 127, crossAxisCount: 1, mainAxisSpacing: 15),
      ),
    );
  }
}
