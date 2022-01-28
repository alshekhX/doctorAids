// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

class User {
    User({
        this.id,
        this.departmentId,
        this.name,
        this.phone,
        this.isActive,
        this.createdAt,
        this.updatedAt,
    });

    String? id;
    String? departmentId;
    String? name;
    String? phone;
    bool? isActive;
    DateTime? createdAt;
    DateTime ?updatedAt;

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        departmentId: json["department_id"] == null ? null : json["department_id"],
        name: json["name"] == null ? null : json["name"],
        phone: json["phone"] == null ? null : json["phone"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "department_id": departmentId == null ? null : departmentId,
        "name": name == null ? null : name,
        "phone": phone == null ? null : phone,
        "is_active": isActive == null ? null : isActive,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    };
}
