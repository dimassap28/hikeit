import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hike_it/constant.dart';
import 'package:hike_it/controllers/users_controller.dart';
import 'package:hike_it/profile_menu/my_profile.dart';

import 'package:hike_it/theme.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UsersController>(builder: (_) {
      return Row(
        children: [
          InkWell(
            onTap: () {
              Get.to(() => const MyProfile());
            },
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: gradient,
              ),
              child: _.userData?.profile != null
                  ? ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: '$baseURL/${_.userData?.profile}',
                        fit: BoxFit.cover,
                        height: 45,
                        width: 45,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    )
                  : CircleAvatar(
                      radius: getHeight(22),
                      backgroundColor: Colors.transparent,
                      child: CircleAvatar(
                        radius: getHeight(20),
                        backgroundImage: photoMbake,
                      ),
                    ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Now you are in",
                style: TextStyle(fontSize: 12, fontWeight: normal),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                _.currentAddress ?? '',
                style: const TextStyle(fontSize: 16, fontWeight: bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          )),
          const SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {},
            child: SvgPicture.asset("assets/icons/dashboard/Notification.svg"),
          ),
        ],
      );
    });
  }
}
