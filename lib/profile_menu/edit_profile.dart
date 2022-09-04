import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hike_it/constant.dart';
import 'package:hike_it/controllers/users_controller.dart';
// import 'package:hike_it/profile_menu/my_profile.dart';
import 'package:hike_it/theme.dart';
import 'package:get/get.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);
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
        Container(
          padding: EdgeInsets.only(left: getHeight(20)),
          height: getHeight(48),
          decoration: BoxDecoration(
            color: abuAbu.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: const TextStyle(
                color: hitam,
                fontSize: 16,
                fontWeight: normal,
              ),
            ),
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
          title: const Text(
            "Edit Profil",
            style: TextStyle(
              color: hitam,
              fontSize: 20,
              fontWeight: bold,
            ),
          ),
        ),
        body: GetBuilder<UsersController>(
            initState: (_) => UsersController.to.inisiateForm(),
            builder: (_) {
              return SafeArea(
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
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
                                child: InkWell(
                                  onTap: () => _.pickImage(),
                                  child: _.profileImage != null
                                      ? ClipOval(
                                          child: Image.file(
                                            _.profileImage!,
                                            fit: BoxFit.cover,
                                            width: 100,
                                            height: 100,
                                          ),
                                        )
                                      : _.userData?.profile != null
                                          ? ClipOval(
                                              child: CachedNetworkImage(
                                                width: 100,
                                                height: 100,
                                                imageUrl:
                                                    '$baseURL/${_.userData?.profile}',
                                                fit: BoxFit.cover,
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
                                              ),
                                            )
                                          : CircleAvatar(
                                              radius: 64,
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: CircleAvatar(
                                                radius: 63.5,
                                                backgroundColor: Colors.white,
                                                child: InkWell(
                                                  child: Stack(
                                                    children: [
                                                      Center(
                                                        child: CircleAvatar(
                                                          backgroundImage:
                                                              photoMbake,
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
                            ),
                            SizedBox(
                              height: getHeight(20),
                            ),
                            const Text(
                              "Nama",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextField(
                              controller: _.editNama,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.black.withOpacity(1),
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
                                fillColor: abuAbu.withOpacity(0.15),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                hintText: 'Nama',
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.9),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: getHeight(20),
                            ),
                            const Text(
                              "No. Whatsapp",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextField(
                              controller: _.editWa,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.black.withOpacity(1),
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
                                fillColor: abuAbu.withOpacity(0.15),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                hintText: 'No. Whatsapp',
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.9),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: getHeight(20),
                            ),
                            const Text(
                              "Jenis Kelamin",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  color: abuAbu.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButton(
                                isExpanded: true,
                                underline: Container(),
                                value: _.userData?.gender ?? 'Laki-laki',
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: ['Laki-laki', 'Perempuan']
                                    .map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  _.gender = newValue ?? '';
                                  _.update();
                                },
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                _.updateProfile();
                              },
                              child: Container(
                                height: getHeight(54),
                                decoration: BoxDecoration(
                                  gradient: gradient,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Save Profile",
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
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
