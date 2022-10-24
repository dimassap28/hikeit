import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hike_it/constant.dart';
import 'package:hike_it/controllers/places_controllers.dart';
import 'package:hike_it/pemandu.dart';
import 'package:hike_it/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key, required this.tempatWisata}) : super(key: key);
  final TempatWisata tempatWisata;
  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  String address = '...';
  bool isMyFavorite = false;
  @override
  void initState() {
    isMyFavorite = widget.tempatWisata.favorite!;
    getAddressFromLatLong(
        widget.tempatWisata.latitude!, widget.tempatWisata.longitude!);
    super.initState();
  }

  Future<void> getAddressFromLatLong(double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    // print(placemarks);
    Placemark place = placemarks[0];
    setState(() {
      address =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    });
  }

  List<Widget> slider = [
    SizedBox(
      height: getHeight(150),
      child: Image.asset(
        'assets/images/booking/slider.png',
      ),
    ),
    SizedBox(
      height: getHeight(150),
      child: Image.asset(
        'assets/images/booking/slider.png',
      ),
    ),
    SizedBox(
      height: getHeight(150),
      child: Image.asset(
        'assets/images/booking/slider.png',
      ),
    ),
  ];

  List<Map<String, String>> other = [
    {
      'image': 'assets/images/booking/other1.png',
    },
    {
      'image': 'assets/images/booking/other2.png',
    },
    {
      'image': 'assets/images/booking/other3.png',
    },
    {
      'image': 'assets/images/booking/other4.png',
    },
    {
      'image': 'assets/images/booking/other5.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: AppBar().preferredSize.height,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      child: SizedBox(
                        width: getWidth(22),
                        height: getHeight(22),
                        child: SvgPicture.asset('assets/icons/left.svg'),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        PlacesController.to
                            .updateFavorite(widget.tempatWisata.id!.toString());
                        setState(() {
                          isMyFavorite = !isMyFavorite;
                        });
                      },
                      child: SizedBox(
                        width: getWidth(22),
                        height: getHeight(22),
                        child: isMyFavorite
                            ? SvgPicture.asset('assets/icons/pemandu/Star.svg')
                            : const Icon(Icons.star_rate_rounded),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getHeight(8),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: SafeArea(
                    child: Container(
                      padding: horpadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: getWidth(35),
                                height: getHeight(35),
                                child:
                                    // const Image(
                                    //   image: AssetImage(
                                    //       'assets/images/booking/circleprofile.png'),
                                    // ),
                                    ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "$baseURL/${widget.tempatWisata.pemandu!.profile}",
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: getWidth(15),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Dipandu oleh ${widget.tempatWisata.pemandu!.nama!}',
                                    style: TextStyle(
                                        fontWeight: bold,
                                        fontSize: getWidth(15),
                                        color: hitam),
                                  ),
                                  Text(
                                    deskPemandu,
                                    style: TextStyle(
                                        fontWeight: semibold,
                                        fontSize: getWidth(12),
                                        color: abuAbu),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: getHeight(20),
                          ),
                          Text(
                            widget.tempatWisata.nama!,
                            style: TextStyle(
                              fontWeight: bold,
                              fontSize: getWidth(19),
                            ),
                          ),
                          SizedBox(
                            height: getHeight(3),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: getWidth(20),
                                height: getHeight(20),
                                child: SvgPicture.asset(
                                    'assets/icons/booking/Location.svg'),
                              ),
                              SizedBox(
                                width: getWidth(5),
                              ),
                              Expanded(
                                child: Text(
                                  address,
                                  style: TextStyle(
                                      fontWeight: normal,
                                      fontSize: getWidth(15),
                                      color: abuAbu),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getHeight(15),
                          ),
                          CarouselSlider(
                            items: widget.tempatWisata.pictures!
                                .map((picture) => ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: AspectRatio(
                                        aspectRatio: 2,
                                        child: SizedBox(
                                          height: getHeight(150),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "$baseURL/${picture.path}",
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                CircularProgressIndicator(
                                                    value: downloadProgress
                                                        .progress),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ))))
                                .toList(),
                            carouselController: _controller,
                            options: CarouselOptions(
                              autoPlay: true,
                              enlargeCenterPage: true,
                              viewportFraction: 1,
                              aspectRatio: 2.0,
                              onPageChanged: (index, reason) {
                                setState(
                                  () {
                                    _current = index;
                                  },
                                );
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: widget.tempatWisata.pictures!
                                .asMap()
                                .entries
                                .map(
                              (entry) {
                                return GestureDetector(
                                  onTap: () =>
                                      _controller.animateToPage(entry.key),
                                  child: Container(
                                    width: getWidth(9),
                                    height: getHeight(9),
                                    margin: EdgeInsets.symmetric(
                                        vertical: getHeight(10),
                                        horizontal: getWidth(2.5)),
                                    decoration: BoxDecoration(
                                      gradient: gradient,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(5),
                                      color: (Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Colors.white)
                                          .withOpacity(_current == entry.key
                                              ? 0.9
                                              : 0.4),
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                          SizedBox(
                            height: getHeight(0),
                          ),
                          Text(
                            desk,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontWeight: bold,
                              fontSize: getWidth(16),
                            ),
                          ),
                          ExpandableText(
                            widget.tempatWisata.deskripsi!,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: hitam,
                              fontWeight: normal,
                              fontSize: getHeight(13.5),
                            ),
                            expandText: 'See More',
                            collapseText: 'See Less',
                            maxLines: 3,
                            animation: true,
                            animationDuration: const Duration(seconds: 2),
                            collapseOnTextTap: true,
                            expandOnTextTap: true,
                          ),
                          SizedBox(
                            height: getHeight(8),
                          ),
                          Text(
                            fasilitas,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontWeight: bold,
                              fontSize: getWidth(16),
                            ),
                          ),
                          Text(
                            widget.tempatWisata.fasilitas!,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontWeight: normal,
                              fontSize: getWidth(13.5),
                            ),
                          ),
                          SizedBox(
                            height: getHeight(8),
                          ),
                          Text(
                            'Tarif',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontWeight: bold,
                              fontSize: getWidth(16),
                            ),
                          ),
                          Text(
                            widget.tempatWisata.tarifLokasi!,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontWeight: normal,
                              fontSize: getWidth(13.5),
                            ),
                          ),
                          SizedBox(
                            height: getHeight(8),
                          ),
                          // Text(
                          //   alur,
                          //   textAlign: TextAlign.justify,
                          //   style: TextStyle(
                          //     fontWeight: bold,
                          //     fontSize: getWidth(16),
                          //   ),
                          // ),
                          // Text(
                          //   alurFill,
                          //   textAlign: TextAlign.justify,
                          //   style: TextStyle(
                          //     fontWeight: normal,
                          //     fontSize: getWidth(13.5),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: getHeight(20),
                          // ),
                          // SizedBox(
                          //   width: getWidth(350),
                          //   height: getHeight(50),
                          //   child: ListView.separated(
                          //       padding: EdgeInsets.zero,
                          //       itemCount: other.length,
                          //       shrinkWrap: true,
                          //       scrollDirection: Axis.horizontal,
                          //       itemBuilder: (BuildContext context, index) {
                          //         return SizedBox(
                          //           child: Image.asset(
                          //             '${other[index]['image']}',
                          //             width: getWidth(50),
                          //             height: getHeight(50),
                          //           ),
                          //         );
                          //       },
                          //       separatorBuilder: (context, index) {
                          //         return SizedBox(
                          //           width: getWidth(24.25),
                          //         );
                          //       }),
                          // ),

                          SizedBox(
                            height: getHeight(20),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                                height: 120,
                                width: double.infinity,
                                child: GoogleMap(
                                  mapType: MapType.normal,
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(
                                        widget.tempatWisata.latitude!,
                                        widget.tempatWisata.longitude!),
                                    zoom: 10,
                                  ),
                                  markers: <Marker>{
                                    Marker(
                                        markerId: MarkerId(
                                            widget.tempatWisata.id.toString()),
                                        position: LatLng(
                                            widget.tempatWisata.latitude!,
                                            widget.tempatWisata.longitude!),
                                        infoWindow: InfoWindow(
                                            title: widget.tempatWisata.nama))
                                  },
                                )),
                          ),
                          SizedBox(
                            height: getHeight(105),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: horpadding,
              width: getWidth(350),
              height: getHeight(50),
              margin: EdgeInsets.only(bottom: getHeight(20)),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [pink, ungu],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: shadow.withOpacity(0.5),
                        blurRadius: 50,
                        offset: const Offset(0, -13))
                  ]),
              child: InkWell(
                onTap: () {
                  Get.to(() => PsnPemandu(
                        pemandu: widget.tempatWisata.pemandu!,
                        tempatWisata: widget.tempatWisata,
                      ));
                },
                child: Center(
                  child: Text(
                    'Lihat Pemandu',
                    style: TextStyle(
                      color: putih,
                      fontWeight: bold,
                      fontSize: getWidth(16),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
