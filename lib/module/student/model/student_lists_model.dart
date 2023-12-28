// To parse this JSON data, do
//
//     final studentListModel = studentListModelFromJson(jsonString);

import 'dart:convert';

StudentListModel studentListModelFromJson(String str) =>
    StudentListModel.fromJson(json.decode(str));

String studentListModelToJson(StudentListModel data) =>
    json.encode(data.toJson());

class StudentListModel {
  List<Student> students;

  StudentListModel({
    required this.students,
  });

  factory StudentListModel.fromJson(Map<String, dynamic> json) =>
      StudentListModel(
        students: List<Student>.from(
            json["students"].map((x) => Student.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "students": List<dynamic>.from(students.map((x) => x.toJson())),
      };
}

class Student {
  int age;
  String email;
  int id;
  String name;

  Student({
    required this.age,
    required this.email,
    required this.id,
    required this.name,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
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
