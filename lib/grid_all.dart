import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:hike_it/booking.dart';
import 'package:hike_it/constant.dart';
import 'package:hike_it/controllers/places_controllers.dart';
import 'package:hike_it/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

List listFavourite = [
  {
    'image': "assets/images/favourite/GlagahArum.jpg",
    'title': "Glagah Arum",
    'location': "Lumajang, Jawa Timur",
  },
  {
    'image': "assets/images/favourite/RanuKumbolo.jpg",
    'title': "Ranu Kumbolo",
    'location': "Lumajang, Jawa Timur",
  },
  {
    'image': "assets/images/favourite/RanuRegulo.jpg",
    'title': "Ranu Regulo",
    'location': "Lumajang, Jawa Timur",
  },
  {
    'image': "assets/images/favourite/Semeru.jpg",
    'title': "Gunung Semeru",
    'location': "Lumajang, Jawa Timur",
  },
  {
    'image': "assets/images/favourite/GlagahArum.jpg",
    'title': "Glagah Arum",
    'location': "Lumajang, Jawa Timur",
  },
  {
    'image': "assets/images/dashboard/grid-argopuro.jpg",
    'title': "Gunung Argopuro",
    'location': "Jember, Jawa Timur",
  },
  {
    'image': "assets/images/dashboard/grid-semeru.jpg",
    'title': "Gunung Semeru",
    'location': "Lumajang, Jawa Timur",
  },
  {
    'image': "assets/images/dashboard/grid-lemongan.jpg",
    'title': "Gunung Lemongan",
    'location': "Lumajang, Jawa Timur",
  },
];

class GridAll extends StatelessWidget {
  const GridAll({Key? key}) : super(key: key);

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
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                "assets/icons/dashboard/Search.svg",
              ),
            ),
          ],
          centerTitle: true,
          title: const Text(
            "Destinasi",
            style: TextStyle(
              color: hitam,
              fontSize: 20,
              fontWeight: bold,
            ),
          ),
        ),
        body: GetBuilder<PlacesController>(builder: (_) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(
                getHeight(10),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: AlignedGridView.count(
                        itemCount: _.listTempatWisata.length,
                        crossAxisCount: 2,
                        mainAxisSpacing: 6,
                        crossAxisSpacing: 6,
                        itemBuilder: (context, index) {
                          var tempatWisata = _.listTempatWisata[index];
                          return InkWell(
                            onTap: () => Get.to(() => Booking(
                                  tempatWisata: tempatWisata,
                                )),
                            child: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 20),
                              margin: const EdgeInsets.only(bottom: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: hitam.withOpacity(0.2),
                                    blurRadius: 1,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: AspectRatio(
                                        aspectRatio: 1.2,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "$baseURL/${tempatWisata.pictures![0].path}",
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              CircularProgressIndicator(
                                                  value: downloadProgress
                                                      .progress),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: getHeight(10),
                                  ),
                                  Text(
                                    tempatWisata.nama ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: getHeight(8),
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/icons/dashboard/Location.svg"),
                                      Expanded(
                                        child: Text(
                                          tempatWisata.alamat ?? '',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: normal,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
