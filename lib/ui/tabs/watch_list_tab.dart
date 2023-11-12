import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shard/network/firebase/firebase_manager.dart';
import 'package:movie_app/ui/tabs/search/widgets/resultWidget.dart';

import '../../models/Results.dart';

class WatchListTab extends StatelessWidget {
  const WatchListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder(
            stream: FirebaseManager.getMovie(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text("something error"),
                );
              }
              List<Results> resultMovies =
                  snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
              return ListView.separated(
                itemBuilder: (context, index) {
                  return SearchResultWidget(resultMovies[index]);
                },
                itemCount: resultMovies.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 15.h,
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
