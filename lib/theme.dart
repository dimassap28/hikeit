import 'package:flutter/material.dart';
import 'package:get/get.dart';

//Color

const Color putih = Color(0xffffffff);
const Color abuAbu = Color(0xffAAAAAA);
const Color hitam = Color(0xff000000);
const Color ungu = Color(0xff8D5096);
const Color pink = Color(0xffCF6A9B);
const Color orange = Color(0xffFFE59D);
const Color orangefont = Color(0xffD9AF3A);
const Color shadow = Color(0xffC2C2C2);
const Gradient gradient = LinearGradient(
  colors: [ungu, pink],
  end: Alignment.topRight,
  begin: Alignment.bottomLeft,
);

//FontWeight

const FontWeight thin = FontWeight.w100;
const FontWeight extralight = FontWeight.w200;
const FontWeight light = FontWeight.w300;
const FontWeight normal = FontWeight.w400;
const FontWeight medium = FontWeight.w500;
const FontWeight semibold = FontWeight.w600;
const FontWeight bold = FontWeight.w700;
const FontWeight extrabold = FontWeight.w800;
const FontWeight black = FontWeight.w900;

//Padding

const horpadding = EdgeInsets.symmetric(horizontal: 23);

//String

const String namaPemandu = 'Suparjo Esteban Viskara';
const String pemandu = 'Dipandu oleh $namaPemandu';
const String deskPemandu = 'Pemandu Lokal';
const String mount = 'Gunung Semeru';
// const String location = 'Lumajang, Jawa Timur';
const String desk = 'Deskripsi';
const String deskFill =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec porta faucibus ex, nec viverra urna accumsan ut. Suspendisse ullamcorper, tellus nec rhoncus bibendum, tellus massa fringilla metus, posuere euismod ante est ut erat. Nulla justo magna, pretium et fermentum at, auctor feugiat est. Donec sed ante non mi mattis scelerisque sed ac dolor. Integer rhoncus arcu ante, ac dictum turpis convallis sit amet. Aenean dignissim orci id sagittis varius. Sed porta arcu suscipit tellus dapibus, non aliquam dolor viverra. Maecenas nisi felis, ullamcorper ut ornare in, laoreet ac sem. Nulla et facilisis erat. Donec dictum convallis diam ut rutrum.';
const String fasilitas = 'Fasilitas';
const String fasilFill = 'Pemandu, Porter, Area Kamping, Toilet Umum';
const String alur = 'Alur Jalan';
const String alurFill = 'Lorem Ipsum';
const String tentang = 'Tentang';
const String tentangFill =
    'Pemandu Lokal di Gunung Semeru. Sudah melakukan lebih dari 100 memandu perjalanan baik turis lokal ataupun turis asing. Dengan senang hati memandu dan memberikan sajian indah selama perjalanan untuk hobby dan passion';
const String alamat = 'Alamat';
const String alamatFill =
    'Jalan Bromo, No.57. Kelurahan Labruk Lor, Kecamatan Banjarwaru, Kabupaten Lumajang, Jawa Timur';
const String rating = 'Rating';
const String ratingFill = '5.0 (132)';
const String harga = 'Rp 500.000';
const String hari = '3-4 Hari';
const String anggota = 'Anggota';
const String tanggal = 'Pilih Tanggal Keberangkatan - Pulang';

//Responsive

double getWidth(double size) {
  return Get.width / 392.72727272727275 * size;
}

double getHeight(double size) {
  return Get.height / 850.9090909090909 * size;
}

// Header variable

String nowLocation = "Kediri, Jawa Timur";

// Profile Detail

var photoProfile = const ExactAssetImage("assets/images/profile/profile.png");
var photo = const NetworkImage(
  "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
);
var photo1 = const NetworkImage(
  "https://assets.promediateknologi.com/crop/0x0:0x0/x/photo/2022/02/11/1140986105.jpg",
);
var photoMbake = const ExactAssetImage(
  "assets/images/profile/ArunaSentana.jpg",
);

String namaUser = "Aruna Sentana";
String ttlUser = "21 April 1966";
String hpUser = "+62 812 3456 7890";
String kelaminUser = "Perempuan";
