// To parse this JSON data, do
//
//     final subjectDetailsModel = subjectDetailsModelFromJson(jsonString);

import 'dart:convert';

SubjectDetailsModel subjectDetailsModelFromJson(String str) =>
    SubjectDetailsModel.fromJson(json.decode(str));

String subjectDetailsModelToJson(SubjectDetailsModel data) =>
    json.encode(data.toJson());

class SubjectDetailsModel {
  int credits;
  int id;
  String name;
  String teacher;

  SubjectDetailsModel({
    required this.credits,
    required this.id,
    required this.name,
    required this.teacher,
  });

  factory SubjectDetailsModel.fromJson(Map<String, dynamic> json) =>
      SubjectDetailsModel(
        credits: json["credits"],
        id: json["id"],
        name: json["name"],
        teacher: json["teacher"],
      );

  Map<String, dynamic> toJson() => {
        "credits": credits,
        "id": id,
        "name": name,
        "teacher": teacher,
      };
}
