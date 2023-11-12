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
  static Future<void> deleteMovie(String? title)async{
    var responce=await getMovieCollection().where('title',isEqualTo:title).get();
    responce.docs[0].reference.delete();
  }

 static Future<bool> doesMovieExist(String? name) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('Movie')
        .where('title', isEqualTo: name)
        .limit(1)
        .get();
    final List<DocumentSnapshot> documents = result.docs;

    return documents.length == 1;
  }




  static Stream<QuerySnapshot<Results>> getMovie() {
    return getMovieCollection().snapshots();
  }


}