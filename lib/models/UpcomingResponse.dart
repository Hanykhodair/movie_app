import 'Results.dart';

class UpcomingResponse {
  UpcomingResponse({
    this.dates,
    this.page,
    this.results,
    this.status_code,
    this.status_message,
    this.success,
    this.totalPages,
    this.totalResults,
  });

  UpcomingResponse.fromJson(dynamic json) {
    dates = json['dates'] != null ? Dates.fromJson(json['dates']) : null;
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
  Dates? dates;
  num? page;
  List<Results>? results;
  num? totalPages;
  num? totalResults;
  num? status_code;
  String? status_message;
  bool? success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (dates != null) {
      map['dates'] = dates?.toJson();
    }
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

class Dates {
  Dates({
    this.maximum,
    this.minimum,
  });

  Dates.fromJson(dynamic json) {
    maximum = json['maximum'];
    minimum = json['minimum'];
  }
  String? maximum;
  String? minimum;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['maximum'] = maximum;
    map['minimum'] = minimum;
    return map;
  }
}
