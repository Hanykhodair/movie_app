import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/shard/network/remote/api_manager.dart';
import '../../video_player.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
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
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://image.tmdb.org/t/p/w500/${resultsList[index].posterPath}"),
                            fit: BoxFit.fill)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // const VideoPlayerScreen(),
                          Image.network(
                              "https://image.tmdb.org/t/p/w500/${resultsList[index].posterPath}",
                              width: 129,
                              height: 199),
                          Text(
                            resultsList[index].title ?? "",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                          Text(
                            resultsList[index].releaseDate ?? "",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                        ]),
                  );
                },
                options: CarouselOptions(
                  scrollPhysics: const AlwaysScrollableScrollPhysics(),
                  height: MediaQuery.of(context).size.height * 0.4,
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
            }),
        const Text("New Releases"),
        FutureBuilder(
          future: ApiManager.getUpcoming(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.data?.success == false) {
              return const Center(child: Text("error happened"));
            }
            var resultsList = snapshot.data?.results ?? [];
            return Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    width: 97,
                    height: 127,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: NetworkImage(
                          "https://image.tmdb.org/t/p/w500/${resultsList[index].posterPath}"),
                    )),
                  );
                },
              ),
            );
          },
        )
      ],
    );
  }
}
