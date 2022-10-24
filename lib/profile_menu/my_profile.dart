import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hike_it/constant.dart';
import 'package:hike_it/controllers/users_controller.dart';
import 'package:hike_it/profile_menu/edit_profile.dart';
import 'package:hike_it/theme.dart';
import 'package:get/get.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);
  Widget detailUser({
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: abuAbu,
            fontSize: 12,
            fontWeight: normal,
          ),
        ),
        SizedBox(
          height: getHeight(5),
        ),
        Text(
          value,
          style: const TextStyle(
            color: hitam,
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        SizedBox(
          height: getHeight(20),
        )
      ],
    );
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
            padding: EdgeInsets.all(
              getHeight(14),
            ),
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
          title: const Text(
            "Profil Saya",
            style: TextStyle(
              color: hitam,
              fontSize: 20,
              fontWeight: bold,
            ),
          ),
        ),
        body: GetBuilder<UsersController>(builder: (_) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(
                getHeight(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: gradient,
                    ),
                    child: Center(
                      child: CircleAvatar(
                        radius: getHeight(64),
                        backgroundColor: Colors.transparent,
                        child: CircleAvatar(
                          radius: getHeight(63.5),
                          backgroundColor: Colors.white,
                          child: InkWell(
                            child: Stack(
                              children: [
                                Center(
                                  child: _.userData?.profile != null
                                      ? ClipOval(
                                          child: CachedNetworkImage(
                                            width: 90,
                                            height: 90,
                                            imageUrl:
                                                '$baseURL/${_.userData?.profile}',
                                            fit: BoxFit.cover,
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                CircularProgressIndicator(
                                                    value: downloadProgress
                                                        .progress),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        )
                                      : CircleAvatar(
                                          backgroundImage: photoMbake,
                                          radius: getHeight(60),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(20),
                  ),
                  detailUser(
                    label: "Nama",
                    value: _.userData?.nama ?? '-',
                  ),
                  detailUser(
                    label: "No. HP",
                    value: _.userData?.whatsapp ?? '-',
                  ),
                  detailUser(
                    label: "Jenis Kelamin",
                    value: _.userData?.gender ?? '-',
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Get.to(() => const EditProfile());
                    },
                    child: Container(
                      height: getHeight(54),
                      decoration: BoxDecoration(
                        gradient: gradient,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "Edit Profile",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: bold,
                          ),
                        ),
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
