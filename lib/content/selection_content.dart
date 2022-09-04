import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hike_it/constant.dart';
import 'package:hike_it/controllers/order_controllers.dart';
import 'package:hike_it/controllers/users_controller.dart';
import 'package:hike_it/session_helper.dart';
import 'package:hike_it/theme.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'dart:math' show cos, sqrt, asin;

import 'package:socket_io_client/socket_io_client.dart' as IO;

extension DateTimeExtension on DateTime? {
  bool? isAfterOrEqualTo(DateTime dateTime) {
    final date = this;
    if (date != null) {
      final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
      return isAtSameMomentAs | date.isAfter(dateTime);
    }
    return null;
  }

  bool? isBeforeOrEqualTo(DateTime dateTime) {
    final date = this;
    if (date != null) {
      final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
      return isAtSameMomentAs | date.isBefore(dateTime);
    }
    return null;
  }

  bool? isBetween(
    DateTime fromDateTime,
    DateTime toDateTime,
  ) {
    final date = this;
    if (date != null) {
      final isAfter = date.isAfterOrEqualTo(fromDateTime) ?? false;
      final isBefore = date.isBeforeOrEqualTo(toDateTime) ?? false;
      return isAfter && isBefore;
    }
    return null;
  }
}

class SelectionContent extends StatefulWidget {
  const SelectionContent(
      {Key? key, required this.listOrderGroup, required this.orderId})
      : super(key: key);
  final List<OrderData> listOrderGroup;
  final String orderId;

  @override
  State<SelectionContent> createState() => _SelectionContentState();
}

class _SelectionContentState extends State<SelectionContent> {
  bool adaKetua = false;
  bool isPendaki = false;
  @override
  void initState() {
    cekKetua();
    super.initState();
  }

  void cekKetua() async {
    bool pendaki = await SessionHelper.isPendaki();
    for (var i = 0; i < widget.listOrderGroup.length; i++) {
      if (widget.listOrderGroup[i].leader!) {
        setState(() {
          // isPendaki = pendaki;
          adaKetua = true;
        });
        return;
      }
    }
    setState(() {
      isPendaki = pendaki;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: abuAbu.withOpacity(0.01),
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(14),
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: SvgPicture.asset(
                "assets/icons/ArrowLeft.svg",
              ),
            ),
          ),
          centerTitle: true,
          title: Text(
            isPendaki
                ? 'Detail Kelompok'
                : (adaKetua ? 'Detail Kelompok' : "Pilih Ketua"),
            style: const TextStyle(
              color: hitam,
              fontSize: 20,
              fontWeight: bold,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(
              getHeight(20),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: getHeight(20),
                ),
                Expanded(
                  child: SizedBox(
                    child: ListView.builder(
                      itemCount: widget.listOrderGroup.length,
                      itemBuilder: (context, index) {
                        var order = widget.listOrderGroup[index];
                        return Container(
                          margin: EdgeInsets.only(
                            bottom: getHeight(10),
                          ),
                          decoration: BoxDecoration(
                            color: hitam.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: ListTile(
                            leading: order.pendaki?.profile != null
                                ? ClipOval(
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "$baseURL/${order.pendaki?.profile}",
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : ClipOval(
                                    child: Image.asset(
                                      "assets/images/profile/ArunaSentana.jpg",
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                            title: Text(
                              order.pendaki!.nama!,
                              style: const TextStyle(
                                color: hitam,
                                // fontSize: 20,
                                fontWeight: medium,
                              ),
                            ),
                            subtitle: Text(
                              order.pendaki?.gender ?? '',
                              style: const TextStyle(
                                color: hitam,
                                // fontSize: 14,
                                fontWeight: light,
                              ),
                            ),
                            trailing: Visibility(
                              visible: !isPendaki,
                              child: adaKetua
                                  ? Text(widget.listOrderGroup[index].leader!
                                      ? 'Ketua'
                                      : '')
                                  : InkWell(
                                      onTap: () {
                                        OrderController.to.pilihKetua(widget
                                            .listOrderGroup[index].id
                                            .toString());
                                        setState(() {
                                          adaKetua = true;
                                          widget.listOrderGroup[index].leader =
                                              true;
                                        });
                                      },
                                      child: Container(
                                        height: 32,
                                        width: 64,
                                        padding: EdgeInsets.all(
                                          getHeight(5),
                                        ),
                                        decoration: BoxDecoration(
                                          gradient: gradient,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "PILIH",
                                            style: TextStyle(
                                              color: putih,
                                              fontWeight: bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: DateTime.now().isBetween(
                          DateTime.parse(
                              widget.listOrderGroup[0].tanggalMulai!),
                          DateTime.parse(
                              widget.listOrderGroup[0].tanggalSelesai!)) ??
                      false,
                  child: InkWell(
                    onTap: () {
                      Get.to(() => TrackingScreen(
                            orderId: widget.orderId,
                          ));
                    },
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: gradient,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Center(
                        child: Text(
                          "Tracking",
                          style: TextStyle(
                            color: putih,
                            fontWeight: bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TrackingController extends GetxController {
  static TrackingController get to => Get.find();

  Location location = Location();
  LocationData? currentPosition;
  Set<Marker> markers = {};
  List<TrackingLocation> trackingList = [];
  User? userData;
  String? orderId;

  getCurrentPosition() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    log('user data : ${jsonDecode(await SessionHelper.getUser())}');
    userData = User.fromJson(jsonDecode(await SessionHelper.getUser()));
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    currentPosition = await location.getLocation();
    update();
    websocket();
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)) * 1000;
  }

  void websocket() {
    // Dart client
    log('Dart client socket');
    IO.Socket socket = IO.io(
        'https://hiking.suniaster.my.id' //'http://192.168.1.36:3000'
        ,
        <String, dynamic>{
          "transports": ["websocket"],
        });
    socket.onConnect((_) {
      log('connect');
      if (currentPosition != null) {
        socket.emit('update location', {
          'id_order': orderId,
          'id_user': userData?.id,
          'username': userData?.nama,
          'latitude': currentPosition!.latitude,
          'longitude': currentPosition!.longitude
        });
      }
    });
    location.onLocationChanged.listen((LocationData currentLocation) {
      // Use current location
      double dist = calculateDistance(
          currentPosition!.latitude!,
          currentPosition!.longitude!,
          currentLocation.latitude,
          currentLocation.longitude);
      log('current dist $dist meter ${currentPosition!.latitude!} ${currentLocation.latitude}');
      // log('update my location ${dist > 0.5}');
      if (dist > 0.5) {
        log('update my location ${dist > 0.5}');
        socket.emit('update location', {
          'id_order': orderId,
          'id_user': userData?.id,
          'username': userData?.nama,
          'latitude': currentPosition!.latitude,
          'longitude': currentPosition!.longitude
        });
        currentPosition = currentLocation;
        update();
      }
    });

    socket.on('tracking location $orderId', (data) {
      log('$data, ${data.runtimeType}');
      for (var loc in data) {
        markers.add(Marker(
            markerId: MarkerId("${loc['id_user']}"),
            position: LatLng(
              loc['latitude'],
              loc['longitude'],
            ),
            infoWindow: InfoWindow(title: loc['username'].toString())));
      }
      update();
    });
    socket.onDisconnect((_) => log('disconnect'));
    // socket.on('fromServer', (_) => print(_));
  }
}

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({Key? key, required this.orderId}) : super(key: key);
  final String orderId;

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  @override
  void initState() {
    Get.put(TrackingController());
    TrackingController.to.orderId = widget.orderId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<TrackingController>(
            initState: (_) => TrackingController.to.getCurrentPosition(),
            builder: (_) {
              if (_.currentPosition == null) {
                return Container();
              }
              return SizedBox(
                  child: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(_.currentPosition!.latitude!,
                            _.currentPosition!.longitude!),
                        zoom: 20,
                      ),
                      markers: _.markers
                      // <Marker>{
                      //   Marker(
                      //       markerId: const MarkerId('1'),
                      //       position: LatLng(
                      //         _.currentPosition!.latitude!,
                      //         _.currentPosition!.longitude!,
                      //       ),
                      //       infoWindow: const InfoWindow(title: 'suniaster')),
                      //   Marker(
                      //       markerId: const MarkerId('2'),
                      //       position: LatLng(
                      //         _.currentPosition!.latitude! + 0.0001,
                      //         _.currentPosition!.longitude! + 0.0001,
                      //       ),
                      //       infoWindow: const InfoWindow(title: 'suniaster')),
                      //   Marker(
                      //       markerId: const MarkerId('3'),
                      //       position: LatLng(
                      //         _.currentPosition!.latitude! + 0.0004,
                      //         _.currentPosition!.longitude! + 0.0004,
                      //       ),
                      //       infoWindow: const InfoWindow(title: 'suniaster'))
                      // },
                      ));
            }),
      ),
    );
  }
}

class TrackingLocation {
  int? id;
  String? idOrder;
  int? idUser;
  double? latitude;
  double? longitude;

  TrackingLocation(
      {this.id, this.idOrder, this.idUser, this.latitude, this.longitude});

  TrackingLocation.fromJson(Map<String, dynamic> json) {
    id = int.parse((json['id'] ?? 0).toString());
    idOrder = json['id_order'].toString();
    idUser = int.parse((json['id_user'] ?? 0).toString());
    latitude = double.parse((json['latitude'] ?? 0).toString());
    longitude = double.parse((json['longitude'] ?? 0).toString());
  }
}
