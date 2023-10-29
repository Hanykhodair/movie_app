import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';

class FirebaseManager {


  static CollectionReference<MovieModel> getMovieCollection() {
    return FirebaseFirestore.instance.collection("Movie").withConverter<
        MovieModel>(fromFirestore: (snapshot, _) {
      return MovieModel.fromJason(snapshot.data()!);
    }, toFirestore: (task, _) {
      return task.toJson();
    },
    );
  }

  static Future<void> addMovie(MovieModel movie) {
    var collection = getMovieCollection();
    var docRef = collection.doc();
    movie.id = docRef.id;
    return docRef.set(movie);
  }

  static Stream<QuerySnapshot<MovieModel>> getMovie(DateTime date) {
    return getMovieCollection().where("date",
        isEqualTo: DateUtils
            .dateOnly(date)
            .millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(String movieId) {
    return getMovieCollection().doc(movieId).delete();
  }


  static Future<void> updateTask(MovieModel movie) {
    return getMovieCollection().doc(movie.id).update({
      "title": movie.title,
      "description": movie.description,
      "date": movie.publishAt
    });
  }


}