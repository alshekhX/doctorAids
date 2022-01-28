import 'package:docttors_aids/models/Equipment.dart';
import 'package:docttors_aids/models/OrderDataM.dart';
import 'package:flutter/widgets.dart';

import '../models/User.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class AuthProvider with ChangeNotifier {
  User? user;
  String? token;
  List? equipments;
  List? orders;

  BaseOptions options = new BaseOptions(
    baseUrl: "http://192.168.43.250:3333",
    connectTimeout: 15000,
    receiveTimeout: 15000,
    contentType: 'application/json',
    validateStatus: (status) {
      return status! < 600;
    },
  );

  signIN(String phone, String password) async {
    try {
      var dio = Dio(options);
      final url = '/api/auth/doctor/login';
      print('$password' + 'what');

      Response response = await dio.post(url, data: {
        "phone": phone,
        "password": password,
      });
      print(response.data);
      if (response.statusCode == 200) {
        token = response.data['token'];
        final data = response.data['doctor'];
        user = User.fromMap(data);
        print(token);
        print(user);

        return 'success';
      } else {
        print(response.data);
        return 'f';
      }
    } catch (e) {
      return e.toString();
    }
  }

  getEquipments() async {
    try {

    Dio dio = Dio(options);
    dio.options.headers["authorization"] = 'Bearer $token';

    Response response = await dio.get("/api/equipments");
    if (response.statusCode == 200) {
      final map = response.data;

      equipments = map.map((i) => Equipments.fromMap(i)).toList();
      notifyListeners();
      return 'success';
    } else {
      String error = response.data.errorMessage.toString();
      return error;
    }
    } catch (e) {
      return e.toString();
    }
  }

  addAidsOrder(List orders, String docId) async {
    try {
      var dio = Dio(options);
      final url = '/api/orders';

      Response response = await dio.post(url, data: {
        "equipments": orders,
        "doctor_id": docId,
        "department_id": "ckwv3ghle0001gkvj2ef6dyld",
        "status": "CREATED"
      });
      print(response.statusCode);
      if (response.statusCode == 201) {
        await getOrders();

        return 'success';
      } else if (response.statusCode == 422) {
        return 'f';
      } else {
        print(response.data);
        return 'fuck';
      }
    } catch (e) {
      return e.toString();
    }
  }

  getOrders() async {
    // try {
    //Dio option config

    Dio dio = Dio(options);
    dio.options.headers["authorization"] = 'Bearer $token';

    Response response = await dio.get("/api/orders");
    if (response.statusCode == 200) {
      final map = response.data;

      orders = map.map((i) => OrderDataM.fromMap(i)).toList();
      notifyListeners();
      return 'success';
    } else {
      String error = response.data.errorMessage.toString();
      return error;
    }
    // } catch (e) {
    //   return e.toString();
    // }
  }

}
