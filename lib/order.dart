import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hike_it/constant.dart';
import 'package:hike_it/controllers/places_controllers.dart';
// import 'package:hike_it/controllers/users_controller.dart';
import 'package:hike_it/dashboard.dart';
import 'package:hike_it/session_helper.dart';
import 'package:hike_it/theme.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Order extends StatefulWidget {
  const Order({Key? key, required this.tempatWisata}) : super(key: key);
  final TempatWisata tempatWisata;

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  int days = 0;
  int kuota = 0;
  double tarif = 0;
  PickerDateRange? range;
  TextEditingController catatan = TextEditingController();

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    range = args.value;
    log('${args.value} ${range!.startDate!.runtimeType}');
    setState(() {
      kuota = 0;
    });
    if (range!.startDate != null && range!.endDate != null) {
      setState(() {
        days = range!.endDate!.difference(range!.startDate!).inDays;
        tarif = days * widget.tempatWisata.pemandu!.tarif! * 1.0;
      });
      getKuota();
    }
  }

  void order() async {
    if (range == null) {
      Fluttertoast.showToast(msg: 'Pilih tanggal terlebih dahulu');
      return;
    }
    if (range!.startDate == null || range!.endDate == null) {
      Fluttertoast.showToast(msg: 'Pilih tanggal terlebih dahulu');
      return;
    }
    try {
      String myId = await SessionHelper.getUserId();
      var response = await Dio().post(
        '$baseURL/api/order',
        data: {
          'tempat_wisata_id': widget.tempatWisata.id.toString(),
          'tanggal_mulai': range!.startDate.toString(),
          'tanggal_selesai': range!.endDate.toString(),
          'pemandu_id': widget.tempatWisata.pemandu!.id!.toString(),
          'pendaki_id': myId,
          'catatan': catatan.text,
        },
      );
      log('res server: ${response.data}');
      Fluttertoast.showToast(msg: response.data['message']);
      if (response.data['status'].toString() == 'success') {
        Get.offAll(const Dashboard());
      }
    } catch (e) {
      log('error $e');
    }
  }

  void getKuota() async {
    try {
      var response = await Dio().post(
        '$baseURL/api/check-order',
        data: {
          'tempat_wisata_id': widget.tempatWisata.id.toString(),
          'tanggal_mulai': range!.startDate.toString(),
          'tanggal_selesai': range!.endDate.toString(),
        },
      );
      if (response.data['status'].toString() == 'success') {
        setState(() {
          kuota = 5 - int.parse((response.data['booked'] ?? 0).toString());
        });
      }
    } catch (e) {
      log('error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SafeArea(
                child: Container(
              padding: horpadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: getHeight(20),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: SizedBox(
                      width: getWidth(22),
                      height: getHeight(22),
                      child: SvgPicture.asset('assets/icons/left.svg'),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(25),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          tanggal,
                          style: TextStyle(
                              color: hitam,
                              fontWeight: medium,
                              fontSize: getWidth(18)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: getHeight(35),
                      ),
                      SfDateRangePicker(
                        onSelectionChanged: _onSelectionChanged,
                        selectionMode: DateRangePickerSelectionMode.range,
                      ),
                      Text(
                        'Catatan',
                        style: TextStyle(
                            color: hitam,
                            fontWeight: medium,
                            fontSize: getWidth(18)),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: getHeight(5),
                      ),
                      TextField(
                        controller: catatan,
                        maxLines: 4,
                        style: TextStyle(
                          color: hitam.withOpacity(0.9),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          filled: true,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          fillColor: Colors.black.withOpacity(0.15),
                          contentPadding: const EdgeInsets.all(15),
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(15),
                      ),
                      Text(
                        'Tersedia $kuota kuota',
                        style: TextStyle(
                            color: hitam,
                            fontWeight: medium,
                            fontSize: getWidth(18)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                ],
              ),
            )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: horpadding,
              width: double.infinity,
              height: getHeight(80),
              decoration: BoxDecoration(
                  color: putih,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: shadow.withOpacity(0.5),
                        blurRadius: 50,
                        offset: const Offset(0, -13))
                  ]),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Estimasi Tarif Pemandu',
                        style: TextStyle(
                            color: hitam,
                            fontWeight: bold,
                            fontSize: getWidth(12)),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        'Rp ${numberFormat.format(tarif)}',
                        style: TextStyle(
                            color: hitam,
                            fontWeight: bold,
                            fontSize: getWidth(16)),
                      ),
                      Text(
                        '$days Hari',
                        style: TextStyle(
                            color: abuAbu,
                            fontWeight: medium,
                            fontSize: getWidth(13)),
                      )
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      if (kuota > 0) {
                        order();
                      }
                    },
                    child: Container(
                      width: getWidth(100),
                      height: getHeight(45),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            kuota > 0 ? pink : Colors.grey,
                            kuota > 0 ? ungu : Colors.grey
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Pesan',
                          style: TextStyle(
                            color: putih,
                            fontWeight: bold,
                            fontSize: getWidth(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
