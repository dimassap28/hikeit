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

class FavouriteContent extends StatelessWidget {
  const FavouriteContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: getHeight(20),
        ),
        Expanded(
          child: GetBuilder<PlacesController>(
              initState: (_) => PlacesController.to.getFavorite(),
              builder: (_) {
                return _.listTempatFavorit.isEmpty
                    ? const Center(
                        child: Text('Belum ada daftar tempat favorit'),
                      )
                    : Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            PlacesController.to.getFavorite();
                          },
                          child: AlignedGridView.count(
                            itemCount: _.listTempatFavorit.length,
                            crossAxisCount: 2,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 10,
                            itemBuilder: (context, index) {
                              var tempatWisata = _.listTempatFavorit[index];
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: AspectRatio(
                                            aspectRatio: 1.2,
                                            child:
                                                // Image.asset(
                                                //   '${grid[index]['image']}',
                                                //   width: double.infinity,
                                                //   fit: BoxFit.cover,
                                                // ),
                                                CachedNetworkImage(
                                              imageUrl:
                                                  "$baseURL/${tempatWisata.pictures![0].path}",
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                              errorWidget:
                                                  (context, url, error) =>
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
                      );
              }),
        ),
      ],
    );
  }
}
