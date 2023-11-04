import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shard/network/remote/api_manager.dart';
import 'package:movie_app/shard/style/colors.dart';
import 'package:movie_app/ui/screens/widgets/more_like_this_widget.dart';
import '../../models/Results.dart';

class FullMovieScreen extends StatelessWidget {
  static const String routeName = "FullMovieScreen";

  FullMovieScreen({super.key});

  bool isAddedToWatchList = true;

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Results;
    var id = args.id;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            args.title ?? "",
            style: const TextStyle(fontSize: 20),
          ),
          backgroundColor: AppColors.appBarBlack),
      backgroundColor: AppColors.black,
      body: FutureBuilder(
        future: ApiManager.getDetails(id.toString()),
        builder: (context, snapshot) {
          // print(args.posterPath);
          // print(args.backdropPath);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.yellowColor,
            ));
          } else if (snapshot.data?.success == false) {
            return const Center(child: Text("error happened"));
          }
          var resultMovie = snapshot.data;
          return Column(
            children: [
              SizedBox(
                height: 180.h,
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl:
                      "https://image.tmdb.org/t/p/w500/${resultMovie?.backdropPath}",
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
              ),
              SizedBox(height: 15.h),
              Padding(
                padding: const EdgeInsets.only(left: 22),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(resultMovie?.title ?? "",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18)),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text(resultMovie?.releaseDate ?? "",
                        textAlign: TextAlign.start,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18)),
                  ],
                ),
              ),
              SizedBox(height: 25.h),
              Padding(
                padding: const EdgeInsets.only(left: 22),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 199.h,
                          width: 129.w,
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://image.tmdb.org/t/p/w500/${resultMovie?.posterPath}",
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(
                              color: AppColors.yellowColor,
                            )),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                              color: AppColors.yellowColor,
                            ),
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
                              )
                      ],
                    ),
                    Flexible(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              resultMovie?.overview ?? "",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 13),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Icons.star,
                                    color: AppColors.yellowColor),
                                // const SizedBox(width: 10),
                                Text(resultMovie?.voteAverage.toString() ?? "",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18)),
                                // const SizedBox(width: 20),
                                Text(
                                    "Language: (${resultMovie?.originalLanguage ?? ""})",
                                    style: const TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              Expanded(
                child: Container(
                  color: AppColors.appBarBlack,
                  child: FutureBuilder(
                    future: ApiManager.getSimilar(id.toString()),
                    builder: (context, snapshot) {
                      // print(id);
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: AppColors.yellowColor,
                        ));
                      } else if (snapshot.data?.success == false) {
                        return const Center(child: Text("error happened"));
                      }
                      var resultsList = snapshot.data?.results ?? [];
                      return MoreLikeThisWidget(
                          resultsList, isAddedToWatchList);
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
