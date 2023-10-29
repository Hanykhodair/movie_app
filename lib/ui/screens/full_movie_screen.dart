import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/shard/network/remote/api_manager.dart';
import 'package:movie_app/shard/style/colors.dart';
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data?.success == false) {
            return const Center(child: Text("error happened"));
          }
          var resultMovie = snapshot.data;
          return Column(
            children: [
              SizedBox(
                height: 180,
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
              const SizedBox(height: 15),
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
                    const SizedBox(height: 10),
                    Text(resultMovie?.releaseDate?.substring(0, 4) ?? "",
                        textAlign: TextAlign.start,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18)),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 22),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 199,
                          width: 129,
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://image.tmdb.org/t/p/w500/${resultMovie?.posterPath ?? ""}",
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
                                Text(resultMovie!.voteAverage.toString(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18)),
                                // const SizedBox(width: 20),
                                Text(
                                    "Language: (${resultMovie.originalLanguage})",
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
              const SizedBox(height: 15),
              Expanded(
                child: Container(
                  color: AppColors.appBarBlack,
                  child: FutureBuilder(
                    future: ApiManager.getSimilar(id.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.data?.success == false) {
                        return const Center(child: Text("error happened"));
                      }
                      var resultsList = snapshot.data?.results ?? [];
                      return Padding(
                        padding: const EdgeInsets.only(left: 27),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("More Like This",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 15),
                            Expanded(
                              child: GridView.builder(
                                itemCount: resultsList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Stack(
                                          alignment: Alignment.topLeft,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.of(context).pushNamed(
                                                  FullMovieScreen.routeName,
                                                  arguments: resultsList[index],
                                                );
                                              },
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "https://image.tmdb.org/t/p/w500/${resultsList[index].posterPath ?? ""}",
                                                // height: 89,
                                                // width: 140,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    const Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                  color: AppColors.yellowColor,
                                                )),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(
                                                  Icons.error,
                                                  color: AppColors.yellowColor,
                                                ),
                                              ),
                                            ),
                                            isAddedToWatchList
                                                ? const Icon(
                                                    Icons.bookmark_added,
                                                    color:
                                                        AppColors.yellowColor,
                                                    size: 36,
                                                  )
                                                : const Icon(
                                                    Icons.bookmark_add_rounded,
                                                    color: Colors.grey,
                                                    size: 36,
                                                  ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            const Icon(Icons.star,
                                                color: AppColors.yellowColor),
                                            const SizedBox(width: 4),
                                            Text(
                                                resultsList[index]
                                                    .voteAverage
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                    color: Colors.white))
                                          ],
                                        ),
                                      ),
                                      Text(resultsList[index].title ?? "",
                                          style: const TextStyle(
                                              color: Colors.white)),
                                      Text(
                                          resultsList[index]
                                                  .releaseDate
                                                   ??
                                              "",
                                          style: const TextStyle(
                                              color: Colors.white)),
                                    ],
                                  );
                                },
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisExtent: 127,
                                        crossAxisCount: 1,
                                        mainAxisSpacing: 15),
                              ),
                            ),
                          ],
                        ),
                      );
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
