import 'package:flutter/material.dart';

import '../../shard/style/colors.dart';

class ImageNetwork extends StatelessWidget {
  String path;
  bool isAddedToWatchList;
  ImageNetwork(this.path, this.isAddedToWatchList, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Image.network("https://image.tmdb.org/t/p/w500/$path",
            width: 129, height: 199),
        Icon(Icons.bookmark,
            color: isAddedToWatchList ? AppColors.yellowColor : Colors.grey,
            size: 60),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 17),
          child: Icon(isAddedToWatchList ? Icons.done : Icons.add,
              color: Colors.white),
        )
      ],
    );
  }
}
