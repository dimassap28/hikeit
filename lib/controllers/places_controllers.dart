// import 'dart:convert';
// import 'dart:developer';

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hike_it/constant.dart';
import 'package:hike_it/session_helper.dart';

class PlacesController extends GetxController {
  static PlacesController get to => Get.find();

  List<TempatWisata> listTempatWisata = [];
  List<TempatWisata> listTempatFavorit = [];

  void getTempatWisata() async {
    try {
      var response = await Dio().get('$baseURL/api/tempat-wisata');
      log('tempat-wisata : ${response.data}');
      if (response.data['message'].toString() == 'success') {
        listTempatWisata = ListTempatWisata.fromJson(response.data).data!;
        update();
      }
    } catch (e) {
      log('error : $e');
    }
  }

  void getFavorite() async {
    String idPendaki = await SessionHelper.getUserId();
    try {
      var response = await Dio().get('$baseURL/api/favorite-place/$idPendaki');
      log('response favorite : $response');
      if (response.data['message'].toString() == 'success') {
        listTempatFavorit.clear();
        for (var tempat in response.data['favorite_places']) {
          listTempatFavorit.add(TempatWisata.fromJson(tempat['tempat_wisata']));
        }
        update();
      }
    } catch (e) {
      log('error : $e');
    }
  }

  void updateFavorite(String idTempat) async {
    String idPendaki = await SessionHelper.getUserId();
    try {
      var response = await Dio().post('$baseURL/api/favorite-place',
          data: {'tempat_wisata_id': idTempat, 'pendaki_id': idPendaki});
      log('tempat-wisata : ${response.data}');
      if (response.data['message'].toString() == 'success') {
        Fluttertoast.showToast(msg: 'Daftar favorit telah diperbarui');
        getFavorite();
      }
    } catch (e) {
      log('error : $e');
    }
  }
}

// Models

// class ListTempatWisata {
//   String? message;
//   List<TempatWisata>? data;

//   ListTempatWisata({this.message, this.data});

//   ListTempatWisata.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <TempatWisata>[];
//       json['data'].forEach((v) {
//         data!.add(TempatWisata.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['message'] = message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class TempatWisata {
//   int? id;
//   String? nama;
//   String? deskripsi;
//   String? fasilitas;
//   String? alamat;
//   double? latitude;
//   double? longitude;
//   List<Pictures>? pictures;

//   TempatWisata(
//       {this.id,
//       this.nama,
//       this.deskripsi,
//       this.fasilitas,
//       this.alamat,
//       this.latitude,
//       this.longitude,
//       this.pictures});

//   TempatWisata.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     nama = json['nama'];
//     deskripsi = json['deskripsi'];
//     fasilitas = json['fasilitas'];
//     alamat = json['alamat'];
//     latitude = double.parse(json['latitude'].toString());
//     longitude = double.parse(json['longitude'].toString());
//     if (json['pictures'] != null) {
//       pictures = <Pictures>[];
//       json['pictures'].forEach((v) {
//         pictures!.add(Pictures.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['nama'] = nama;
//     data['deskripsi'] = deskripsi;
//     data['fasilitas'] = fasilitas;
//     data['alamat'] = alamat;
//     data['latitude'] = latitude;
//     data['longitude'] = longitude;
//     if (pictures != null) {
//       data['pictures'] = pictures!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Pictures {
//   int? id;
//   int? tempatWisataId;
//   String? path;

//   Pictures({this.id, this.tempatWisataId, this.path});

//   Pictures.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     tempatWisataId = json['tempat_wisata_id'];
//     path = json['path'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['tempat_wisata_id'] = tempatWisataId;
//     data['path'] = path;
//     return data;
//   }
// }

// class ListTempatWisata {
//   String? message;
//   List<TempatWisata>? data;

//   ListTempatWisata({this.message, this.data});

//   ListTempatWisata.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <TempatWisata>[];
//       json['data'].forEach((v) {
//         data!.add(TempatWisata.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['message'] = message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class TempatWisata {
//   int? id;
//   String? nama;
//   String? deskripsi;
//   String? fasilitas;
//   String? tarif;
//   String? alamat;
//   double? latitude;
//   double? longitude;
//   List<Pictures>? pictures;
//   bool? favorite;
//   Pemandu? pemandu;

//   TempatWisata(
//       {this.id,
//       this.nama,
//       this.deskripsi,
//       this.fasilitas,
//       this.tarif,
//       this.alamat,
//       this.latitude,
//       this.longitude,
//       this.pictures,
//       this.favorite,
//       this.pemandu});

//   TempatWisata.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     nama = json['nama'];
//     deskripsi = json['deskripsi'];
//     fasilitas = json['fasilitas'];
//     tarif = json['tarif'];
//     alamat = json['alamat'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     if (json['pictures'] != null) {
//       pictures = <Pictures>[];
//       json['pictures'].forEach((v) {
//         pictures!.add(Pictures.fromJson(v));
//       });
//     }
//     favorite = json['favorite'];
//     pemandu =
//         json['pemandu'] != null ? Pemandu.fromJson(json['pemandu']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['nama'] = nama;
//     data['deskripsi'] = deskripsi;
//     data['fasilitas'] = fasilitas;
//     data['tarif'] = tarif;
//     data['alamat'] = alamat;
//     data['latitude'] = latitude;
//     data['longitude'] = longitude;
//     if (pictures != null) {
//       data['pictures'] = pictures!.map((v) => v.toJson()).toList();
//     }
//     data['favorite'] = favorite;
//     if (pemandu != null) {
//       data['pemandu'] = pemandu!.toJson();
//     }
//     return data;
//   }
// }

// class Pictures {
//   int? id;
//   int? tempatWisataId;
//   String? path;

//   Pictures({this.id, this.tempatWisataId, this.path});

//   Pictures.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     tempatWisataId = json['tempat_wisata_id'];
//     path = json['path'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['tempat_wisata_id'] = tempatWisataId;
//     data['path'] = path;
//     return data;
//   }
// }

// class Pemandu {
//   int? id;
//   String? nama;
//   String? email;
//   String? profile;
//   String? fotoKtp;
//   String? alamat;
//   String? whatsapp;
//   String? tarif;
//   String? role;
//   String? fcmToken;
//   String? password;

//   Pemandu(
//       {this.id,
//       this.nama,
//       this.email,
//       this.profile,
//       this.fotoKtp,
//       this.alamat,
//       this.whatsapp,
//       this.tarif,
//       this.role,
//       this.fcmToken,
//       this.password});

//   Pemandu.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     nama = json['nama'];
//     email = json['email'];
//     profile = json['profile'];
//     fotoKtp = json['foto_ktp'];
//     alamat = json['alamat'];
//     whatsapp = json['whatsapp'];
//     tarif = json['tarif'];
//     role = json['role'];
//     fcmToken = json['fcm_token'];
//     password = json['password'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['nama'] = nama;
//     data['email'] = email;
//     data['profile'] = profile;
//     data['foto_ktp'] = fotoKtp;
//     data['alamat'] = alamat;
//     data['whatsapp'] = whatsapp;
//     data['tarif'] = tarif;
//     data['role'] = role;
//     data['fcm_token'] = fcmToken;
//     data['password'] = password;
//     return data;
//   }
// }

class ListTempatWisata {
  String? message;
  List<TempatWisata>? data;

  ListTempatWisata({this.message, this.data});

  ListTempatWisata.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <TempatWisata>[];
      json['data'].forEach((v) {
        data!.add(TempatWisata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
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
    id = json['id'];
    nama = json['nama'];
    deskripsi = json['deskripsi'];
    fasilitas = json['fasilitas'];
    tarifLokasi = json['tarif_lokasi'];
    tarifPemandu = double.parse(json['tarif_pemandu'].toString());
    alamat = json['alamat'];
    latitude = double.parse(json['latitude'].toString());
    longitude = double.parse(json['longitude'].toString());
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
    id = json['id'];
    tempatWisataId = int.parse(json['tempat_wisata_id'].toString());
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tempat_wisata_id'] = int.parse(tempatWisataId.toString());
    data['path'] = path;
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
  int? tarif;
  String? role;
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
      this.fcmToken,
      this.password});

  Pemandu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    email = json['email'];
    profile = json['profile'];
    fotoKtp = json['foto_ktp'];
    alamat = json['alamat'];
    whatsapp = json['whatsapp'];
    tarif = int.parse(json['tarif'].toString());
    role = json['role'];
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
    data['fcm_token'] = fcmToken;
    data['password'] = password;
    return data;
  }
}
