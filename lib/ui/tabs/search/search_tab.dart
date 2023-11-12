import 'package:flutter/material.dart';
import 'package:movie_app/shard/network/remote/api_manager.dart';
import 'package:movie_app/shard/style/colors.dart';
import 'package:movie_app/ui/tabs/search/widgets/resultWidget.dart';

import '../../../models/Results.dart';

class SearchTab extends StatefulWidget {
  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  // List<Results> searchResult = [];

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Column(
        children: [
          TextFormField(
            textInputAction: TextInputAction.search,
            autofocus: true,
            onFieldSubmitted: (value) {
              setState(() {});
            },
            style: const TextStyle(color: Colors.white),
            controller: searchController,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.withOpacity(.35),
              suffixIcon: searchController.text != ""
                  ? IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: () {
                        searchController.clear();
                        setState(() {});
                      },
                    )
                  : SizedBox(),
              prefixIcon: IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {});
                },
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Colors.white, width: .5)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Colors.white, width: .5)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Colors.white, width: .5)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: FutureBuilder(
            future: ApiManager.getMovie(searchController.text),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.yellowColor,
                  ),
                );
              }
              if (snapshot.hasError) {
                return AlertDialog(
                  backgroundColor: Colors.grey.withOpacity(.35),
                  title: Text("Error",style: TextStyle(color: Colors.white),),
                  content: Text("check The Network",style: TextStyle(color: Colors.white)),
                  actions: [
                    ElevatedButton(
                      onPressed: () => setState(() {}),
                      child: Row(
                        children: [
                          Text("Refresh"),
                          Icon(Icons.refresh)
                        ],
                        mainAxisSize: MainAxisSize.min,
                      ),
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.yellowColor),
                    )
                  ],
                );
              }
              var searchResult = snapshot.data?.results ?? [];
              if (searchResult.isEmpty) {
                return Image.asset("assets/images/movie_icon.png");
              }
              return ListView.separated(
                separatorBuilder: (context, index) =>
                    Divider(color: Colors.white.withOpacity(.5)),
                itemCount: searchResult.length,
                itemBuilder: (context, index) {
                  return SearchResultWidget(searchResult[index]);
                },
              );
            },
          ))
        ],
      ),
    );
  }
}
