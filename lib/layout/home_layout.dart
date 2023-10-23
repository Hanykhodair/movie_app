import 'package:flutter/material.dart';
import 'package:movie_app/shard/network/remote/api_manager.dart';
import 'package:movie_app/shard/style/colors.dart';

class HomeLayout extends StatelessWidget {
  static const String routeName = 'homeLayout';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: black,
      body: FutureBuilder(
        future: ApiManager.getPopular(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
                child: Text(
              "error",
              style: TextStyle(color: Colors.white),
            ));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.amber,
            ));
          }
          var movies = snapshot.data?.results ?? [];
          return ListView.builder(
            itemBuilder: (context, index) {
              return Text(
                movies[index].title ?? "",
                style: const TextStyle(color: Colors.white),
              );
            },
            itemCount: movies.length,
          );
        },
      ),
    );
  }
}
