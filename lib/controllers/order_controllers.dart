import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hike_it/constant.dart';
import 'package:hike_it/session_helper.dart';
// import 'package:hike_it/session_helper.dart';

class OrderController extends GetxController {
  static OrderController get to => Get.find();
  List<OrderData> orderList = [];
  List<OrderData> pendingOrderList = [];
  Map<String, List<OrderData>> mapOrderList = {};

  void getOrderList() async {
    bool isPendaki = await SessionHelper.isPendaki();
    try {
      var response = await Dio().get('$baseURL/api/order');
      log('res order list : $response');
      if (response.data['status'].toString() == 'success') {
        mapOrderList = {};
        orderList = [];
        pendingOrderList = [];
        var listOrder = OrderList.fromJson(response.data).data!;

        if (isPendaki) {
          int myUserId = int.parse(await SessionHelper.getUserId());
          List<String> removeList = [];
          for (var order in listOrder) {
            order.pendakiId;
            if (order.status == 'diterima') {
              String key =
                  '${order.tanggalMulai}_${order.tanggalSelesai}_${order.tempatWisata!.id}';
              if (mapOrderList[key] == null) {
                mapOrderList[key] = [];
              }
              mapOrderList[key]!.add(order);
            } else if (order.status == 'pending') {
              if (myUserId == order.pendakiId!) {
                pendingOrderList.add(order);
              }
            }
          }
          for (var key in mapOrderList.keys) {
            var contain = mapOrderList[key]
                ?.where((element) => element.pendakiId == myUserId);
            if ((contain ?? []).isNotEmpty) {
              removeList.add(key);
            }
          }
          // log('$removeList');
          // log('${mapOrderList.keys}');
          // log('my id $myUserId\n${mapOrderList['2022-08-10_2022-08-12_4']![0].toJson()}\n${mapOrderList['2022-08-10_2022-08-12_4']![1].toJson()}');
          mapOrderList.removeWhere((key, value) => !removeList.contains(key));
          // log('${mapOrderList.keys}');
        } else {
          for (var order in listOrder) {
            // log('order.toJson() : ${order.toJson()}');
            if (order.status == 'diterima') {
              String key =
                  '${order.tanggalMulai}_${order.tanggalSelesai}_${order.tempatWisata!.id}';
              if (mapOrderList[key] == null) {
                mapOrderList[key] = [];
              }
              mapOrderList[key]!.add(order);
            } else if (order.status == 'pending') {
              pendingOrderList.add(order);
            }
          }
        }
        update();
      }
    } catch (e) {
      log('error : $e');
    }
  }

  void terimaOrder(String id) async {
    try {
      var response =
          await Dio().post('$baseURL/api/accept-order', data: {'id': id});
      if (response.data['status'].toString() == 'success') {
        Fluttertoast.showToast(msg: 'Order telah diterima');
        getOrderList();
      }
    } catch (e) {
      log('error : $e');
    }
  }

  void cancelOrder(String id) async {
    try {
      var response =
          await Dio().post('$baseURL/api/cancel-order', data: {'id': id});
      print(response);
      if (response.data['status'].toString() == 'success') {
        Fluttertoast.showToast(msg: 'Order telah dibatalkan');
        getOrderList();
      }
    } catch (e) {
      log('error : $e');
    }
  }

  void pilihKetua(String id) async {
    try {
      var response =
          await Dio().post('$baseURL/api/pilih-ketua', data: {'id': id});
      if (response.data['status'].toString() == 'success') {
        Fluttertoast.showToast(msg: 'Ketua telah dipilih');
        getOrderList();
      }
    } catch (e) {
      log('error : $e');
    }
  }
}

// Models
class OrderList {
  String? status;
  List<OrderData>? data;

  OrderList({this.status, this.data});

  OrderList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <OrderData>[];
      json['data'].forEach((v) {
        data!.add(OrderData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderData {
  int? id;
  int? tempatWisataId;
  int? pemanduId;
  int? pendakiId;
  String? tanggalMulai;
  String? tanggalSelesai;
  bool? leader;
  String? catatan;
  String? status;
  Pemandu? pemandu;
  Pemandu? pendaki;
  TempatWisata? tempatWisata;

  OrderData(
      {this.id,
      this.tempatWisataId,
      this.pemanduId,
      this.pendakiId,
      this.tanggalMulai,
      this.tanggalSelesai,
      this.leader,
      this.catatan,
      this.status,
      this.pemandu,
      this.pendaki,
      this.tempatWisata});

  OrderData.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    tempatWisataId = int.parse(json['tempat_wisata_id'].toString());
    pemanduId = int.parse(json['pemandu_id'].toString());
    pendakiId = int.parse(json['pendaki_id'].toString());
    tanggalMulai = json['tanggal_mulai'].toString().split(' ')[0];
    tanggalSelesai = json['tanggal_selesai'].toString().split(' ')[0];
    leader = int.parse(json['leader'].toString()) == 1;
    catatan = json['catatan'];
    status = json['status'];
    pemandu =
        json['pemandu'] != null ? Pemandu.fromJson(json['pemandu']) : null;
    pendaki =
        json['pendaki'] != null ? Pemandu.fromJson(json['pendaki']) : null;
    tempatWisata = json['tempat_wisata'] != null
        ? TempatWisata.fromJson(json['tempat_wisata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tempat_wisata_id'] = tempatWisataId;
    data['pemandu_id'] = pemanduId;
    data['pendaki_id'] = pendakiId;
    data['tanggal_mulai'] = tanggalMulai;
    data['tanggal_selesai'] = tanggalSelesai;
    data['leader'] = leader;
    data['catatan'] = catatan;
    data['status'] = status;
    if (pemandu != null) {
      data['pemandu'] = pemandu!.toJson();
    }
    if (pendaki != null) {
      data['pendaki'] = pendaki!.toJson();
    }
    if (tempatWisata != null) {
      data['tempat_wisata'] = tempatWisata!.toJson();
    }
    return data;
  }
}

class Pemandu {
  int? id;
  String? nama;
  String? email;
  String? profile;
  String? fotoKtp;
  String? alamat;
  String? whatsapp;
  double? tarif;
  String? role;
  String? gender;
  String? fcmToken;
  String? password;

  Pemandu(
      {this.id,
      this.nama,
      this.email,
      this.profile,
      this.fotoKtp,
      this.alamat,
      this.whatsapp,
      this.tarif,
      this.role,
      this.gender,
      this.fcmToken,
      this.password});

  Pemandu.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    nama = json['nama'];
    email = json['email'];
    profile = json['profile'];
    fotoKtp = json['foto_ktp'];
    alamat = json['alamat'];
    whatsapp = json['whatsapp'];
    tarif = double.parse((json['tarif'] ?? 0).toString());
    role = json['role'];
    gender = json['gender'];
    fcmToken = json['fcm_token'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    data['email'] = email;
    data['profile'] = profile;
    data['foto_ktp'] = fotoKtp;
    data['alamat'] = alamat;
    data['whatsapp'] = whatsapp;
    data['tarif'] = tarif;
    data['role'] = role;
    data['gender'] = gender;
    data['fcm_token'] = fcmToken;
    data['password'] = password;
    return data;
  }
}

class TempatWisata {
  int? id;
  String? nama;
  String? deskripsi;
  String? fasilitas;
  String? tarifLokasi;
  double? tarifPemandu;
  String? alamat;
  double? latitude;
  double? longitude;
  List<Pictures>? pictures;
  bool? favorite;
  Pemandu? pemandu;

  TempatWisata(
      {this.id,
      this.nama,
      this.deskripsi,
      this.fasilitas,
      this.tarifLokasi,
      this.tarifPemandu,
      this.alamat,
      this.latitude,
      this.longitude,
      this.pictures,
      this.favorite,
      this.pemandu});

  TempatWisata.fromJson(Map<String, dynamic> json) {
    id = int.parse((json['id'] ?? 0).toString());
    nama = json['nama'];
    deskripsi = json['deskripsi'];
    fasilitas = json['fasilitas'];
    tarifLokasi = json['tarif_lokasi'];
    tarifPemandu = double.parse(json['tarif_pemandu'] ?? '0');
    alamat = json['alamat'];
    latitude = double.parse(json['latitude'] ?? '0');
    longitude = double.parse(json['longitude'] ?? '0');
    if (json['pictures'] != null) {
      pictures = <Pictures>[];
      json['pictures'].forEach((v) {
        pictures!.add(Pictures.fromJson(v));
      });
    }
    favorite = json['favorite'];
    pemandu =
        json['pemandu'] != null ? Pemandu.fromJson(json['pemandu']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    data['deskripsi'] = deskripsi;
    data['fasilitas'] = fasilitas;
    data['tarif_lokasi'] = tarifLokasi;
    data['tarif_pemandu'] = tarifPemandu;
    data['alamat'] = alamat;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    if (pictures != null) {
      data['pictures'] = pictures!.map((v) => v.toJson()).toList();
    }
    data['favorite'] = favorite;
    if (pemandu != null) {
      data['pemandu'] = pemandu!.toJson();
    }
    return data;
  }
}

class Pictures {
  int? id;
  int? tempatWisataId;
  String? path;

  Pictures({this.id, this.tempatWisataId, this.path});

  Pictures.fromJson(Map<String, dynamic> json) {
    id = int.parse((json['id'] ?? 0).toString());
    tempatWisataId = int.parse(json['tempat_wisata_id'] ?? '0');
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tempat_wisata_id'] = tempatWisataId;
    data['path'] = path;
    return data;
  }
}
