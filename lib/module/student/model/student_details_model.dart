// To parse this JSON data, do
//
//     final studentDetailsModel = studentDetailsModelFromJson(jsonString);

import 'dart:convert';

StudentDetailsModel studentDetailsModelFromJson(String str) =>
    StudentDetailsModel.fromJson(json.decode(str));

String studentDetailsModelToJson(StudentDetailsModel data) =>
    json.encode(data.toJson());

class StudentDetailsModel {
  int age;
  String email;
  int id;
  String name;

  StudentDetailsModel({
    required this.age,
    required this.email,
    required this.id,
    required this.name,
  });

  factory StudentDetailsModel.fromJson(Map<String, dynamic> json) =>
      StudentDetailsModel(
        age: json["age"],
        email: json["email"],
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "age": age,
        "email": email,
        "id": id,
        "name": name,
      };
}
