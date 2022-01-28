// To parse this JSON data, do
//
//     final equipments = equipmentsFromMap(jsonString);

import 'dart:convert';

class Equipments {
    Equipments({
        this.id,
        this.name,
        this.quantity,
        this.isExpire,
        this.expireDate,
        this.unitId,
        this.isActive,
        this.createdAt,
        this.updatedAt,
    });

    String? id;
    String? name;
    int? quantity;
    bool? isExpire;
    DateTime? expireDate;
    String? unitId;
    bool? isActive;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Equipments.fromJson(String str) => Equipments.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Equipments.fromMap(Map<String, dynamic> json) => Equipments(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        isExpire: json["is_expire"] == null ? null : json["is_expire"],
        expireDate: json["expire_date"] == null ? null : DateTime.parse(json["expire_date"]),
        unitId: json["unit_id"] == null ? null : json["unit_id"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "quantity": quantity == null ? null : quantity,
        "is_expire": isExpire == null ? null : isExpire,
        "expire_date": expireDate == null ? null : "${expireDate!.year.toString().padLeft(4, '0')}-${expireDate!.month.toString().padLeft(2, '0')}-${expireDate!.day.toString().padLeft(2, '0')}",
        "unit_id": unitId == null ? null : unitId,
        "is_active": isActive == null ? null : isActive,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    };
}
