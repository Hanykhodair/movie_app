import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/shard/network/remote/api_manager.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiManager.getPopular(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data?.success == false) {
            return const Center(child: Text("error happened"));
          }
          var resultsList = snapshot.data?.results ?? [];
          // print(resultsList[1].title);
          return CarouselSlider.builder(
            itemCount: resultsList.length,
            itemBuilder: (context, index, realIndex) {
              return Stack(children: [
                // const VideoPlayerScreen(),
                // Image.network(
                //     "https://image.tmdb.org/t/p/w500/${resultsList[index].posterPath}"),
                Text(
                  resultsList[index].title ?? "",
                  style: const TextStyle(color: Colors.red),
                )
              ]);
            },
            options: CarouselOptions(
              scrollPhysics: const AlwaysScrollableScrollPhysics(),
              height: 400,
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
        });
  }
}
