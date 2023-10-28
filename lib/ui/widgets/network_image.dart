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
    );
  }
}
