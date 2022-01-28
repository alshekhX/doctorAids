// To parse this JSON data, do
//
//     final orderDataM = orderDataMFromMap(jsonString);

import 'dart:convert';

class OrderDataM {
    OrderDataM({
        this.id,
        this.doctorId,
        this.departmentId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.department,
        this.doctor,
        this.equipments,
    });

    String? id;
    String? doctorId;
    String? departmentId;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic department;
    Doctor? doctor;
    List<Equipment>? equipments;

    factory OrderDataM.fromJson(String str) => OrderDataM.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory OrderDataM.fromMap(Map<String, dynamic> json) => OrderDataM(
        id: json["id"] == null ? null : json["id"],
        doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
        departmentId: json["department_id"] == null ? null : json["department_id"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        department: json["department"],
        doctor: json["doctor"] == null ? null : Doctor.fromMap(json["doctor"]),
        equipments: json["equipments"] == null ? null : List<Equipment>.from(json["equipments"].map((x) => Equipment.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "doctor_id": doctorId == null ? null : doctorId,
        "department_id": departmentId == null ? null : departmentId,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "department": department,
        "doctor": doctor == null ? null : doctor!.toMap(),
        "equipments": equipments == null ? null : List<dynamic>.from(equipments!.map((x) => x.toMap())),
    };
}

class Doctor {
    Doctor({
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
    dynamic createdAt;
    dynamic updatedAt;

    factory Doctor.fromJson(String str) => Doctor.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Doctor.fromMap(Map<String, dynamic> json) => Doctor(
        id: json["id"] == null ? null : json["id"],
        departmentId: json["department_id"] == null ? null : json["department_id"],
        name: json["name"] == null ? null : json["name"],
        phone: json["phone"] == null ? null : json["phone"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "department_id": departmentId == null ? null : departmentId,
        "name": name == null ? null : name,
        "phone": phone == null ? null : phone,
        "is_active": isActive == null ? null : isActive,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

class Equipment {
    Equipment({
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

    factory Equipment.fromJson(String str) => Equipment.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Equipment.fromMap(Map<String, dynamic> json) => Equipment(
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
