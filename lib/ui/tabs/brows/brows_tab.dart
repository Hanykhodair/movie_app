import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/models/MoviesListResponsel.dart';
import 'package:movie_app/shard/network/remote/api_manager.dart';
import 'package:movie_app/ui/tabs/brows/widgets/brows_tab_item.dart';

import '../../../models/MovieDiscoverResponse.dart';
import '../../../shard/style/colors.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({super.key});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Browse Category",
            style: TextStyle(
                color: Colors.white,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.h,),
          Expanded(
            child: FutureBuilder(
              future: ApiManager.getMoviesList(),
              builder: (context, snapshot)  {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: AppColors.yellowColor,
                  ));
                } else if (snapshot.hasError) {
                  return AlertDialog(
                    backgroundColor: Colors.grey.withOpacity(.35),
                    title: Text(
                      "Error",
                      style: TextStyle(color: Colors.white),
                    ),
                    content: Text("check The Network",
                        style: TextStyle(color: Colors.white)),
                    actions: [
                      ElevatedButton(
                        onPressed: () => setState(() {}),
                        child: Row(
                          children: [Text("Refresh"), Icon(Icons.refresh)],
                          mainAxisSize: MainAxisSize.min,
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.yellowColor),
                      )
                    ],
                  );
                }
                var response = snapshot.data?.genres ?? [];
                return GridView.builder(
                  itemBuilder: (context, index) =>
                      BrowsTabItem(response[index]),
                  itemCount: response.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 14.w,
                      mainAxisSpacing: 16.h,
                      childAspectRatio: 4/3,
                      crossAxisCount: 2),
                );
              },
            ),
          )
        ],
      ),
    );
  }

}
