import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ContactModel {
  String name;
  String phone;
  DateTime date;
  Color color;
  XFile? picture;

  ContactModel({
    required this.name,
    required this.phone,
    required this.date,
    required this.color,
    required this.picture,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        name: json["name"] ?? "",
        phone: json["phone"] ?? "",
        date: DateTime.parse(json["date"] ?? "2024-02-29 13:27:00.123456789z"),
        color: Color(json["color"] ?? 0xFF4CAF50),
        picture: json["picture"] != null
            ? json["picture"] != "null"
                ? XFile(json["picture"])
                : null
            : null,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "date": date,
        "color": color.value,
        "picture": picture,
      };

  String toJsonString() =>
      '{"name": "$name","phone": "$phone","date": "$date","color": ${color.value},"picture": "${picture?.path}"}';
}
