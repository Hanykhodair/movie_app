import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../models/Results.dart';
import '../../../../shard/style/colors.dart';
import '../../../screens/full_movie_screen/full_movie_screen.dart';

class TopRatedWidget extends StatelessWidget {
   Results result ;
  bool isAddedToWatchList;

  TopRatedWidget(this.result  , this.isAddedToWatchList, {super.key});

  @override
  Widget build(BuildContext context) {
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
                  arguments: result ,
                );
              },
              child: CachedNetworkImage(
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  color: AppColors.yellowColor,
                ),
                imageUrl:
                    "https://image.tmdb.org/t/p/w500/${result.posterPath}",
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
              Text(result.voteAverage.toString(),
                  style: const TextStyle(color: Colors.white))
            ],
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        Text(
          result.title ?? "",
          style: const TextStyle(
              color: Colors.white, overflow: TextOverflow.ellipsis),
          maxLines: 1,
        ),
        Text(
            result.releaseDate == "" ||
                result.releaseDate == null
                ? "":
            result.releaseDate?.substring(0, 4) ?? "",
            style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
