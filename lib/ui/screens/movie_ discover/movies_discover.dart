import 'package:flutter/material.dart';
import 'package:movie_app/shard/network/remote/api_manager.dart';
import 'package:movie_app/ui/screens/movie_%20discover/widgets/result_widget.dart';

import '../../../models/MoviesListResponsel.dart';
import '../../../shard/style/colors.dart';

class MovieDiscoverScreen extends StatelessWidget {
  static const String routName = "MovieDiscoverScreen";

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Genres;
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
          elevation: 1,
          title: Text(
            args.name ?? "",
            style: const TextStyle(fontSize: 20),
          ),
          backgroundColor: AppColors.appBarBlack),
      body: FutureBuilder(
        future: ApiManager.getMovieDiscover(args.id.toString() ?? ""),
        builder: (context, snapshot) {
          print(args.id);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.yellowColor,
            ));
          }
          var response = snapshot.data?.results ?? [];
          print(response);
          return ListView.separated(
            itemBuilder: (context, index) => ResultWidget(response[index]),
            itemCount: response.length,
            separatorBuilder: (BuildContext context, int index) =>
                Divider(color: Colors.white.withOpacity(.5)),
          );
        },
      ),
    );
  }
}
