import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hike_it/constant.dart';
import 'package:hike_it/controllers/users_controller.dart';
import 'package:hike_it/profile_menu/my_profile.dart';
import 'package:hike_it/sign/sign_in.dart';
import 'package:hike_it/theme.dart';
import 'package:get/get.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({Key? key}) : super(key: key);
  Widget menuButton({
    required String icon,
    required String title,
  }) {
    return Container(
      // margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: hitam.withOpacity(0.05),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: Container(
          width: getHeight(40),
          height: getHeight(40),
          padding: EdgeInsets.all(
            getHeight(8),
          ),
          decoration: const BoxDecoration(
            color: putih,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(icon),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        trailing: SvgPicture.asset(
          "assets/icons/profile/ArrowRight.svg",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          height: getHeight(20),
        ),
        GetBuilder<UsersController>(builder: (_) {
          return Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, gradient: gradient),
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: Colors.transparent,
                  child: CircleAvatar(
                    radius: 47.5,
                    backgroundColor: Colors.white,
                    child: _.userData?.profile != null
                        ? ClipOval(
                            child: CachedNetworkImage(
                              width: 85,
                              height: 85,
                              imageUrl: '$baseURL/${_.userData?.profile}',
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          )
                        : CircleAvatar(
                            backgroundImage: photoMbake,
                            radius: getHeight(42),
                          ),
                  ),
                ),
              ),
              const VerticalDivider(
                width: 20,
                thickness: 1,
                indent: 20,
                endIndent: 0,
                color: Colors.grey,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _.userData?.nama ?? '',
                    style: const TextStyle(
                      color: hitam,
                      fontSize: 20,
                      fontWeight: bold,
                    ),
                  ),
                  SizedBox(
                    height: getHeight(5),
                  ),
                  Text(
                    _.userData?.whatsapp ?? '',
                    style: const TextStyle(
                      color: hitam,
                      fontSize: 14,
                      fontWeight: light,
                    ),
                  ),
                ],
              )
            ],
          );
        }),
        SizedBox(
          height: getHeight(20),
        ),
        InkWell(
          onTap: () {
            Get.to(() => const MyProfile());
          },
          child: menuButton(
            icon: "assets/icons/profile/Profile.svg",
            title: "Edit Profile",
          ),
        ),
        SizedBox(
          height: getHeight(10),
        ),
        InkWell(
          onTap: () {
            // Get.to(() => const SelectionContent());
          },
          child: menuButton(
            icon: "assets/icons/profile/Chat.svg",
            title: "FAQ's",
          ),
        ),
        SizedBox(
          height: getHeight(10),
        ),
        InkWell(
          onTap: () {},
          child: menuButton(
            icon: "assets/icons/profile/Info.svg",
            title: "More Information",
          ),
        ),
        SizedBox(
          height: getHeight(10),
        ),
        InkWell(
          onTap: () {},
          child: menuButton(
            icon: "assets/icons/profile/Setting.svg",
            title: "Setting",
          ),
        ),
        const Spacer(),
        FractionallySizedBox(
          alignment: Alignment.bottomRight,
          widthFactor: 0.5,
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, getHeight(10)),
            decoration: BoxDecoration(
              color: const Color(0xFFD7263D).withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: InkWell(
              onTap: () {
                Get.offAll(() => const SignIn());
              },
              child: ListTile(
                leading: Container(
                  width: getHeight(40),
                  height: getHeight(40),
                  padding: EdgeInsets.all(
                    getHeight(8),
                  ),
                  decoration: const BoxDecoration(
                    color: putih,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    "assets/icons/profile/Logout.svg",
                  ),
                ),
                title: const Text(
                  "Sign Out",
                  style: TextStyle(
                    color: Color(0xFFD7263D),
                    fontSize: 18,
                    fontWeight: medium,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: getHeight(10),
        )
      ],
    );
  }
}
