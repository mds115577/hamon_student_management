// To parse this JSON data, do
//
//     final subjectModel = subjectModelFromJson(jsonString);

import 'dart:convert';

SubjectModel subjectModelFromJson(String str) =>
    SubjectModel.fromJson(json.decode(str));

String subjectModelToJson(SubjectModel data) => json.encode(data.toJson());

class SubjectModel {
  List<Subject> subjects;

  SubjectModel({
    required this.subjects,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) => SubjectModel(
        subjects: List<Subject>.from(
            json["subjects"].map((x) => Subject.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "subjects": List<dynamic>.from(subjects.map((x) => x.toJson())),
      };
}

class Subject {
  int credits;
  int id;
  String name;
  String teacher;

  Subject({
    required this.credits,
    required this.id,
    required this.name,
    required this.teacher,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
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
