import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_app/models/Results.dart';

class FirebaseManager {


  static CollectionReference<Results> getMovieCollection() {
    return FirebaseFirestore.instance.collection("Movie").withConverter<
        Results>(fromFirestore: (snapshot, _) {
      return Results.fromJson
        (snapshot.data()!);
    }, toFirestore: (Movie, _) {
      return Movie.toJson();
    },
    );
  }

  static Future<void> addMovie(Results movie) {
    //Results? result;
    var collection = getMovieCollection();
    var docRef = collection.doc();
    //movie.id = docRef.id as num ;
    return docRef.set(movie);
  }
  static Future<void> deleteMovie(num? id){
    return getMovieCollection().doc(id as String?).delete();
  }

  static Future<void> addedToFavorite(num id, bool isFavorite) {
    return getMovieCollection().doc(id as String?).update({"isAddedToWatchlist": isFavorite});
  }

  static Stream<QuerySnapshot<Results>> getMovie() {
    return getMovieCollection().snapshots();
  }


}