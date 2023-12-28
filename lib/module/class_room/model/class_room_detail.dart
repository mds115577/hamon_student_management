// To parse this JSON data, do
//
//     final classRoomDetailsModel = classRoomDetailsModelFromJson(jsonString);

import 'dart:convert';

ClassRoomDetailsModel classRoomDetailsModelFromJson(String str) =>
    ClassRoomDetailsModel.fromJson(json.decode(str));

String classRoomDetailsModelToJson(ClassRoomDetailsModel data) =>
    json.encode(data.toJson());

class ClassRoomDetailsModel {
  int id;
  String layout;
  String name;
  int size;
  String subject;

  ClassRoomDetailsModel({
    required this.id,
    required this.layout,
    required this.name,
    required this.size,
    required this.subject,
  });

  factory ClassRoomDetailsModel.fromJson(Map<String, dynamic> json) =>
      ClassRoomDetailsModel(
        id: json["id"],
        layout: json["layout"],
        name: json["name"],
        size: json["size"],
        subject: json["subject"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "layout": layout,
        "name": name,
        "size": size,
        "subject": subject,
      };
}
