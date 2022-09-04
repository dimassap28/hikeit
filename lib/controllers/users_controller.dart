import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hike_it/constant.dart';
import 'package:hike_it/dashboard.dart';
import 'package:hike_it/session_helper.dart';
import 'package:hike_it/sign/sign_in.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class UsersController extends GetxController {
  static UsersController get to => Get.isRegistered<UsersController>()
      ? Get.find()
      : Get.put(UsersController());

  User? userData;

  TextEditingController editNama = TextEditingController();
  TextEditingController editWa = TextEditingController();
  String gender = 'Laki-laki';

  TextEditingController userName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  TextEditingController userConfirmPassword = TextEditingController();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  TextEditingController emailLogin = TextEditingController();
  TextEditingController passwordLogin = TextEditingController();

  Position? currentPosition;
  String? currentAddress;

  File? profileImage;

  @override
  onInit() {
    determinePosition();
    loadUserDataFromSession();
    super.onInit();
  }

  void pickImage() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 40);
    profileImage = File(image!.path);
    update();
  }

  void inisiateForm() {
    profileImage = null;
    editNama.text = userData?.nama ?? '';
    editWa.text = userData?.whatsapp ?? '';
    gender = userData?.gender ?? 'Laki-laki';
  }

  void loadUserDataFromSession() async {
    String data = await SessionHelper.getUser();
    if (data.trim().isNotEmpty) {
      userData = User.fromJson(json.decode(data));
      update();
    }
  }

  determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    update();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    currentPosition = await Geolocator.getCurrentPosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(
        currentPosition!.latitude, currentPosition!.longitude);
    Placemark place = placemarks[0];
    currentAddress = "${place.locality}, ${place.postalCode}, ${place.country}";
    update();
  }

  void updateProfile() async {
    if (editNama.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: 'Nama harus diisi');
      return;
    }

    if (editWa.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: 'No. Whatsapp harus diisi');
      return;
    }

    if (profileImage == null) {
      Fluttertoast.showToast(msg: 'Pilih foto profil');
      return;
    }

    try {
      dio.FormData formData = dio.FormData.fromMap({
        'id': userData?.id,
        'nama': editNama.text.trim().toString(),
        'gender': gender,
        'whatsapp': editWa.text.trim().toString(),
        'profile': await dio.MultipartFile.fromFile(
          profileImage!.path,
        ),
      });
      var response = await dio.Dio().post(
        '$baseURL/api/update-user',
        data: formData,
      );
      log('res update profile: $response');
      if (response.data['user'] != null) {
        SessionHelper.saveLogin(response.data['user']['id'].toString(),
            response.data['user']['role'].toString());
        userData = User.fromJson(response.data['user']);
        SessionHelper.setUser(json.encode(response.data['user']));
        update();
        Fluttertoast.showToast(msg: 'Data berhasil diupdate');
        Get.back();
      } else {
        Fluttertoast.showToast(msg: response.data['message']);
      }
    } catch (e) {
      log('error $e');
    }
  }

  void register() async {
    if (userName.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: 'Nama harus diisi');
      return;
    }
    if (userEmail.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: 'Email harus diisi');
      return;
    }
    if (userPassword.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: 'Password harus diisi');
      return;
    }
    if (userPassword.text.trim() != userConfirmPassword.text.trim()) {
      Fluttertoast.showToast(msg: 'Password tidak sama!');
      return;
    }
    log('tesss');
    String token = await messaging.getToken() ?? '';
    try {
      log('tessads');
      var response =
          await dio.Dio().post('$baseURL/api/register-pendaki', data: {
        'nama': userName.text,
        'email': userEmail.text,
        'password': userPassword.text,
        'fcm_token': token
      });
      log('tesssasdasd');
      log('response $response');
      if (response.data['message'].toString() == 'success') {
        // update();
        Fluttertoast.showToast(msg: 'Registrasi berhasil, silahkan login');
        Get.offAll(const SignIn());
      } else {
        Fluttertoast.showToast(msg: response.data['message']);
      }
    } catch (e) {
      // print(e);
    }
  }

  void login() async {
    if (emailLogin.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: 'Email harus diisi');
      return;
    }
    if (passwordLogin.text.trim().length < 6) {
      Fluttertoast.showToast(msg: 'Password harus diisi minimal 6 karakter');
      return;
    }

    String token = await messaging.getToken() ?? '';
    try {
      var response = await dio.Dio().post(
        '$baseURL/api/login-user',
        data: {
          'email': emailLogin.text.trim().toString(),
          'password': passwordLogin.text.trim().toString(),
          'fcm_token': token,
        },
      );
      log('res server: $response');
      Fluttertoast.showToast(msg: response.data['message']);
      if (response.data['user'] != null) {
        SessionHelper.saveLogin(response.data['user']['id'].toString(),
            response.data['user']['role'].toString());
        userData = User.fromJson(response.data['user']);
        SessionHelper.setUser(json.encode(response.data['user']));
        update();
        Get.offAll(const Dashboard());
      } else {
        Fluttertoast.showToast(msg: response.data['message']);
      }
    } catch (e) {
      log('error $e');
    }
  }
}

class User {
  int? id;
  String? nama;
  String? email;
  String? profile;
  String? fotoKtp;
  String? alamat;
  String? whatsapp;
  String? tarif;
  String? role;
  String? gender;
  String? fcmToken;
  String? password;

  User(
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

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    email = json['email'];
    profile = json['profile'];
    fotoKtp = json['foto_ktp'];
    alamat = json['alamat'];
    whatsapp = json['whatsapp'];
    tarif = json['tarif'];
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
