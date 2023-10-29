import 'Results.dart';

class SearchResponse {
  SearchResponse({
    this.page,
    this.results,
    this.status_code,
    this.status_message,
    this.success,
    this.totalPages,
    this.totalResults,
  });

  SearchResponse.fromJson(dynamic json) {
    page = json['page'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
    status_code = json["status_code"];
    status_message = json["status_message"];
    success = json["success"];
  }

  num? page;
  List<Results>? results;
  num? totalPages;
  num? totalResults;
  num? status_code;
  String? status_message;
  bool? success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    map['total_pages'] = totalPages;
    map['total_results'] = totalResults;
    map["status_code"] = status_code;
    map["status_message"] = status_message;
    map["success"] = success;
    return map;
  }
}
