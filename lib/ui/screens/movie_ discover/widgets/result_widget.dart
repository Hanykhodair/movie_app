import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:movie_app/shard/style/colors.dart';
import 'package:movie_app/ui/screens/full_movie_screen/full_movie_screen.dart';

import '../../../../models/Results.dart';

class  ResultWidget extends StatelessWidget {
 Results? result;

   ResultWidget(this.result, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(FullMovieScreen.routeName, arguments: result),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // result?.posterPath != null
          //     ?
          CachedNetworkImage(
            imageUrl: "https://image.tmdb.org/t/p/w500/${result?.backdropPath}",
            height: 89.h,
            width: 140.w,
            fit: BoxFit.fill,
            placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(
                  color: AppColors.yellowColor,
                )),
            errorWidget: (context, url, error) => const Icon(
              Icons.error,
              color: AppColors.yellowColor,
            ),
          ),
          // : const SizedBox(),
          SizedBox(
            width: 15.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  result?.title ?? "",
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  result?.releaseDate ?? "",
                  style: TextStyle(color: Colors.white.withOpacity(.7)),
                ),
                Text(
                  result?.originalTitle ?? "",
                  style: TextStyle(color: Colors.white.withOpacity(.7)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
