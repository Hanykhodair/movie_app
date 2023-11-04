import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../models/Results.dart';
import '../../../../shard/style/colors.dart';
import '../../../screens/full_movie_screen.dart';

class NewReleasesWidget extends StatelessWidget {
  List<Results> resultsList;

  NewReleasesWidget(this.resultsList, this.isAddedToWatchList, {super.key});

  bool isAddedToWatchList;
  @override
  Widget build(BuildContext context) {
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
                  child: CachedNetworkImage(
                    placeholder: (context, url) =>
                    const Center(
                        child:
                        CircularProgressIndicator(
                          color: AppColors.yellowColor,
                        )),
                    imageUrl:
                    "https://image.tmdb.org/t/p/w500/${resultsList[index].posterPath}",
                    fit: BoxFit.fitWidth,
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                    height: 177.74.h,
                    width: 136.87.w,
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
  }
}
