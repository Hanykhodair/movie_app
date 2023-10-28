import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/shard/network/remote/api_manager.dart';
import '../../shard/style/colors.dart';

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
          flex: 4,
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
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.99,
                      height: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://image.tmdb.org/t/p/w500/${resultsList[index].posterPath}"),
                              fit: BoxFit.cover)),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // const VideoPlayerScreen(),
                            Stack(
                              // alignment: Alignment.topLeft,
                              children: [
                                Image.network(
                                  "https://image.tmdb.org/t/p/w500/${resultsList[index].posterPath}",
                                  height: 199,
                                  width: 129,
                                  fit: BoxFit.fitWidth,
                                ),
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
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(left: 27.0),
          child: Text("New Releases",
              style: TextStyle(color: Colors.white, fontSize: 15)),
        ),
        const SizedBox(height: 13),
        Expanded(
          flex: 3,
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
                        Image.network(
                          "https://image.tmdb.org/t/p/w500/${resultsList[index].posterPath}",
                          // height: 199,
                          // width: 129,
                          fit: BoxFit.fitWidth,
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
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 127,
                      crossAxisCount: 1,
                      childAspectRatio: 100 / 127,
                      mainAxisSpacing: 15),
                ),
              );
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 27.0),
          child: Text("Top Rated",
              style: TextStyle(color: Colors.white, fontSize: 15)),
        ),
        const SizedBox(height: 13),
        Expanded(
          flex: 5,
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
                      children: [
                        Stack(
                          // alignment: Alignment.topLeft,
                          children: [
                            Image.network(
                              "https://image.tmdb.org/t/p/w500/${resultsList[index].posterPath}",
                              // height: 199,
                              // width: 129,
                              fit: BoxFit.fitWidth,
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
                        Row(
                          children: [
                            const Icon(Icons.star,
                                color: AppColors.yellowColor),
                            const SizedBox(width: 4),
                            Text(resultsList[index].voteAverage.toString(),
                                style: const TextStyle(color: Colors.white))
                          ],
                        ),
                        Text(resultsList[index].title ?? "",
                            style: const TextStyle(color: Colors.white)),
                        Text(
                            resultsList[index].releaseDate?.substring(0, 4) ??
                                "",
                            style: const TextStyle(color: Colors.white)),
                      ],
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 127,
                      crossAxisCount: 1,
                      mainAxisSpacing: 15),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
